import 'package:geeta/core/services/sqflite/sqflite_service.dart';
import 'package:geeta/view/auth/register/register_models/register_draft_model.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class RegisterDraftController extends GetxService {
  RegisterDraftController(this._sqflite);

  final SqfliteService _sqflite;

  static const int draftId = 1;
  static const String _table = 'register_drafts';


  Future<void> save(RegisterDraftModel draft) async {
    final db = await _sqflite.init();
    await db.insert(
      _table,
      draft.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<RegisterDraftModel?> load() async {
    final rows = await _sqflite.getData(
      tableName: _table,
      where: 'id = ?',
      whereArgs: [draftId],
    );
    return rows.isEmpty ? null : RegisterDraftModel.fromMap(rows.first);
  }

  Future<void> clear() => _sqflite.deleteData(
        tableName: _table,
        where: 'id = ?',
        whereArgs: [draftId],
      );
}