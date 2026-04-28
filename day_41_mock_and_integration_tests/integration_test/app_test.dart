import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:day_41_mock_and_integration_tests/main.dart' as app;
import 'package:day_41_mock_and_integration_tests/core/di/injection_container.dart';
import 'package:day_41_mock_and_integration_tests/data/services/api_client.dart';
import 'package:day_41_mock_and_integration_tests/data/repositories/notes_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-end test', () {
    late MockApiClient mockApiClient;

    setUp(() async {
      mockApiClient = MockApiClient();
      
      // Reset GetIt to ensure clean state
      await sl.reset();
      
      // Register mock ApiClient
      sl.registerLazySingleton<ApiClient>(() => mockApiClient);
      // Register real repository using the mock client
      sl.registerLazySingleton<NotesRepository>(() => NotesRepository(sl<ApiClient>()));
    });

    testWidgets('login -> list -> add -> logout scenario', (tester) async {
      // 1. Setup mock responses
      when(() => mockApiClient.login('admin', '1234')).thenAnswer((_) async => true);
      when(() => mockApiClient.getNotes()).thenAnswer((_) async => [
        {'id': 1, 'title': 'Existing Note'},
      ]);
      when(() => mockApiClient.addNote('New Integration Note')).thenAnswer((_) async => {});

      // 2. Start app
      // We don't call app.main() directly because it initializes DI. 
      // We do it manually in setUp for control.
      await tester.pumpWidget(const app.MyApp());
      await tester.pumpAndSettle();

      // 3. Login
      await tester.enterText(find.byKey(const Key('username_field')), 'admin');
      await tester.enterText(find.byKey(const Key('password_field')), '1234');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();

      // 4. Verify we are on Notes screen
      expect(find.text('Notes'), findsOneWidget);
      expect(find.text('Existing Note'), findsOneWidget);

      // 5. Add a note
      await tester.enterText(find.byKey(const Key('note_title_field')), 'New Integration Note');
      
      // Mock getNotes to return the new list after addition
      when(() => mockApiClient.getNotes()).thenAnswer((_) async => [
        {'id': 1, 'title': 'Existing Note'},
        {'id': 2, 'title': 'New Integration Note'},
      ]);
      
      await tester.tap(find.byKey(const Key('add_note_button')));
      await tester.pumpAndSettle();

      // 6. Verify note added
      expect(find.text('New Integration Note'), findsOneWidget);

      // 7. Logout
      await tester.tap(find.byKey(const Key('logout_button')));
      await tester.pumpAndSettle();

      // 8. Verify back to login
      expect(find.text('Login'), findsOneWidget);
      verify(() => mockApiClient.login('admin', '1234')).called(1);
    });
  });
}
