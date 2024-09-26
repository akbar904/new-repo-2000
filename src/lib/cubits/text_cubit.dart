
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

// State class representing the text and icon data
class TextState {
	final String text;
	final IconData icon;

	TextState({required this.text, required this.icon});
}

// Cubit class responsible for managing the text state
class TextCubit extends Cubit<TextState> {
	TextCubit() : super(TextState(text: 'Cat', icon: Icons.access_time));

	// Toggles the text between 'Cat' and 'Dog'
	void toggleText() {
		if (state.text == 'Cat') {
			emit(TextState(text: 'Dog', icon: Icons.person));
		} else {
			emit(TextState(text: 'Cat', icon: Icons.access_time));
		}
	}
}
