import 'package:flutter/material.dart';
import '../modul/screen_arguments.dart';
import 'package:intl/intl.dart';
import '../controller/notes.dart';

class ViewNoteScreen extends StatelessWidget {
  static const routeName = 'ViewNote';
  const ViewNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenArgument data =
        ModalRoute.of(context)!.settings.arguments as ScreenArgument;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: IconButton(
                color: Colors.red,
                onPressed: () async {
                  await deleteNote(data.dataId);
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.delete_forever,
                  size: 35,
                )),
          )
        ],
        backgroundColor: const Color(0xff070706),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: const TextStyle(
                  fontFamily: 'SourceSans',
                  color: Colors.grey,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  DateFormat.yMMMd().add_jm().format(data.time),
                  style: const TextStyle(
                    fontFamily: 'SourceSans',
                    color: Colors.grey,
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                data.description,
                style: const TextStyle(
                  fontFamily: 'SourceSans',
                  color: Colors.grey,
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
