import "package:flutter/material.dart";
import 'package:note_app_sample/data/data.dart';
import 'package:note_app_sample/data/note_model/note_model.dart';
import 'package:note_app_sample/screens/add_note_screen.dart';
import 'package:note_app_sample/screens/widgets/note_item.dart';

class AllNoteScreen extends StatelessWidget {
  const AllNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await NoteDB.instance.getAllNotes();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Note App"),
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Builder(builder: (context) {
          return ValueListenableBuilder(
            valueListenable: NoteDB.instance.getAllNoteListener,
            builder: (BuildContext context, List<NoteModel> value, _) {
              return GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: List.generate(
                  value.length,
                  (index) {
                    final newNoteList = value[index];
                    if (newNoteList.id == null) {
                      return const SizedBox();
                    }
                    return NoteItem(
                      data:newNoteList, 
                    );
                  },
                ),
              );
            },
          );
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => AddNoteScreen(type: ActionType.addNote)),
            ),
          );
        },
        label: const Text("Add new"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
