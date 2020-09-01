import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api_trainning/models/note_for_listing.dart';
import 'package:rest_api_trainning/services/notes_service.dart';
import 'package:rest_api_trainning/views/note_create_modify.dart';
import 'note_delete.dart';

class NoteList extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NoteListState();
  }

}

class _NoteListState extends State<NoteList> {

  // final service = NotesService(); // bad idea .. use service locator GetIT

  /// read the properties of the object NotesService (access the class)
  //var service = GetIt.instance.get<NotesService>();
  NotesService get service => GetIt.instance<NotesService>();

  /// The variable of the data will be gut & init to initialize
  List<NoteForListing> notes = [];

  // a method to format the date and time
  String formatDateTime(DateTime dateTime){
    return '${dateTime.day} / ${dateTime.month} /${dateTime.year}';
  }

  @override
  void initState() {
    notes = service.getNotesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note List'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => NoteCreateModify()
                )
            );
          }
      ),
      body: ListView.separated(
        separatorBuilder: (_, __) => Divider(height: 1, color: Colors.green,),
        itemBuilder: (_, index){
          return Dismissible(
            key: ValueKey(notes[index].noteId),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              ///////////////////// code later
            },
            confirmDismiss: (direction) async {
              final result = await showDialog(
                      context: context,
                      builder: (_) => NoteDelete()
              );
              return result;
            },
            child: ListTile(
              title: Text(
                  notes[index].noteTitle,
                style: TextStyle(
                  color: Theme.of(context).primaryColor
                ),
              ),
              subtitle: Text('Last editied on ${formatDateTime(notes[index].latestEditedDateTime)}'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => NoteCreateModify(noteId: notes[index].noteId)
                  )
                );
              },
            ),
            background: Container(
              //alignment: Alignment.centerLeft,
              color: Colors.red,
              padding: EdgeInsets.only(left: 16),
              child: Align(
                      child: Icon(Icons.delete, color: Colors.white),
                      alignment: Alignment.centerLeft,
              ),
            ),
          );
        },
        itemCount: notes.length,
      ),

    );
  }
}
