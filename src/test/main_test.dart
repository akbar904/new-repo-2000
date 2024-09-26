
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_cubit_app/main.dart';

class MockTextCubit extends MockCubit<TextState> implements TextCubit {}

void main() {
	group('Main App Initialization and Widget Tests', () {
		testWidgets('App initializes with HomeScreen', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());

			expect(find.byType(HomeScreen), findsOneWidget);
		});
	});

	group('HomeScreen and TextWidget Tests', () {
		late TextCubit textCubit;

		setUp(() {
			textCubit = MockTextCubit();
			when(() => textCubit.state).thenReturn(TextState(text: 'Cat', icon: Icons.access_time));
		});

		testWidgets('Initial text should be Cat with clock icon', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<TextCubit>(
						create: (_) => textCubit,
						child: HomeScreen(),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('Text changes to Dog with person icon on tap', (WidgetTester tester) async {
			whenListen(
				textCubit,
				Stream.fromIterable([TextState(text: 'Dog', icon: Icons.person)]),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<TextCubit>(
						create: (_) => textCubit,
						child: HomeScreen(),
					),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pumpAndSettle();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
