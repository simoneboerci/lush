import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lush_app/models/lush_credits_offer.dart';

class LushUser {
  final String userId;

  String? name;
  String? surname;
  String? fiscalCode;
  DateTime? birthDate;
  String? birthAddress;
  String? residenceAddress;
  String? username;
  String? email;
  String? password;
  String? phoneNumber;
  int lushTokensCount;
  List<String>? reedemedOffers;

  // Campi per le chat
  String? profilePictureUrl;
  DateTime? lastSeen;
  String? fcmToken; // Per le notifiche push
  List<String> activeChats;
  bool isOnline;

  LushUser({
    required this.userId,
    this.username,
    this.name,
    this.surname,
    this.fiscalCode,
    this.birthDate,
    this.birthAddress,
    this.residenceAddress,
    this.email,
    this.password,
    this.phoneNumber,
    this.lushTokensCount = 0,
    this.reedemedOffers = const [],
    this.profilePictureUrl,
    this.lastSeen,
    this.fcmToken,
    this.activeChats = const [],
    this.isOnline = false,
  });

  factory LushUser.copyWith({
    required LushUser user,
    String? name,
    String? surname,
    String? fiscalCode,
    DateTime? birthDate,
    String? birthAddress,
    String? residenceAddress,
    String? username,
    String? email,
    String? password,
    String? phoneNumber,
    int? lushTokens,
    List<String>? reedemedOffers,
    String? profilePictureUrl,
    DateTime? lastSeen,
    String? fcmToken,
    List<String>? activeChats,
    bool? isOnline,
  }) {
    return LushUser(
      userId: user.userId,
      name: name ?? user.name,
      surname: surname ?? user.surname,
      fiscalCode: fiscalCode ?? user.fiscalCode,
      birthDate: birthDate ?? user.birthDate,
      birthAddress: birthAddress ?? user.birthAddress,
      username: username ?? user.username,
      email: email ?? user.email,
      password: password ?? user.password,
      residenceAddress: residenceAddress ?? user.residenceAddress,
      phoneNumber: phoneNumber ?? user.phoneNumber,
      lushTokensCount: lushTokens ?? user.lushTokensCount,
      reedemedOffers: reedemedOffers ?? user.reedemedOffers,
      profilePictureUrl: profilePictureUrl ?? user.profilePictureUrl,
      lastSeen: lastSeen ?? user.lastSeen,
      fcmToken: fcmToken ?? user.fcmToken,
      activeChats: activeChats ?? user.activeChats,
      isOnline: isOnline ?? user.isOnline,
    );
  }

  factory LushUser.fromMap(Map<String, dynamic> map) {
    Timestamp birthDate = map['birth_date'];
    List<dynamic> redeemedOffersDynamic = map['reedemed_offers'];
    List<String> redeemedOffersString = [];
    for (int i = 0; i < redeemedOffersDynamic.length; i++) {
      redeemedOffersString.add(redeemedOffersDynamic[i].toString());
    }
    return LushUser(
      userId: map['userId'] ?? '',
      username: map['username'] ?? '',
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
      fiscalCode: map['fiscal_code'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      birthDate: birthDate.toDate(),
      birthAddress: map['birth_address'] ?? '',
      residenceAddress: map['residence_address'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
      lushTokensCount: map['lush_tokens_count'] ?? '',
      reedemedOffers: redeemedOffersString,
      profilePictureUrl: map['profile_picture_url'],
      lastSeen: map['last_seen'] != null
          ? (map['last_seen'] as Timestamp).toDate()
          : null,
      fcmToken: map['fcm_token'],
      activeChats:
          (map['active_chats'] as List<dynamic>?)?.cast<String>() ?? [],
      isOnline: map['is_online'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'name': name,
      'surname': surname,
      'fiscal_code': fiscalCode,
      'birth_date': birthDate,
      'birth_address': birthAddress,
      'residence_address': residenceAddress,
      'email': email,
      'password': password,
      'phone_number': phoneNumber,
      'lush_tokens_count': lushTokensCount,
      'reedemed_offers': reedemedOffers ?? [],
      'profile_picture_url': profilePictureUrl,
      'last_seen': lastSeen,
      'fcm_token': fcmToken,
      'active_chats': activeChats,
      'is_online': isOnline,
    };
  }

  void addLushTokens(int amount) => lushTokensCount += amount;

  bool subtractLushtokens(int amount) {
    if (lushTokensCount >= amount) {
      lushTokensCount -= amount;
      return false;
    } else {
      return true;
    }
  }

  bool redeemOffer(LushCreditsOffer offer) {
    if (reedemedOffers!.contains(offer.id)) {
      return false;
    } else {
      reedemedOffers!.add(offer.id);
      return true;
    }
  }

  // Metodi per la gestione delle chat
  void addActiveChat(String chatId) {
    if (!activeChats.contains(chatId)) {
      activeChats.add(chatId);
    }
  }

  void removeActiveChat(String chatId) {
    activeChats.remove(chatId);
  }

  void updateLastSeen() {
    lastSeen = DateTime.now();
  }

  void setOnlineStatus(bool status) {
    isOnline = status;
    if (status) {
      updateLastSeen();
    }
  }

  void updateFcmToken(String newToken) {
    fcmToken = newToken;
  }
}
