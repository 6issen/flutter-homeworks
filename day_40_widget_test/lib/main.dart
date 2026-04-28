import 'dart:async';
import 'package:flutter/material.dart';
import 'models/note.dart';
import 'screens/notes_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Test HW',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const NotesWrapper(),
    );
  }
}

class NotesWrapper extends StatefulWidget {
  const NotesWrapper({super.key});

  @override
  State<NotesWrapper> createState() => _NotesWrapperState();
}

class _NotesWrapperState extends State<NotesWrapper> {
  final List<Note> _notes = [];
  final StreamController<List<Note>> _controller = StreamController<List<Note>>();

  @override
  void initState() {
    super.initState();
    // Simulate initial loading
    _loadNotes();
  }

  void _loadNotes() async {
    await Future.delayed(const Duration(seconds: 1));
    _controller.add(_notes);
  }

  void _addNote(String title) {
    final newNote = Note(id: DateTime.now().toString(), title: title);
    _notes.add(newNote);
    _controller.add(List.from(_notes));
  }

  @override
  Widget build(BuildContext context) {
    return NotesScreen(
      notesStream: _controller.stream,
      onAddNote: _addNote,
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
