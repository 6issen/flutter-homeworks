import 'package:flutter/material.dart';
import 'domain/entities/note.dart';
import 'data/datasources/notes_local_datasource.dart';
import 'data/datasources/notes_remote_datasource.dart';
import 'data/repositories/notes_repository_impl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesScreen(),
    );
  }
}

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late final NotesRepositoryImpl _repository;

  @override
  void initState() {
    super.initState();
    final localDataSource = NotesLocalDataSourceImpl();
    final remoteDataSource = NotesRemoteDataSourceImpl();
    
    _repository = NotesRepositoryImpl(
      localDataSource: localDataSource,
      remoteDataSource: remoteDataSource,
    );

    localDataSource.saveNotes([
      {'id': 99, 'title': 'Старая заметка из кэша', 'content': 'Она загрузится мгновенно'}
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clean Architecture Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          )
        ],
      ),
      body: StreamBuilder<List<Note>>(
        stream: _repository.getNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }

          final notes = snapshot.data ?? [];

          if (notes.isEmpty) {
            return const Center(child: Text('Нет заметок'));
          }

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(child: Text(note.id.toString())),
                  title: Text(note.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(note.content),
                  trailing: snapshot.connectionState != ConnectionState.done 
                    ? const SizedBox(
                        width: 16, 
                        height: 16, 
                        child: CircularProgressIndicator(strokeWidth: 2)
                      ) 
                    : const Icon(Icons.cloud_done, color: Colors.green),
                ),
              );
            },
          );
        },
      ),
    );
  }
}