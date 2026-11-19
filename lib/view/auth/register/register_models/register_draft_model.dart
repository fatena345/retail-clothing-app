import 'package:geeta/view/auth/register/register_controllers/register_draft_controller.dart';

class RegisterDraftModel {
  const RegisterDraftModel({
    required this.email,
    required this.name,
    required this.commercialName,
    required this.commercialAccount,
    required this.storeLicensePath,
  });

  final String email;
  final String name;
  final String commercialName;
  final String commercialAccount;
  final String storeLicensePath;

  
  bool get isEmpty =>
      email.isEmpty &&
      name.isEmpty &&
      commercialName.isEmpty &&
      commercialAccount.isEmpty &&
      storeLicensePath.isEmpty;

  Map<String, dynamic> toMap() => {
        'id': RegisterDraftController.draftId,
        'email': email,
        'name': name,
        'commercialName': commercialName,
        'commercialAccount': commercialAccount,
        'storeLicensePath': storeLicensePath,
      };

  factory RegisterDraftModel.fromMap(Map<String, Object?> map) =>
      RegisterDraftModel(
        email: map['email'] as String? ?? '',
        name: map['name'] as String? ?? '',
        commercialName: map['commercialName'] as String? ?? '',
        commercialAccount: map['commercialAccount'] as String? ?? '',
        storeLicensePath: map['storeLicensePath'] as String? ?? '',
      );
}