import 'package:flutter/material.dart';
import 'package:note_app_sample/data/data.dart';
import 'package:note_app_sample/data/note_model/note_model.dart';

enum ActionType {
  addNote,
  editNote,
}

class AddNoteScreen extends StatelessWidget {
  final NoteModel? data;
  final ActionType type;
  AddNoteScreen({Key? key, this.data, required this.type}) : super(key: key);

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget get saveButton => TextButton.icon(
        onPressed: () {
          switch (type) {
            case ActionType.addNote:
              saveNote();
              break;

            case ActionType.editNote:
              updateNote();
              break;
          }
        },
        icon: const Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: const Text(
          "Save",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (type == ActionType.editNote) {
      contentController.text = data!.content.toString();
      titleController.text = data!.title.toString();
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          saveButton,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("title"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: contentController,
              maxLength: 50,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("content"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  updateNote() {
    final title = titleController.text;
    final content = contentController.text;

    final newNote = NoteModel.create(
      id: data!.id.toString(),
      title: title,
      content: content,
    );

    NoteDB.instance.updateNote(newNote);
    Navigator.pop(_scaffoldKey.currentContext!);
  }

  Future<void> saveNote() async {
    final title = titleController.text;
    final content = contentController.text;

    final newNote = NoteModel.create(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      content: content,
    );

    NoteDB.instance.createNote(newNote);
    Navigator.pop(_scaffoldKey.currentContext!);
  }
}
