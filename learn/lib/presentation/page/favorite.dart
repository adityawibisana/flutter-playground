import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn/business_logic/bloc/notes_list_use_case_bloc.dart';

import '../../data/model/note.dart';
import '../widget/custom_button.dart';

void main() {
  runApp(MyFavoriteApp());
}

class MyFavoriteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const Favorite(),
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ));
  }
}

class Favorite extends StatelessWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Favorite"),
        ),
        body: Column(
          children: [
            CustomButton(
              content: "Add +",
              onPressed: () async {
                context.read<NoteListBloc>().add(UserNoteEvent.create);
              },
            ),
            BlocBuilder<NoteListBloc, NoteListState>(
              builder: (context, state) {
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, position) {
                      return Text(state.notes[position].content);
                    },
                    itemCount: state.notes.length,
                  ),
                );
              },
            )
          ],
        ));
  }
}
