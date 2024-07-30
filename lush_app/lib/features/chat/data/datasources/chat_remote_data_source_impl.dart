import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lush_app/core/constants/firebase_collections_labels.dart';
import 'package:lush_app/core/exceptions/chat_remote_exceptions.dart';
import 'package:lush_app/core/exceptions/message_remote_exceptions.dart';
import 'package:lush_app/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:lush_app/features/chat/data/models/chat_model.dart';
import 'package:lush_app/features/chat/data/models/message_model.dart';
import 'package:lush_app/features/chat/domain/entities/message.dart';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore _firestore;

  ChatRemoteDataSourceImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Ottieni il riferimento ad una chat nel database
  DocumentReference<Map<String, dynamic>> _getChatRef(String chatId) {
    return _firestore.collection(FirebaseCollectionsLabels.chats).doc(chatId);
  }

  // Ottieni uno snapshot di una chat dal database
  Future<DocumentSnapshot<Map<String, dynamic>>> _getChatSnapshot(
      String chatId) async {
    return await _firestore
        .collection(FirebaseCollectionsLabels.chats)
        .doc(chatId)
        .get();
  }

  // Ottieni il modello di una chat dal database in base all'id
  @override
  Future<ChatModel?> getChatById(String chatId) async {
    try {
      // Ottieni uno snapshot della chat dal database
      final chatSnapshot = await _getChatSnapshot(chatId);

      // Assicurati che lo snapshot esista e che contenga dati
      if (!chatSnapshot.exists || chatSnapshot.data() == null) {
        throw ChatNotFoundException(chatId: chatId);
      }

      // Ritorna il modello di chat corrispondente allo snapshot
      return ChatModel.fromMap(chatSnapshot.data()!);
    } catch (e) {
      throw ChatNotFoundException(chatId: chatId);
    }
  }

  // Ottieni la lista di messaggi da una chat
  @override
  Future<List<MessageModel>> getChatMessages(String chatId) async {
    try {
      // Ottieni il modello della chat richiesta dal database
      final ChatModel? chatModel = await getChatById(chatId);

      // Assicurati che la chat esista
      if (chatModel == null) {
        throw MessageNotFoundException(chatId: chatId);
      }

      // Ritorna la lista di messaggi
      return chatModel.messages;
    } catch (e) {
      throw ChatMessagesException(chatId: chatId);
    }
  }

  // Crea una nuova chat di gruppo o one to one
  @override
  Future<ChatModel> createChat(
      String user1Id, List<String> otherUserIds) async {
    try {
      // Assicurati che la lista di utenti non sia vuota
      if (otherUserIds.isEmpty) {
        throw ChatCreationException();
      }

      // Aggiungi l'utente che crea la chat alla lista dei partecipanti
      final List<String> participantIds = List<String>.from(otherUserIds)
        ..add(user1Id);

      // Metti la lista in ordina alfabetico
      participantIds.sort();

      // Crea un modello di chat one to one inizializzando i parametri
      final oneToOneChatModel = ChatModel(
        id: participantIds.join('_'),
        ownerId: user1Id,
        participantIds: participantIds,
      );

      // Ottieni il riferimento della collezione di chat su firebase
      final chatRef =
          _firestore.collection(FirebaseCollectionsLabels.chats).doc();

      // Crea il documento partendo dalla chat one to one
      await chatRef.set(oneToOneChatModel.toMap());

      // Verifica se la chat è una chat di gruppo
      if (otherUserIds.length > 1) {
        // Crea un nuovo modello di chat mettendo l'id del documento firebase
        // invece dell'id basato sui partecipanti
        final oneToManyChatModel = ChatModel(
          id: chatRef.id,
          ownerId: user1Id,
          participantIds: participantIds,
        );

        // Aggiorna il documento in caso in cui la chat sia di gruppo
        await chatRef.update(oneToManyChatModel.toMap());

        // Ritorna il modello di chat di gruppo
        return oneToManyChatModel;
      }

      // Ritorna il modello di chat one to one
      return oneToOneChatModel;
    } catch (e) {
      throw ChatCreationException();
    }
  }

  // Rimuovi uno o più utenti dalla lista di partecipanti ad una chat specifica
  @override
  Future<void> kickOutUsersFromChat(String chatId, List<String> userIds) async {
    try {
      // Assicurati che la lista di utenti da rimuovere non sia vuota
      if (userIds.isEmpty) return;

      // Ottieni il modello della chat selezionata
      ChatModel? chatModel = await getChatById(chatId);

      // Assicurati che il modello della chat esista
      if (chatModel == null) {
        throw ChatNotFoundException(chatId: chatId);
      }

      // Crea una nuova lista di partecipanti rimuovendo quelli presenti nella lista passata come parametro
      List<String> updatedParticipantIds = List<String>.from(chatModel
          .participantIds
          .where((participant) => !userIds.contains(participant)));

      // Aggiorna la lista di partecipanti nel database
      await _getChatRef(chatId)
          .update({ChatModelField.participantIds: updatedParticipantIds});
    } catch (e) {
      throw ChatKickOutException(chatId: chatId);
    }
  }

  // Aggiungi la chat alla lista di chat archiviate per gli utenti selezionati
  @override
  Future<void> archiveChatForUsers(String chatId, List<String> userIds) async {
    try {
      // Assicurati che la lista di id utente passata non sia vuota
      if (userIds.isEmpty) {
        throw ChatAddToArchiveException(chatId: chatId);
      }

      // Ottieni un riferimento alla chat
      final chatRef = _getChatRef(chatId);

      // Ottieni uno snapshot della chat
      final chatSnapshot = await chatRef.get();

      // Assicurati che lo snapshot esista e che contenga dati
      if (!chatSnapshot.exists || chatSnapshot.data() == null) {
        throw ChatNotFoundException(chatId: chatId);
      }

      // Ottieni la lista di partecipanti alla chat
      final List<String> participantIds =
          chatSnapshot[ChatModelField.participantIds.name];
      // Ottieni un set (per evitare duplicati all'interno) di id utente che ha archiviato la chat
      final Set<String> archivedBy =
          Set<String>.from(chatSnapshot[ChatModelField.archivedBy.name]);

      // Per ogni utente passato verifica che questo sia tra i partecipanti della chat
      // e che non abbia già aggiunto la chat alla lista di chat archiviate
      for (final String userId in userIds) {
        if (participantIds.contains(userId)) {
          archivedBy.add(userId);
        }
      }

      // Aggiorna la lista di id utente che hanno archiviato la chat nel database
      await chatRef.update({ChatModelField.archivedBy: archivedBy.toList()});
    } catch (e) {
      throw ChatAddToArchiveException(chatId: chatId);
    }
  }

  // Rimuovi la chat dalla lista di chat archiviate per gli utenti selezionati
  @override
  Future<void> deArchiveChatForUsers(
      String chatId, List<String> userIds) async {
    try {
      // Assicurati che la lista di id utente passati non sia vuota
      if (userIds.isEmpty) {
        throw ChatRemoveFromArchiveException(chatId: chatId);
      }

      // Ottieni un riferimento alla chat
      final chatRef = _getChatRef(chatId);

      // Ottieni uno snapshot della chat
      final chatSnapshot = await chatRef.get();

      // Assicurati che lo snapshot esista e che contenga dati
      if (!chatSnapshot.exists || chatSnapshot.data() == null) {
        throw ChatNotFoundException(chatId: chatId);
      }

      // Ottieni la lista di partecipanti alla chat
      final List<String> participantIds =
          chatSnapshot[ChatModelField.participantIds.name];
      // Ottieni un set (per evitare duplicati) di id utenti che hanno già archiviato la chat
      final Set<String> archivedBy =
          Set<String>.from(chatSnapshot[ChatModelField.archivedBy.name]);

      // Per ogni utente passato verifica che questo sia tra i partecipanti della chat
      // e che non abbia già rimosso la chat alla lista di chat preferite
      for (final String userId in userIds) {
        if (participantIds.contains(userId) && archivedBy.contains(userId)) {
          archivedBy.remove(userId);
        }
      }

      // Aggiorna la lista di id utente che ha archiviato la chat
      await chatRef.update({ChatModelField.archivedBy: archivedBy.toList()});
    } catch (e) {
      throw ChatRemoveFromArchiveException(chatId: chatId);
    }
  }

  // Mantieni la chat ma cancella tutti i messaggi al suo interno
  @override
  Future<void> cleanChat(String chatId) async {
    try {
      // Ottieni il riferimento alla chat
      final chatRef = _getChatRef(chatId);

      // Cancella i messaggi salvati all'interno della chat
      await chatRef.update({ChatModelField.messages: {}});
    } catch (e) {
      throw ChatCleanException(chatId: chatId);
    }
  }

  // Cancella la chat e tutti i dati al suo interno
  @override
  Future<void> deleteChat(String chatId) async {
    try {
      // Ottieni il riferimento alla chat
      final chatRef = _getChatRef(chatId);

      // Cancella la chat dal database
      await chatRef.delete();
    } catch (e) {
      throw ChatDeleteException(chatId: chatId);
    }
  }

  // Trasferisci la proprietà di una chat ad un altro utente
  @override
  Future<void> trasferChatOwnership(String chatId, String userId) async {
    try {
      //TODO: Verifica che l'utente esista nel detabase

      // Ottieni il modello realitvo alla chat richiesta
      final ChatModel? chatModel = await getChatById(chatId);

      // Assicurati che la chat esista
      if (chatModel != null) {
        throw ChatNotFoundException(chatId: chatId);
      }

      // Assicurati che il nuovo owner non sia già quello corrente
      if (chatModel!.ownerId != userId) return;

      // Assicurati che il nuovo owner sia un partecipante della chat
      if (!chatModel.participantIds.contains(userId)) {
        throw ChatOwnershipTransferException(chatId: chatId, userId: userId);
      }

      // Aggiorna la proprietà della chat nel database impostando come proprietario il nuovo utente
      await _getChatRef(chatId).update({ChatModelField.ownerId: userId});
    } catch (e) {
      throw ChatOwnershipTransferException(chatId: chatId, userId: userId);
    }
  }

  // Aggiungi la chat alla lista di chat preferite di uno o più utenti
  @override
  Future<void> addChatToFavorite(String chatId, List<String> userIds) async {
    try {
      // Ottieni il modello della chat corrispondente
      final ChatModel? chatModel = await getChatById(chatId);

      // Assicurati che la chat esista
      if (chatModel == null) {
        throw ChatNotFoundException(chatId: chatId);
      }

      // Crea una nuova lista di preferiti a partire da quella attuale della chat
      List<String> updatedFavorites = chatModel.favoriteBy;

      // Aggiungi i nuovi utenti alla lista di persone che hanno aggiunto la
      // chat ai preferiti se non ne fanno già parte ma partecipano alla chat
      for (final String userId in userIds) {
        if (chatModel.participantIds.contains(userId) &&
            !updatedFavorites.contains(userId)) {
          updatedFavorites.add(userId);
        }
      }

      // Aggiorna la lista di preferiti nel database
      await _getChatRef(chatId)
          .update({ChatModelField.favoriteBy: updatedFavorites});
    } catch (e) {
      throw ChatAddToFavoriteException(chatId: chatId);
    }
  }

  // Rimuovi la chat dalla lista delle chat preferite di uno o più utenti
  @override
  Future<void> removeChatFromFavorite(
      String chatId, List<String> userIds) async {
    try {
      // Ottieni il modello della chat corrispondente
      final ChatModel? chatModel = await getChatById(chatId);

      // Assicurati che la chat esista
      if (chatModel == null) {
        throw ChatNotFoundException(chatId: chatId);
      }

      // Crea una nuova lista di preferiti partendo da quella attuale
      List<String> updatedFavorites = chatModel.favoriteBy;

      // Per ogni utente passato assicurati che faccia parte dei partecipanti alla chat
      // e che non abbia aggiunto la chat ai preferti. Se è così aggiungilo alla lista di preferiti
      for (final String userId in userIds) {
        if (chatModel.participantIds.contains(userId) &&
            !updatedFavorites.contains(userId)) {
          updatedFavorites.add(userId);
        }
      }

      // Aggiorna la mappa di preferiti nel database
      await _getChatRef(chatId)
          .update({ChatModelField.favoriteBy: updatedFavorites});
    } catch (e) {
      throw ChatRemoveFromFavoriteException(chatId: chatId);
    }
  }

  @override
  Future<void> pinChatForUsers(String chatId, List<String> userIds) async {
    try {
      // Assicurati che la lista di utenti passata non sia vuota
      if (userIds.isEmpty) {
        throw ChatPinException(chatId: chatId);
      }

      // Ottieni un riferimento alla chat
      final chatRef = _getChatRef(chatId);

      // Ottieni lo snapshot della chat
      final chatSnapshot = await chatRef.get();

      // Assicurati che lo snapshot esista e che contenga dati
      if (!chatSnapshot.exists || chatSnapshot.data() == null) {
        throw ChatPinException(chatId: chatId);
      }

      // Ottieni la lista di partecipanti alla chat
      List<String> participantIds =
          chatSnapshot[ChatModelField.participantIds.name];

      // Ottieni la lista di id utente che ha già pinnato la chat
      Set<String> pinnedBy =
          Set<String>.from(chatSnapshot[ChatModelField.pinnedBy.name]);

      // Per ogni utente passato verifica che l'utente sia un partecipante della chat
      // e che non abbia già aggiunto la chat alla lista di chat pinnate
      for (final String userId in userIds) {
        if (participantIds.contains(userId)) {
          pinnedBy.add(userId);
        }
      }

      // Aggiorna la lista di id utenti che hanno piannto la chat nel database
      await chatRef.update({ChatModelField.pinnedBy.name: pinnedBy});
    } catch (e) {
      throw ChatPinException(chatId: chatId);
    }
  }

  @override
  Future<void> unpinChatForUsers(String chatId, List<String> userIds) async {
    try {
      // Assicurati che la lista di utenti passata non sia vuota
      if (userIds.isEmpty) {
        throw ChatPinException(chatId: chatId);
      }

      // Ottieni un riferimento alla chat
      final chatRef = _getChatRef(chatId);

      // Ottieni lo snapshot della chat
      final chatSnapshot = await chatRef.get();

      // Assicurati che lo snapshot esista e che contenga dati
      if (!chatSnapshot.exists || chatSnapshot.data() == null) {
        throw ChatPinException(chatId: chatId);
      }

      // Ottieni la lista di partecipanti alla chat
      List<String> participantIds =
          chatSnapshot[ChatModelField.participantIds.name];

      // Ottieni la lista di id utente che ha già pinnato la chat
      Set<String> pinnedBy =
          Set<String>.from(chatSnapshot[ChatModelField.pinnedBy.name]);

      // Per ogni utente passato verifica che l'utente sia un partecipante della chat
      // e che abbia già aggiunto la chat alla lista di chat pinnate
      for (final String userId in userIds) {
        if (participantIds.contains(userId) && pinnedBy.contains(userId)) {
          pinnedBy.remove(userId);
        }
      }

      // Aggiorna la lista di id utenti che hanno piannto la chat nel database
      await chatRef.update({ChatModelField.pinnedBy.name: pinnedBy});
    } catch (e) {
      throw ChatPinException(chatId: chatId);
    }
  }

  // Aggiungi un messaggio alla lista di messaggi di una chat nel database
  @override
  Future<void> sendMessage(String chatId, MessageModel message) async {
    try {
      // Ottieni il riferimento alla chat
      final chatRef = _getChatRef(chatId);

      // Genera un id univoco per il nuovo messaggio
      final messageId =
          chatRef.collection(ChatModelField.messages.name).doc().id;

      // Aggiorna le varibili del messaggio per l'invio
      final MessageModel updatedMessage = message.copyWith(
        id: messageId,
        status: MessageStatus.sent,
      );

      // Aggiungi la mappa del messaggio alla lista di messaggi della chat nel database
      await chatRef.update({
        ChatModelField.messages.name:
            FieldValue.arrayUnion([updatedMessage.toMap()]),
      });
    } catch (e) {
      throw ChatSendMessageException(chatId: chatId, message: message.id);
    }
  }
}
