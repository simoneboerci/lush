import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class FlexibleVideoPlayerViewModel extends ChangeNotifier {
  final String videoUrl;
  final String thumnailUrl;
  final Widget Function(BuildContext, FlexibleVideoPlayerViewModel)?
      controlsBuilder;
  final Widget Function(BuildContext, FlexibleVideoPlayerViewModel)?
      additionalComponents;
  final bool enablePreview;
  final int previewSegmentsCount;
  final int previewSegmentDuration;
  final bool autoPlay;
  final bool looping;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Function(LongPressEndDetails)? onLongPressEnd;

  late VideoPlayerController controller;

  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _isPreviewActive = false;
  bool _isAtTheBeginning = true;
  bool _isFullscreen = false;

  int? _videoDuration;

  List<Duration>? _previewSegments;
  Timer? _previewTimer;

  FlexibleVideoPlayerViewModel({
    required this.videoUrl,
    required this.thumnailUrl,
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
  }) {
    initializePlayer();
  }

  // Ottieni lo stato di inizializzazione del controller corrente
  bool get isInitialized => _isInitialized;
  // Ottieni lo stato di play del controller corrente;
  bool get isPlaying => _isPlaying;
  // Ottieni lo stato di preview del controller corrente;
  bool get isPreviewActive => _isPreviewActive;
  // Verifica se il video è all'inizio della progress bar
  bool get isAtTheBeginning => _isAtTheBeginning;
  // Verifica se il video è in fullscreen
  bool get isFullscreen => _isFullscreen;
  // Ottieni la durata del video corrente
  int get videoDuration => _videoDuration!;

  // Inizializza il player video
  Future<void> initializePlayer() async {
    try {
      // Ricava l'url dalla stringa di testo
      final url = Uri.tryParse(videoUrl);

      // Assicurati che l'url sia corretto ed esista
      if (url == null) {
        throw Exception('An error occurred while getting the url: $videoUrl');
      }

      // Crea il controller video per l'url corrente
      controller = VideoPlayerController.networkUrl(url);

      // Inizializza il controller
      await controller.initialize();

      // Salva la durata del video corrente
      _videoDuration = controller.value.duration.inSeconds;

      // Configura il controller
      controller.setLooping(looping);

      // Se la modalità di autoplay è impostata fai partire il video
      if (autoPlay) play();

      // La la modalità preview è abilitata genera la lista di segmenti da mostrare
      if (enablePreview) await _generatePreviewSegments();

      // Aggiorna la variabile dedicata
      _isInitialized = true;

      // Notifica i listeners
      notifyListeners();
    } catch (e) {
      throw Exception('An error occurred while inizialising video player: $e');
    }
  }

  void toggleFullscreen() =>
      _isFullscreen ? disableFullscreen() : enableFullscreen();

  void enableFullscreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    _isFullscreen = true;
  }

  void disableFullscreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _isFullscreen = false;
  }

  // Fai partire il video o mettilo in pausa a seconda dello stato corrente
  Future<void> togglePlayPause() async =>
      _isPlaying ? await pause() : await play();

  // Fai partire il video
  Future<void> play() async {
    // Assicurati che il video non stia già andando
    if (!_isPlaying) {
      // Avvia il player video
      await controller.play();
      // Aggiorno le variabili dedicate
      _isPlaying = true;
      _isAtTheBeginning = false;
      // Notifica i listeners
      notifyListeners();
    }
  }

  // Metti in pausa il video
  Future<void> pause() async {
    // Assicurati che il video non stia già andando
    if (_isPlaying) {
      // Metti in pausa il player video
      await controller.pause();
      // Aggiorna la variabile dedicata
      _isPlaying = false;
      // Notifica i listeners
      notifyListeners();
    }
  }

  // Fai partire la preview del video
  void startPreview() {
    // Assicurati che la modalità preview sia attivata
    if (!enablePreview) return;

    // Aggiorna la variabile dedicata
    _isPreviewActive = true;

    // Fai partire il primo segmento di preview
    _playPreviewSegmentWithId(0);

    // Notifica i listener
    notifyListeners();
  }

  // Interrompi la preview del video
  void stopPreview() {
    // Cancella il timer corrente
    _previewTimer?.cancel();

    // Resetta il player video
    _resetPlayer();

    // Aggiorna la variabile dedicata
    _isPreviewActive = false;

    // Notifica i listeners
    notifyListeners();
  }

  // Libera la memoria a fine uso
  @override
  void dispose() {
    // Cancella il timer corrente
    _previewTimer?.cancel();
    // Rimuovi il controller dalla memoria
    controller.dispose();
    // Chiama il metodo dispose della classe padre
    super.dispose();
  }

  // Genera una lista di segmenti (secondi di partenza) per ogni pezzo della preview
  Future<void> _generatePreviewSegments() async {
    // Crea un oggetto random
    final Random random = Random();
    // Inizializza la lista di segmenti della preview
    _previewSegments = [];
    // Assicurati che la durata del video sia superiore alla durata di ogni
    // Singolo segmento moltiplicato per il numero di segmenti
    if (videoDuration > previewSegmentDuration * previewSegmentsCount) {
      // Per ogni segmento di preview
      for (int i = 0; i < previewSegmentsCount; i++) {
        // Ottieni un numero di secondi di partenza casuale da 0 fino alla durata
        // Totale del video meno la durata del singolo segmento
        int startTime = random.nextInt(videoDuration - previewSegmentDuration);
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

  // Fai partire il segmento di preview corrispondente all'id
  Future<void> _playPreviewSegmentWithId(int index) async {
    // Assicurati che ci siano dei segmenti di video da riprodurre
    if (_previewSegments == null || _previewSegments!.isEmpty) {
      await _generatePreviewSegments();
    }
    // Assicurati che si stia mostrando la preview e che l'id
    // Del segmento passato rientri nella lista di segmenti creata
    // Altrimenti ferma la preview
    if (!isPreviewActive || index >= _previewSegments!.length) {
      stopPreview();
      return;
    }

    // Vai al numero di secondi definito dal segmento corrente
    controller.seekTo(_previewSegments![index]);
    // Fai partire il video
    play();

    // Fai partire un timer in base alla durata della clip di preview
    _previewTimer = Timer(Duration(seconds: previewSegmentDuration), () async {
      // E imposta una callback che faccia partire il segmento di preview successiva
      await _playPreviewSegmentWithId(index + 1);
    });
  }

  // Resetta il player video
  void _resetPlayer() {
    // Stoppa il video
    pause();
    // Riporta all'inizio la progress bar
    controller.seekTo(Duration.zero);
    // Aggiorna la variabile dedicata
    _isAtTheBeginning = true;
  }
}
