import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../controller/notes.dart';

class AddNoteScreen extends StatelessWidget {
  static const routeName = 'AddNote';
  AddNoteScreen({Key? key}) : super(key: key);

  String? title;
  String? description;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: IconButton(
                  onPressed: () async {
                    final isValid = formKey.currentState!.validate();
                    if (isValid) {
                      formKey.currentState?.save();
                      await addNote({
                        'title': title,
                        'description': description,
                        'created': Timestamp.now(),
                      });
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(
                    Icons.save,
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
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    DefaultTextField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      textOfForm: 'Title',
                      textOfLabel: 'Note Title',
                      fontSize: 30,
                      lines: 1,
                      valid: (value) {
                        if (value!.length < 3) {
                          return 'please Enter at least 3 letters';
                        }
                        return null;
                      },
                      save: (value) {
                        title = value;
                      },
                    ),
                    DefaultTextField(
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      textOfForm: 'Description',
                      textOfLabel: 'Note Description',
                      fontSize: 22,
                      lines: 7,
                      textStyle: const TextStyle(
                        color: Colors.white70,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                      valid: (value) {
                        if (value!.length < 3) {
                          return 'please Enter at least 3 letters';
                        }
                        return null;
                      },
                      save: (value) {
                        description = value;
                      },
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class DefaultTextField extends StatelessWidget {
  const DefaultTextField({
    Key? key,
    required this.textOfForm,
    required this.textOfLabel,
    required this.keyboardType,
    required this.textInputAction,
    this.save,
    this.onFieldSubmitted,
    this.valid,
    this.suggestions = false,
    this.correct = false,
    this.obscureText = false,
    this.controller,
    this.lines = 2,
    this.textStyle = const TextStyle(
      color: Colors.white70,
      fontSize: 30,
      fontWeight: FontWeight.w700,
    ),
    this.fontSize = 18,
  }) : super(key: key);
  final String textOfForm;
  final String textOfLabel;
  final TextInputType keyboardType;
  final bool suggestions;
  final bool correct;
  final TextInputAction textInputAction;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? valid;
  final bool obscureText;
  final TextEditingController? controller;
  final void Function(String?)? save;
  final int? lines;
  final TextStyle textStyle;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Sized20(),
        Label(text: textOfLabel),
        const Sized10(),
        TextFormField(
          key: Key(textOfLabel),
          maxLines: lines,
          controller: controller,
          keyboardType: keyboardType,
          enableSuggestions: suggestions,
          autocorrect: correct,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          obscureText: obscureText,
          validator: valid,
          onSaved: save,
          decoration: cTextFormFieldDecoration(textOfForm, fontSize),
          style: textStyle,
        ),
      ],
    );
  }
}

class Sized20 extends StatelessWidget {
  const Sized20({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
    );
  }
}

class Sized10 extends StatelessWidget {
  const Sized10({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 10,
    );
  }
}

class Label extends StatelessWidget {
  const Label({
    required this.text,
    Key? key,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'SourceSans',
          color: Colors.grey[400],
          fontWeight: FontWeight.w900,
          fontSize: 20,
        ),
      ),
    );
  }
}
