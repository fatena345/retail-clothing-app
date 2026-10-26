import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  const UserModel({
    required this.uid,
    required this.email,
    this.name,
    this.avatarUrl,
    this.fcmToken,
    this.createdAt,
  });

  final String uid;
  final String email;
  final String? name;
  final String? avatarUrl;
  final String? fcmToken;
  final DateTime? createdAt;

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        uid: map['uid'] as String,
        email: map['email'] as String? ?? '',
        name: map['name'] as String?,
        avatarUrl: map['avatarUrl'] as String?,
        fcmToken: map['fcmToken'] as String?,
        createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
      );

  Map<String, dynamic> toCreateMap() => {
        'uid': uid,
        'email': email,
        'name': name,
        'avatarUrl': avatarUrl,
        'fcmToken': fcmToken,
        'createdAt': FieldValue.serverTimestamp(),
      };

  /// للتعديل من شاشة البروفايل (بدون uid/email/createdAt/fcmToken)
  Map<String, dynamic> toProfileUpdateMap() => {
        'name': name,
        'avatarUrl': avatarUrl,
      };
}