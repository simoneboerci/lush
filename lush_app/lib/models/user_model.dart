import 'package:lush_app/models/user_chat_info_model.dart';
import 'package:lush_app/models/user_contact_info_model.dart';
import 'package:lush_app/models/user_personal_info_model.dart';
import 'package:lush_app/models/user_purchase_info_model.dart';

class UserModel {
  final String id;
  final UserPersonalInfoModel personalInfo;
  final UserContactInfoModel contactInfo;
  final UserChatInfoModel chatInfo;
  final UserPurchaseInfoModel purchaseInfo;

  static const String idLabel = 'id';
  static const String personalInfoLabel = 'personal_info';
  static const String contactInfoLabel = 'contact_info';
  static const String chatInfoLabel = 'chat_info';
  static const String purchaseInfoLabel = 'purchase_info';

  UserModel({
    required this.id,
    required this.personalInfo,
    required this.contactInfo,
    required this.chatInfo,
    required this.purchaseInfo,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map[idLabel] ?? '',
      personalInfo: UserPersonalInfoModel.fromMap(map[personalInfoLabel]),
      contactInfo: UserContactInfoModel.fromMap(map[contactInfoLabel]),
      chatInfo: UserChatInfoModel.fromMap(map[chatInfoLabel]),
      purchaseInfo: UserPurchaseInfoModel.fromMap(map[purchaseInfoLabel]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      idLabel: id,
      personalInfoLabel: personalInfo.toMap(),
      contactInfoLabel: contactInfo.toMap(),
      chatInfoLabel: chatInfo.toMap(),
      purchaseInfoLabel: purchaseInfo.toMap(),
    };
  }

  UserModel copyWith({
    String? id,
    UserPersonalInfoModel? personalInfo,
    UserContactInfoModel? contactInfo,
    UserChatInfoModel? chatInfo,
    UserPurchaseInfoModel? purchaseInfo,
  }) {
    return UserModel(
      id: id ?? this.id,
      personalInfo: personalInfo ?? this.personalInfo,
      contactInfo: contactInfo ?? this.contactInfo,
      chatInfo: chatInfo ?? this.chatInfo,
      purchaseInfo: purchaseInfo ?? this.purchaseInfo,
    );
  }
}
