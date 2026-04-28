import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../data/models/note.dart';
import '../../data/repositories/notes_repository.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final _repository = GetIt.I<NotesRepository>();
  final _titleController = TextEditingController();
  late Future<List<Note>> _notesFuture;

  @override
  void initState() {
    super.initState();
    _refreshNotes();
  }

  void _refreshNotes() {
    setState(() {
      _notesFuture = _repository.getNotes();
    });
  }

  void _addNote() async {
    if (_titleController.text.isNotEmpty) {
      await _repository.addNote(_titleController.text);
      _titleController.clear();
      _refreshNotes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            key: const Key('logout_button'),
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const Key('note_title_field'),
                    controller: _titleController,
                    decoration: const InputDecoration(hintText: 'Note title'),
                  ),
                ),
                IconButton(
                  key: const Key('add_note_button'),
                  icon: const Icon(Icons.add),
                  onPressed: _addNote,
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Note>>(
              future: _notesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final notes = snapshot.data ?? [];
                return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(notes[index].title),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
