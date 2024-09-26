
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_cubit_app/screens/home_screen.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_cubit_app/cubits/text_cubit.dart';
import 'package:simple_cubit_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class MockTextCubit extends MockCubit<TextState> implements TextCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		testWidgets('should display Cat with clock icon initially', (WidgetTester tester) async {
			// Arrange
			final mockTextCubit = MockTextCubit();
			when(() => mockTextCubit.state).thenReturn(TextState(text: 'Cat', icon: Icons.access_time));

			// Act
			await tester.pumpWidget(
				BlocProvider<TextCubit>(
					create: (_) => mockTextCubit,
					child: MaterialApp(home: HomeScreen()),
				),
			);

			// Assert
			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('should display Dog with person icon after clicking text', (WidgetTester tester) async {
			// Arrange
			final mockTextCubit = MockTextCubit();
			when(() => mockTextCubit.state).thenReturn(TextState(text: 'Cat', icon: Icons.access_time));
			whenListen(
				mockTextCubit,
				Stream.fromIterable([
					TextState(text: 'Cat', icon: Icons.access_time),
					TextState(text: 'Dog', icon: Icons.person),
				]),
			);

			// Act
			await tester.pumpWidget(
				BlocProvider<TextCubit>(
					create: (_) => mockTextCubit,
					child: MaterialApp(home: HomeScreen()),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pumpAndSettle();

			// Assert
			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
