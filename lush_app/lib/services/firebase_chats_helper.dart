import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/models/chat_model.dart';
import 'package:lush_app/models/message_model.dart';

// Classe che gestisce le operazioni di chats e messaggi tramite utenti e firebase
class FirebaseChatsHelper {
  // Identificatore della collezione di chats nel database
  static const String firebaseChatsCollectionLabel = 'chats';

  // Metodo per creare una nuova chat nel database tra due utenti
  Future<void> createChatBetweenUsers(String user1Id, String user2Id) async {
    // Assicura che firebase sia inizializzato
    await FirebaseHelper.ensureInitialized();

    // Genera un id univoco sempre uguale per la chat tra gli utenti
    // (indipendentemente dall'ordine in cui questi vengono passati)
    String chatId = user1Id.compareTo(user2Id) < 0
        ? '${user1Id}_$user2Id'
        : '${user2Id}_$user1Id';

    // Aggiorna il database
    await FirebaseFirestore.instance
        .collection(firebaseChatsCollectionLabel)
        .doc(chatId)
        .set({
      ChatModel.idLabel: chatId,
      ChatModel.userIdsLabel: [user1Id, user2Id],
      ChatModel.messagesLabel: [],
      // Altri campi legati alla chat
    });
  }

  // Ottieni una lista di messaggi a partire da una chat
  Stream<List<MessageModel>> getMessagesFromChat(String chatId) async* {
    // Assicura di inizializzare firebase
    await FirebaseHelper.ensureInitialized();

    // Ottieni la collezione di chats
    yield* FirebaseFirestore.instance
        .collection(firebaseChatsCollectionLabel)
        .doc(chatId)
        .snapshots()
        .map((snapshot) {
      // Estrai l'array di directMessage dal documento
      var data = snapshot.data();
      // Verifica che l'array di directMessage esista e non sia vuoto
      if (data != null && data.containsKey(ChatModel.messagesLabel)) {
        List<dynamic> messagesData = data[ChatModel.messagesLabel];
        // Converte ogni mappa di messaggi in un oggetto DirectMessage
        return messagesData
            .map((message) => MessageModel.fromMap(message))
            .toList();
      } else {
        // Se non ci sono messaggi, ritorna una lista vuota
        return <MessageModel>[];
      }
    });
  }

  // Invia un nuovo messaggio in chat - inserisci un nuovo messaggio in una chat del database
  Future<void> sendMessage(String chatId, MessageModel message) async {
    // Ottieni il riferimento alla chat corrispondente
    final chatRef = FirebaseFirestore.instance
        .collection(firebaseChatsCollectionLabel)
        .doc(chatId);

    // Estrai l'array di messaggi
    final messageData = message.toMap();

    // Genera un id casuale per il messaggio corrente
    messageData[MessageModel.idLabel] =
        chatRef.collection(ChatModel.messagesLabel).doc().id;

    // Aggiorna il database
    await chatRef.update({
      ChatModel.messagesLabel: FieldValue.arrayUnion([messageData]),
      ChatModel.lastMessageLabel: message,
      // Altri campi legati al messaggio
    });
  }

  // Ottieni la lista di chat in cui l'utente è presente
  Stream<List<ChatModel>> getUserChats(String userId) async* {
    // Assicura che firebase sia inizializzato
    await FirebaseHelper.ensureInitialized();

    // Ottieni la lista di chat dell'utente ordinata per il timestamp dell'ultimo messaggio
    yield* FirebaseFirestore.instance
        .collection(firebaseChatsCollectionLabel)
        .where(ChatModel.userIdsLabel, arrayContains: userId)
        .orderBy(ChatModel.lastMessageLabel, descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => ChatModel.fromMap(doc.data())).toList());
  }
}
