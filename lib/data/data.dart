import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:note_app_sample/data/get_all_notes/get_all_notes.dart';
import 'package:note_app_sample/data/note_model/note_model.dart';
import 'package:note_app_sample/data/url.dart';

abstract class ApiCalls {
  Future<void> createNote(NoteModel value);
  Future<void> getAllNotes();
  Future<void> updateNote(NoteModel value);
  Future<void> deleteNote(String id);
}

class NoteDB extends ApiCalls {
  NoteDB.internal();

  static NoteDB instance = NoteDB.internal();

  factory() {
    return instance;
  }

  final dio = Dio(BaseOptions(baseUrl: Url.baseUrl));

  ValueNotifier<List<NoteModel>> getAllNoteListener = ValueNotifier([]);

  @override
  Future<void> createNote(NoteModel value) async {
    await dio.post(Url.createNote, data: value);
  }

  @override
  Future<void> deleteNote(String id) async {
    await dio.delete(Url.deleteNote.replaceAll("{id}", id));
    getAllNotes();
  }

  @override
  Future<void> getAllNotes() async {
    final result = await dio.get(Url.getAllNote);
    final getNoteRespnse = GetAllNotes.fromJson(result.data);
    getAllNoteListener.value.clear();
    getAllNoteListener.value.addAll(getNoteRespnse.data.reversed);
    getAllNoteListener.notifyListeners();
  }

  @override
  updateNote(NoteModel value) async {
    await dio.put(Url.updateNote, data: value.toJson());
    getAllNotes();
  }
}
