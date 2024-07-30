import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:lush_app/features/chat/domain/entities/message.dart';

@immutable
class Chat extends Equatable {
  // L'id della chat
  final String id;
  // L'id dell'owner (in una chat one to one il creato) della chat
  final String ownerId;
  // Lista di id dei partecipanti (owner compreso)
  final List<String> participantIds;
  // Lista di messaggi all'interno della chat
  final List<Message> messages;
  // Lista di id dei messaggi pinnati della chat
  final List<String> pinnedMessageIds;
  // Lista di id degli utenti che hanno messo questa chat tra le preferite
  final List<String> favoriteBy;
  // Lista di id degli utenti che hanno messo questa chat tra le archiviate
  final List<String> archivedBy;
  // Lista di id degli utenti che hanno pinnato questa chat
  final List<String> pinnedBy;

  // Ottieni un booleano che spiega se la chat corrente è una chat di gruppo
  bool get isGroupChat => participantIds.length > 2;
  // Ottieni l'ultimo messaggio inviato
  Message get lastMessage => messages.last;
  // Ottieni l'id dell'ultimo messaggio pinnato
  String get lastPinnedMessageId => pinnedMessageIds.last;

  const Chat({
    required this.ownerId,
    required this.id,
    required this.participantIds,
    this.messages = const [],
    this.pinnedMessageIds = const [],
    this.favoriteBy = const [],
    this.archivedBy = const [],
    this.pinnedBy = const [],
  });

  // Ritorna vero se l'utente selezionato ha aggiunto al chat alle preferite
  bool isFavoriteByUser(String userId) => favoriteBy.contains(userId);
  // Ritorna vero se l'utente selezionato ha archiviato la chat
  bool isArchivedByUser(String userId) => archivedBy.contains(userId);
  // ritorna vero se l'utente selezionato ha pinnato la chat
  bool isPinnedByUser(String userId) => pinnedBy.contains(userId);

  @override
  List<Object?> get props =>
      [id, ownerId, participantIds, messages, pinnedMessageIds, favoriteBy];
}
