import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lush_app/features/horizontal_videos/domain/interfaces/video_player_interface.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer implements VideoPlayerInterface {
  final String videoUrl;
  final String thumbnailUrl;
  final Widget Function(BuildContext, CustomVideoPlayer)? controlsBuilder;
  final Widget Function(BuildContext, CustomVideoPlayer)? additionalComponents;
  final bool enablePreview;
  final int previewSegmentsCount;
  final int previewSegmentDuration;
  final bool autoPlay;
  final bool looping;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Function(LongPressEndDetails)? onLongPressEnd;

  late VideoPlayerController _controller;

  bool _isPreviewActive = false;
  bool _isFullscreen = false;
  double _previousVolume = 0.0;

  List<Duration>? _previewSegments;
  Timer? _previewTimer;

  CustomVideoPlayer({
    required this.videoUrl,
    required this.thumbnailUrl,
    this.controlsBuilder,
    this.additionalComponents,
    this.enablePreview = true,
    this.previewSegmentsCount = 5,
    this.previewSegmentDuration = 3,
    this.autoPlay = false,
    this.looping = false,
    this.onTap,
    this.onLongPress,
    this.onLongPressEnd,
  });

  VideoPlayerController get controller => _controller;

  @override
  bool get isInitialized => _controller.value.isInitialized;
  @override
  bool get isPlaying => _controller.value.isPlaying;

  @override
  Duration get videoDuration => _controller.value.duration;
  @override
  Duration get currentPosition => _controller.value.position;
  @override
  bool get isAtTheBeginning => _controller.value.position == Duration.zero;
  @override
  bool get isMute => _controller.value.volume == 0;
  @override
  double get aspectRatio => _controller.value.aspectRatio;

  @override
  bool get isPreviewActive => _isPreviewActive;
  @override
  bool get isFullscreen => _isFullscreen;

  @override
  Future<void> initialize() async {
    try {
      // Ricava l'url dalla stringa di testo
      final url = Uri.tryParse(videoUrl);

      // Assicurati che l'url sia corretto ed esista
      if (url == null) {
        throw Exception('An error occurred while getting the url: $videoUrl');
      }

      // Crea il controller video per l'url corrente
      _controller = VideoPlayerController.networkUrl(url);

      // Inizializza il controller
      await _controller.initialize();

      // Configura il controller
      _controller.setLooping(looping);

      // Se la modalità di autoplay è impostata fai partire il video
      if (autoPlay) play();

      // La la modalità preview è abilitata genera la lista di segmenti da mostrare
      if (enablePreview) await _generatePreviewSegments();
    } catch (e) {
      throw Exception('An error occurred while inizialising video player: $e');
    }
  }

  @override
  Future<void> togglePlayPause() async {
    // Fai partire o metti in pausa il video in base allo stato corrente
    return isPlaying ? await pause() : await play();
  }

  @override
  Future<void> play() async {
    // Assicurati che il video non stia già andando
    if (!isPlaying) {
      // Avvia il player video
      await _controller.play();
    }
  }

  @override
  Future<void> pause() async {
    // Assicurati che il video non stia già andando
    if (isPlaying) {
      // Metti in pausa il player video
      await _controller.pause();
    }
  }

  @override
  Future<void> stop() async {
    // Cancella il timer corrente
    _previewTimer?.cancel();

    // Resetta il player video
    await resetPlayer();

    // Aggiorna la variabile dedicata
    _isPreviewActive = false;
  }

  @override
  Future<void> increaseVolume(double volume) async {
    // Salva il volume corrente
    _previousVolume = _controller.value.volume;
    // Aumenta il volume
    await _controller.setVolume(volume);
  }

  @override
  Future<void> decreaseVolume(double volume) async {
    // Salva il volume corrente
    _previousVolume = _controller.value.volume;
    // Abbassa il volume
    await _controller.setVolume(volume);
  }

  @override
  Future<void> toggleFullscreen() async {
    // Metti il video a schermo interno o togli lo schermo intero in base allo stato corrente
    _isFullscreen ? await disableFullscreen() : await enableFullscreen();
  }

  @override
  Future<void> enableFullscreen() async {
    // Abilita la modalità a schermo intero
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    // Imposta l'orientamento predefinito orizzontale
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    // Aggiorna la variabile dedicata
    _isFullscreen = true;
  }

  @override
  Future<void> disableFullscreen() async {
    // Disabilita lo schermo intero
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // Imposta l'orientamento predefinito vertiale
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Aggiorna la variabile dedicata
    _isFullscreen = false;
  }

  @override
  Future<void> toggleMute() async {
    // Imposta il muto o toglilo a seconda dello stato corrente
    isMute ? await unmute() : await mute();
  }

  @override
  Future<void> mute() async {
    // Salva il volume corrente
    _previousVolume = _controller.value.volume;
    // Imposta il volume a zero
    await _controller.setVolume(0);
  }

  @override
  Future<void> unmute() async {
    // Reimposta il volume precedentemente salvato
    await _controller.setVolume(_previousVolume);
  }

  @override
  Future<void> seek(Duration position) async {
    // Vai alla posizione selezionata
    await _controller.seekTo(position);
  }

  @override
  Future<void> startPreview() async {
    // Assicurati che la modalità preview sia attivata
    if (!enablePreview) return;

    // Aggiorna la variabile dedicata
    _isPreviewActive = true;

    // Fai partire il primo segmento di preview
    _playPreviewSegmentWithId(0);
  }

  @override
  Future<void> stopPreview() async {
    // Assicurati che la modalità preview sia attivata
    if (!enablePreview) return;

    // Aggiorna la variabile dedicata
    _isPreviewActive = false;
  }

  @override
  Future<void> resetPlayer() async {
    // Stoppa il video
    pause();
    // Riporta all'inizio la progress bar
    await _controller.seekTo(Duration.zero);
  }

  @override
  Future<void> dispose() async {
    // Cancella il timer corrente
    _previewTimer?.cancel();
    // Rimuovi il controller dalla memoria
    await _controller.dispose();
  }

  Future<void> _generatePreviewSegments() async {
    // Crea un oggetto random
    final Random random = Random();
    // Inizializza la lista di segmenti della preview
    _previewSegments = [];
    // Assicurati che la durata del video sia superiore alla durata di ogni
    // Singolo segmento moltiplicato per il numero di segmenti
    if (videoDuration.inSeconds >
        previewSegmentDuration * previewSegmentsCount) {
      // Per ogni segmento di preview
      for (int i = 0; i < previewSegmentsCount; i++) {
        // Ottieni un numero di secondi di partenza casuale da 0 fino alla durata
        // Totale del video meno la durata del singolo segmento
        int startTime =
            random.nextInt(videoDuration.inSeconds - previewSegmentDuration);
        // Aggiungi il tempo di partenza alla lista dei segmenti
        _previewSegments!.add(Duration(seconds: startTime));
      }
      // Se invece il video è troppo breve per creare tutti i segmenti della durata definita
    } else {
      // Svuota la lista di segmenti creati
      _previewSegments!.clear();
      // Aggiungi un solo segmento alla lista che rappresenta l'inizio del video
      _previewSegments!.add(Duration.zero);
    }
  }

  Future<void> _playPreviewSegmentWithId(int index) async {
    // Assicurati che ci siano dei segmenti di video da riprodurre
    if (_previewSegments == null || _previewSegments!.isEmpty) {
      await _generatePreviewSegments();
    }
    // Assicurati che si stia mostrando la preview e che l'id
    // Del segmento passato rientri nella lista di segmenti creata
    // Altrimenti ferma la preview
    if (!isPreviewActive || index >= _previewSegments!.length) {
      await stopPreview();
      return;
    }

    // Vai al numero di secondi definito dal segmento corrente
    await _controller.seekTo(_previewSegments![index]);
    // Fai partire il video
    await play();

    // Fai partire un timer in base alla durata della clip di preview
    _previewTimer = Timer(Duration(seconds: previewSegmentDuration), () async {
      // E imposta una callback che faccia partire il segmento di preview successiva
      await _playPreviewSegmentWithId(index + 1);
    });
  }
}
