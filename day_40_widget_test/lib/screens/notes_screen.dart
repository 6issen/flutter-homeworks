import 'package:flutter/material.dart';
import '../models/note.dart';

class NotesScreen extends StatefulWidget {
  final Stream<List<Note>> notesStream;
  final Function(String) onAddNote;

  const NotesScreen({
    super.key,
    required this.notesStream,
    required this.onAddNote,
  });

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Notes')),
      body: StreamBuilder<List<Note>>(
        stream: widget.notesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(key: Key('loading_indicator')),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                key: const Key('error_text'),
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final notes = snapshot.data ?? [];

          if (notes.isEmpty) {
            return const Center(
              child: Text('No notes yet', key: Key('empty_state')),
            );
          }

          return ListView.builder(
            key: const Key('notes_list'),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return ListTile(
                key: Key('note_item_${note.id}'),
                title: Text(note.title),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(note: note),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.grey[200],
        child: Row(
          children: [
            Expanded(
              child: TextField(
                key: const Key('note_textfield'),
                controller: _controller,
                decoration: const InputDecoration(hintText: 'Enter note title'),
              ),
            ),
            IconButton(
              key: const Key('add_note_button'),
              icon: const Icon(Icons.add),
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  widget.onAddNote(_controller.text);
                  _controller.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      key: Key('error_snackbar'),
                      content: Text('Title cannot be empty'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class DetailScreen extends StatelessWidget {
  final Note note;

  const DetailScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Note Details')),
      body: Center(
        child: Text(
          note.title,
          key: const Key('detail_title'),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
