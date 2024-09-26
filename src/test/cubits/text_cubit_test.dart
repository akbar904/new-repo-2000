
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_cubit_app/cubits/text_cubit.dart';

// Mocking TextCubit class
class MockTextCubit extends MockCubit<TextState> implements TextCubit {}

void main() {
	group('TextCubit', () {
		late TextCubit textCubit;
		
		setUp(() {
			textCubit = TextCubit();
		});
		
		tearDown(() {
			textCubit.close();
		});
		
		test('initial state is TextState with text "Cat" and clock icon', () {
			expect(textCubit.state.text, 'Cat');
			expect(textCubit.state.icon, Icons.access_time);
		});
		
		blocTest<TextCubit, TextState>(
			'emits [TextState] with text "Dog" and person icon when toggleText is called',
			build: () => textCubit,
			act: (cubit) => cubit.toggleText(),
			expect: () => [
				isA<TextState>().having((state) => state.text, 'text', 'Dog')
					.having((state) => state.icon, 'icon', Icons.person)
			],
		);
		
		blocTest<TextCubit, TextState>(
			'emits [TextState] with text "Cat" and clock icon when toggleText is called twice',
			build: () => textCubit,
			act: (cubit) {
				cubit.toggleText();
				cubit.toggleText();
			},
			expect: () => [
				isA<TextState>().having((state) => state.text, 'text', 'Dog')
					.having((state) => state.icon, 'icon', Icons.person),
				isA<TextState>().having((state) => state.text, 'text', 'Cat')
					.having((state) => state.icon, 'icon', Icons.access_time)
			],
		);
	});
}
