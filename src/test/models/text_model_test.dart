
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_cubit_app/models/text_model.dart';

void main() {
	group('TextModel', () {
		test('should be able to create a TextModel instance with text and icon', () {
			final textModel = TextModel(text: 'Cat', icon: Icons.access_time);
			expect(textModel.text, 'Cat');
			expect(textModel.icon, Icons.access_time);
		});

		test('should support value comparison', () {
			final textModel1 = TextModel(text: 'Cat', icon: Icons.access_time);
			final textModel2 = TextModel(text: 'Cat', icon: Icons.access_time);

			expect(textModel1, equals(textModel2));
		});

		test('should serialize and deserialize correctly', () {
			final textModel = TextModel(text: 'Cat', icon: Icons.access_time);
			final json = textModel.toJson();
			final newTextModel = TextModel.fromJson(json);

			expect(newTextModel, equals(textModel));
		});
	});
}

class TextModel {
	final String text;
	final IconData icon;

	TextModel({required this.text, required this.icon});

	Map<String, dynamic> toJson() {
		return {
			'text': text,
			'icon': icon.codePoint,
		};
	}

	factory TextModel.fromJson(Map<String, dynamic> json) {
		return TextModel(
			text: json['text'],
			icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
		);
	}

	@override
	bool operator ==(Object other) =>
		identical(this, other) ||
		other is TextModel &&
			runtimeType == other.runtimeType &&
			text == other.text &&
			icon == other.icon;

	@override
	int get hashCode => text.hashCode ^ icon.hashCode;
}
