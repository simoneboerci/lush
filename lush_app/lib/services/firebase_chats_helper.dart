import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lush_app/models/firebase_chat_exception.dart';

import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/models/chat_model.dart';
import 'package:lush_app/models/message_model.dart';

// Interfaccia per FirebaseChatsHelper
abstract class IFirebaseChatsHelper {
  Future<ChatModel> createChatBetweenUsers(String user1Id, String user2Id);
  Stream<List<MessageModel>> getMessagesFromChat(String chatId);
  Future<void> sendMessage(String chatId, MessageModel message);
  Stream<List<ChatModel>> getUserChats(String userId);
  Future<void> updateMessage(String chatId, MessageModel message);
}

// Classe che gestisce le operazioni di chats e messaggi tramite utenti e firebase
class FirebaseChatsHelper implements IFirebaseChatsHelper {
  // Riferimento all'instanza di firebase
  final FirebaseFirestore _firestore;

  // Identificatore della collezione di chats nel database
  static const String firebaseChatsCollectionLabel = 'chats';

  // Costruttore che inizializza l'istanza di firebase
  FirebaseChatsHelper({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Metodo per creare una nuova chat nel database tra due utenti
  @override
  Future<ChatModel> createChatBetweenUsers(
      String user1Id, String user2Id) async {
    // Assicura che firebase sia inizializzato
    await FirebaseHelper().ensureInitialized();

    // Genera un id per la nuova chat
    String chatId = _generateChatId(user1Id, user2Id);

    // Crea la nuova chat
    ChatModel newChat = ChatModel(
      id: chatId,
      userIds: [user1Id, user2Id],
      messages: [],
    );

    try {
      // Inserisci la nuova chat nel database
      await _firestore
          .collection(firebaseChatsCollectionLabel)
          .doc(chatId)
          .set(newChat.toMap());

      // Ritorna la nuova chat
      return newChat;
    } catch (e) {
      throw FirebaseChatException('Failed to create chat: $e');
    }
  }

  // Genera un id univoco sempre uguale per la chat tra gli utenti
  // (indipendentemente dall'ordine in cui questi vengono passati)
  String _generateChatId(String user1Id, String user2Id) {
    // Combina gli id degli utenti disponendoli sempre in ordine alfabetico
    return user1Id.compareTo(user2Id) < 0
        ? '${user1Id}_$user2Id'
        : '${user2Id}_$user1Id';
  }

  // Ottieni una lista di messaggi a partire da una chat
  @override
  Stream<List<MessageModel>> getMessagesFromChat(String chatId) async* {
    // Assicura di inizializzare firebase
    await FirebaseHelper().ensureInitialized();

    // Ottieni la lista di messaggi della chat dal database
    yield* _firestore
        .collection(firebaseChatsCollectionLabel)
        .doc(chatId)
        .snapshots()
        .map(_parseMessagesFromSnapshot);
  }

  // Metodo per ottenere una lista di messaggi partendo dallo snapshot della
  // chat all'interno del database
  List<MessageModel> _parseMessagesFromSnapshot(DocumentSnapshot snapshot) {
    // Converte lo snapshot in una mappa di stringhe e valori dinamici
    var data = snapshot.data() as Map<String, dynamic>?;
    // Verifica che la mappa (chat) esista e che contenga una lista di messaggi
    if (data != null && data.containsKey(ChatModel.messagesLabel)) {
      // Crea una lista di oggetti dinamici (le mappe dei singoli messaggi)
      List<dynamic> messagesData = data[ChatModel.messagesLabel];
      // Ritorna una lista mappata di messaggi
      return messagesData
          .map((message) => MessageModel.fromMap(message))
          .toList();
    }

    // Se l'operazione non va a buon fine tirona una lista vuota
    return [];
  }

  // Invia un nuovo messaggio in chat - inserisci un nuovo messaggio in una chat del database
  @override
  Future<void> sendMessage(String chatId, MessageModel message) async {
    // Ottieni il riferimento alla chat corrispondente
    final chatRef =
        _firestore.collection(firebaseChatsCollectionLabel).doc(chatId);

    // Estrai l'array di messaggi
    final messageData = message.toMap();
    // Genera un id univoco per il nuovo messaggio
    final messageId = chatRef.collection(ChatModel.messagesLabel).doc().id;

    // Genera un id casuale per il messaggio corrente
    messageData[MessageModel.idLabel] = messageId;
    // Aggiorna lo stato del messaggio
    messageData[MessageModel.statusLabel] = MessageStatus.sent.toStringValue();

    try {
      // Aggiorna il database
      await chatRef.update({
        ChatModel.messagesLabel: FieldValue.arrayUnion([messageData]),
        ChatModel.lastMessageIdLabel: messageId,
        // Altri campi legati al messaggio
      });
    } catch (e) {
      throw FirebaseChatException('Failed to send message: $e');
    }
  }

  // Ottieni la lista di chat in cui l'utente è presente dal database
  @override
  Stream<List<ChatModel>> getUserChats(String userId) async* {
    // Assicura che firebase sia inizializzato
    await FirebaseHelper().ensureInitialized();

    // Ottieni la lista di chat dal database filtrandole per partecipanti
    yield* _firestore
        .collection(firebaseChatsCollectionLabel)
        .where(ChatModel.userIdsLabel, arrayContains: userId)
        .snapshots()
        // Mappa i dati in una lista di modelli di chat
        .map((snapshot) =>
            snapshot.docs.map((doc) => ChatModel.fromMap(doc.data())).toList());
  }

  // Aggiorna il messaggio di una chat nel database
  @override
  Future<void> updateMessage(String chatId, MessageModel message) async {
    // Assicura che Firebase sia inizializzato
    await FirebaseHelper().ensureInitialized();

    // Ottieni il documento della chat dal database
    final chatRef = _firestore
        .collection(FirebaseChatsHelper.firebaseChatsCollectionLabel)
        .doc(chatId);

    try {
      // Ottieni il documento della chat
      final docSnapshot = await chatRef.get();
      // Assicura che il documento esista
      if (!docSnapshot.exists) {
        throw FirebaseChatException('La chat con ID $chatId non esiste');
      }

      // Ottieni la lista di messaggi aggiornati
      final updatedMessages = _updateMessagesInList(
          docSnapshot.data()?[ChatModel.messagesLabel] ?? [], message);

      // Aggiorna la lista di messaggi nel database
      await chatRef.update({ChatModel.messagesLabel: updatedMessages});
    } catch (e) {
      throw FirebaseChatException('Failed to update message: $e');
    }
  }

  // Aggiorna un messaggio all'interno di una lista di messaggi
  List<Map<String, dynamic>> _updateMessagesInList(
      List<dynamic> messagesList, MessageModel updatedMessage) {
    // Mappa la lista di messaggi corrente per ottenere un lista di messaggi aggiornata
    final List<Map<String, dynamic>> updatedMessages = messagesList.map((item) {
      // Converti ogni messaggio (lista dinamica) in una mappa
      final messageMap = item as Map<String, dynamic>;
      // Converti ogni mappa (ogni messaggio) nell'oggetto corrispondente
      final existingMessage = MessageModel.fromMap(messageMap);
      // Sostituisci il messaggio vecchio con quello nuovo e mantieni invariati gli altri
      return existingMessage.id == updatedMessage.id
          ? updatedMessage.toMap()
          : messageMap;
    }).toList();

    // Se il messaggio da aggiornare non è presente nella lista
    if (updatedMessages
        .every((msg) => msg[MessageModel.idLabel] != updatedMessage.id)) {
      // Aggiungi un nuovo messaggio
      updatedMessages.add(updatedMessage.toMap());
    }

    // Ritorna la lista di messaggi aggiornata
    return updatedMessages;
  }
}
