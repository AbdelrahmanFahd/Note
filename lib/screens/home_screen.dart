import 'dart:math';
import 'view_note_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'add_note_screen.dart';
import '../modul/screen_arguments.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'Home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Color of note
  List<Color?> myColors = [
    Colors.red[200],
    Colors.red[400],
    Colors.green[300],
    Colors.deepPurple[300],
  ];
  @override
  Widget build(BuildContext context) {
    final photoUrl = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(photoUrl)),
          )
        ],
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          'Notes',
          style: TextStyle(
            color: Colors.white60,
            fontFamily: 'SourceSans',
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xff070706),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection('notes')
              .orderBy('created')
              .snapshots(),
          builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(
                        color: Colors.grey[600],
                        backgroundColor: Colors.white60),
                  )
                : snapshot.data?.docs.length != 0
                    ? ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (ctx, index) {
                          final data = snapshot.data?.docs[index];

                          final random = Random();
                          final listColor = myColors[random.nextInt(4)];
                          final myDataTime =
                              (data!['created'] as Timestamp).toDate();
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 8),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    ViewNoteScreen.routeName,
                                    arguments: ScreenArgument(
                                        dataId: data.id,
                                        title: data['title'],
                                        description: data['description'],
                                        time: myDataTime));
                              },
                              tileColor: listColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              title: Text(
                                '${data['title']}',
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'SourceSans',
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              subtitle: Text(
                                DateFormat.yMMMd().add_jm().format(myDataTime),
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'SourceSans',
                                  fontSize: 20,
                                  // fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          );
                        })
                    : const Center(
                        child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Looks like\n you don\'t have any notes :\'(',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddNoteScreen.routeName);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.grey[600],
      ),
    );
  }
}
