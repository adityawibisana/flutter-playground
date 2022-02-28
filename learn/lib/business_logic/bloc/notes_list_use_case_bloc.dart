import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../data/model/note.dart';

class NoteListState {
  List<Note> notes;

  NoteListState({required this.notes});

  Map<String, dynamic> toMap() {
    return {
      'notes': notes.map((x) => x.toMap()).toList(),
    };
  }

  factory NoteListState.fromMap(Map<String, dynamic> map) {
    return NoteListState(
      notes: List<Note>.from(map['notes']?.map((x) => Note.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteListState.fromJson(String source) =>
      NoteListState.fromMap(json.decode(source));
}

enum UserNoteEvent { initial, create, read, update, delete }

class NoteListBloc extends Bloc<UserNoteEvent, NoteListState>
    with HydratedMixin {
  NoteListBloc() : super(NoteListState(notes: <Note>[])) {
    on<UserNoteEvent>((event, emit) {
      switch (event) {
        case UserNoteEvent.create:
          int id = state.notes.length;
          state.notes.add(Note(id, "$id"));
          emit(NoteListState(notes: state.notes));
          return null;
        default:
          return null;
      }
    });
  }

  @override
  NoteListState? fromJson(Map<String, dynamic> json) {
    return NoteListState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(NoteListState state) {
    return state.toMap();
  }
}
