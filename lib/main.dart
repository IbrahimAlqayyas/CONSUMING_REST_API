import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api_training/services/notes_service.dart';
import 'package:rest_api_training/views/note_list.dart';


void serviceLocator(){
  GetIt sl = GetIt.instance;
  // create the service locator
  sl.registerLazySingleton<NotesService>(() => NotesService());
  // consume the service locator with model type of NotesService
  // GetIt.instance<NotesService>();
}

void main() {
  //calling the service locator
  serviceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NoteList(),
    );
  }
}
