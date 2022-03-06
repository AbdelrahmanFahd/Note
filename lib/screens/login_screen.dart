import 'package:flutter/material.dart';
import '../controller/google_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/cover.png'))),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Text(
            'Create And Manage your Notes',
            style: TextStyle(
              fontSize: 36.0,
              fontFamily: 'SourceSans',
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              await singInWithGoogle(context);
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.grey[700],
                minimumSize: const Size(150, 50),
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Continue with Google',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontFamily: 'SourceSans',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(width: 20),
                Image.asset(
                  'assets/images/123.png',
                  height: 36,
                ),
              ],
            )),
        const SizedBox(
          height: 15.0,
        )
      ]),
    );
  }
}
