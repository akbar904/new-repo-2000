
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_cubit_app/widgets/text_widget.dart';

void main() {
	group('TextWidget', () {
		testWidgets('displays text "Cat" with clock icon', (WidgetTester tester) async {
			// Arrange
			const text = 'Cat';
			const icon = Icons.access_time;

			// Act
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: TextWidget(text: text, icon: icon),
					),
				),
			);

			// Assert
			expect(find.text(text), findsOneWidget);
			expect(find.byIcon(icon), findsOneWidget);
		});

		testWidgets('displays text "Dog" with person icon', (WidgetTester tester) async {
			// Arrange
			const text = 'Dog';
			const icon = Icons.person;

			// Act
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: TextWidget(text: text, icon: icon),
					),
				),
			);

			// Assert
			expect(find.text(text), findsOneWidget);
			expect(find.byIcon(icon), findsOneWidget);
		});
	});
}
