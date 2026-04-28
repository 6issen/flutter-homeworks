import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:day_40_widget_test/models/note.dart';
import 'package:day_40_widget_test/screens/notes_screen.dart';

void main() {
  late StreamController<List<Note>> notesController;

  setUp(() {
    notesController = StreamController<List<Note>>();
  });

  tearDown(() {
    notesController.close();
  });

  testWidgets('Screen states: Loading -> Empty -> Items', (WidgetTester tester) async {
    // 1. Loading state
    await tester.pumpWidget(MaterialApp(
      home: NotesScreen(
        notesStream: notesController.stream,
        onAddNote: (_) {},
      ),
    ));

    expect(find.byKey(const Key('loading_indicator')), findsOneWidget);

    // 2. Empty state
    notesController.add([]);
    await tester.pump(); // Trigger rebuild for stream data

    expect(find.byKey(const Key('empty_state')), findsOneWidget);
    expect(find.text('No notes yet'), findsOneWidget);

    // 3. Display items
    notesController.add([
      Note(id: '1', title: 'Test Note 1'),
      Note(id: '2', title: 'Test Note 2'),
    ]);
    await tester.pump();

    expect(find.byKey(const Key('notes_list')), findsOneWidget);
    expect(find.text('Test Note 1'), findsOneWidget);
    expect(find.text('Test Note 2'), findsOneWidget);
  });

  testWidgets('Add note: input text -> tap -> callback triggered', (WidgetTester tester) async {
    String? capturedTitle;
    
    await tester.pumpWidget(MaterialApp(
      home: NotesScreen(
        notesStream: notesController.stream,
        onAddNote: (title) => capturedTitle = title,
      ),
    ));

    // Provide some initial data to avoid empty state if needed, but not strictly necessary for this test
    notesController.add([]);
    await tester.pump();

    // Find TextField and enter text
    final textField = find.byKey(const Key('note_textfield'));
    await tester.enterText(textField, 'New Awesome Note');
    
    // Tap add button
    await tester.tap(find.byKey(const Key('add_note_button')));
    await tester.pump();

    expect(capturedTitle, 'New Awesome Note');
    // Check if controller is cleared
    expect(find.text('New Awesome Note'), findsNothing);
  });

  testWidgets('Error handling: simulate stream error', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: NotesScreen(
        notesStream: notesController.stream,
        onAddNote: (_) {},
      ),
    ));

    notesController.addError('Something went wrong');
    await tester.pump();

    expect(find.byKey(const Key('error_text')), findsOneWidget);
    expect(find.textContaining('Something went wrong'), findsOneWidget);
  });

  testWidgets('Validation error: empty input shows SnackBar', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: NotesScreen(
        notesStream: notesController.stream,
        onAddNote: (_) {},
      ),
    ));

    notesController.add([]);
    await tester.pump();

    // Tap add button without entering text
    await tester.tap(find.byKey(const Key('add_note_button')));
    await tester.pump(); // Start SnackBar animation

    expect(find.byKey(const Key('error_snackbar')), findsOneWidget);
    expect(find.text('Title cannot be empty'), findsOneWidget);
  });

  testWidgets('Navigation: tap on note goes to Details', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: NotesScreen(
        notesStream: notesController.stream,
        onAddNote: (_) {},
      ),
    ));

    notesController.add([Note(id: '1', title: 'Detail Test Note')]);
    await tester.pump();

    // Tap on the note item
    await tester.tap(find.text('Detail Test Note'));
    await tester.pumpAndSettle(); // Wait for navigation animation to finish

    // Verify we are on the Detail screen
    expect(find.text('Note Details'), findsOneWidget);
    expect(find.byKey(const Key('detail_title')), findsOneWidget);
    expect(find.text('Detail Test Note'), findsOneWidget);
  });
}
