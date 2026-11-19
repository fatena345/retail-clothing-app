import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geeta/core/class/status_class.dart';
import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/constants/enum.dart';
import 'package:geeta/core/constants/firestore_collections.dart';
import 'package:geeta/core/helpful_functions/check_internet_connection.dart';
import 'package:geeta/core/services/firebase/firebase_auth_service.dart';
import 'package:geeta/core/services/firebase/firestore_service.dart';
import 'package:geeta/model/user/user_model.dart';
import 'package:geeta/view/auth/auth_controllers/auth_controller.dart';
import 'package:geeta/view/auth/register/register_controllers/register_draft_controller.dart';
import 'package:geeta/view/auth/register/register_models/register_draft_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/helpful_functions/pick_image.dart';

class RegisterController extends GetxController {
  final FirebaseAuthService _authService = Get.find();
  final FirestoreService _firestore = Get.find();
  final AuthController _session = Get.find();
  final RegisterDraftController _drafts = Get.find();

  static const Duration _autoSaveDelay = Duration(milliseconds: 600);

  final formKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final commercialName = TextEditingController();
  final commercialAccount = TextEditingController();
  final storeLicensePath = TextEditingController();

  StatusClass status = StatusClass.initial;
  Timer? _debounce;

 
  List<TextEditingController> get _draftFields =>
      [email, name, commercialName, commercialAccount, storeLicensePath];

 @override
void onInit() {
  super.onInit();
  _initializeDraft();
}

Future<void> _initializeDraft() async {
  await _restoreDraft();

  for (final c in _draftFields) {
    c.addListener(_scheduleAutoSave);
  }
}

  RegisterDraftModel _buildDraft() => RegisterDraftModel(
        email: email.text.trim(),
        name: name.text.trim(),
        commercialName: commercialName.text.trim(),
        commercialAccount: commercialAccount.text.trim(),
        storeLicensePath: storeLicensePath.text.trim(),
      );

 
  void _scheduleAutoSave() {
    _debounce?.cancel();
    _debounce = Timer(_autoSaveDelay, _saveDraft);
  }

  Future<void> _saveDraft() async {
    try {
      final draft = _buildDraft();
      draft.isEmpty ? await _drafts.clear() : await _drafts.save(draft);
    } catch (e) {
      debugPrint('saveDraft error: $e');
    }
  }

  Future<void> _restoreDraft() async {
    try {
      final draft = await _drafts.load();
      if (draft == null) return;

      email.text = draft.email;
      name.text = draft.name;
      commercialName.text = draft.commercialName;
      commercialAccount.text = draft.commercialAccount;

      
      if (draft.storeLicensePath.isNotEmpty &&
          await File(draft.storeLicensePath).exists()) {
        storeLicensePath.text = draft.storeLicensePath;
      }
      update();
    } catch (e) {
      debugPrint('restoreDraft error: $e');
    }
  }

 
  Future<void> selectStoreLicense(ImageSource source) async {
    final image = await pickImage(source: source);
    if (image == null) return;
    storeLicensePath.text = image.path;
    update();
  }


  Future<RegisterResult> submit() async {
    status = StatusClass.loading;
    update();

   
    if (!await checkInternetConnection()) {
      return _finishOffline();
    }

   
    final result = await _authService.signUp(
      email: email.text.trim(),
      password: password.text,
    );

    final user = result.fold((error) {
      status = error;
      return null;
    }, (credential) => credential.user);

    if (user == null) {
     
      if (_isNetworkError(status)) return _finishOffline();

      if (status == StatusClass.loading) {
        status = StatusClass.anotherError(message: AppString.signupFailed);
      }
      update();
      return RegisterResult.failed;
    }

    
    try {
      final fcmToken = await _session.syncTokens();

      final userModel = UserModel(
        uid: user.uid,
        email: user.email ?? email.text.trim(),
        name: name.text.trim(),
        commercialName: commercialName.text.trim(),
        commercialAccount: commercialAccount.text.trim(),
        fcmToken: fcmToken,
      );

      await _firestore.setDocument(
        collectionPath: FirestoreCollections.users,
        documentId: user.uid,
        data: userModel.toCreateMap(),
      );

      _session.startTokenListeners();

      _debounce?.cancel();
      await _drafts.clear();

      status = StatusClass.success;
      update();
      return RegisterResult.success;
    } catch (e) {
      debugPrint('register profile error: $e');
      status = StatusClass.anotherError(message: AppString.signupFailed);
      update();
      return RegisterResult.failed;
    }
  }

  Future<RegisterResult> _finishOffline() async {
    _debounce?.cancel();
    await _saveDraft();
    status = StatusClass.initial; 
    update();
    return RegisterResult.savedOffline;
  }

  bool _isNetworkError(StatusClass s) => s.isNoInternet;

  @override
  void onClose() {
    _debounce?.cancel();
    for (final c in _draftFields) {
      c.removeListener(_scheduleAutoSave);
    }
    email.dispose();
    password.dispose();
    name.dispose();
    commercialName.dispose();
    commercialAccount.dispose();
    storeLicensePath.dispose();
    super.onClose();
  }
}