import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sqflite/models/note.dart';
import 'package:flutter_sqflite/screens/note_detail.dart';
import 'package:flutter_sqflite/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList = [];
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = [];
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff1B434D),
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetail(Note('', '', 2), 'Add Note');
        },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.headlineMedium!;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.5),
          child: Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    getPriorityColor(this.noteList[position].priority!),
                child: getPriorityIcon(this.noteList[position].priority!),
              ),
              title: Text(
                this.noteList[position].title!,
                style: titleStyle,
              ),
              subtitle: Text(this.noteList[position].date!),
              trailing: Wrap(children: [
                GestureDetector(
                  child: Icon(
                    Icons.edit,
                    color: Colors.teal,
                  ),
                  onTap: () {
                    debugPrint("ListTile Tapped");
                    navigateToDetail(this.noteList[position], 'Edit Note');
                  },
                ),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onTap: () {
                    _delete(context, noteList[position]);
                  },
                ),
              ]),
            ),
          ),
        );
      },

      // ),
    );
  }

  // Returns the priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;

      case 2:
        return Colors.yellow;

      default:
        return Colors.yellow;
    }
  }

  // Returns the priority icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.lens_sharp);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id!);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Note note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(note, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
