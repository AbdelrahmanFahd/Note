import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../screens/home_screen.dart';

final googleSignIn = GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');

Future singInWithGoogle(BuildContext context) async {
  try {
    final googleSignInAccount = await googleSignIn.signIn();

    // print('googleSignInAccount = ${googleSignInAccount} ');

    // GoogleSignInAccount:{
    // displayName: Aboody Fahd,
    // email: aboody.fahd30@gmail.com,
    // id: 109588965331849874670,
    // photoUrl: https://lh3.googleusercontent.com/a/AATXAJx6gXmPbbbDvVSFgiHKUn44YevQD5X-9jeBA6wAIw=s96-c,
    // serverAuthCode: 4/0AX4XfWjhRzk20bW7q5iQHiOncS5rgDVwDtzmEGVoszhcyo_6xLfThxCUpYZwtc_Y3egfpQ}

    if (googleSignInAccount != null) {
      final googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final authResult = await auth.signInWithCredential(credential);
      // print('-------------------------------------');
      // print('authResult = ${authResult.user} ');
      final user = authResult.user;

      //User(displayName: Aboody Fahd,
      // email: aboody.fahd30@gmail.com,
      // emailVerified: true, isAnonymous:
      // false,
      // metadata: UserMetadata(creationTime: 2022-03-04 02:53:57.271, lastSignInTime: 2022-03-04 18:33:48.777),
      // phoneNumber: null,
      // photoURL: https://lh3.googleusercontent.com/a/AATXAJx6gXmPbbbDvVSFgiHKUn44YevQD5X-9jeBA6wAIw=s96-c,
      // providerData, [UserInfo(displayName: Aboody Fahd, email: aboody.fahd30@gmail.com, phoneNumber: null, photoURL: https://lh3.googleusercontent.com/a/AATXAJx6gXmPbbbDvVSFgiHKUn44YevQD5X-9jeBA6wAIw=s96-c, providerId: google.com, uid: 109588965331849874670)], refreshToken: , tenantId: null,
      // uid: cq4xSGN0d8ZETyuCr1idOLoxbnd2)
      var userData = {
        'name': googleSignInAccount.displayName,
        'provider': 'Google',
        'photoUrl': googleSignInAccount.photoUrl,
        'email': googleSignInAccount.email,
      };

      users.doc(user?.uid).get().then((doc) {
        if (doc.exists) {
          //old user
          doc.reference.update(userData);
        } else
        // new user
        {
          users.doc(user?.uid).set(userData);
        }
        Navigator.of(context)
            .pushNamed(HomeScreen.routeName, arguments: userData['photoUrl']);
      });
    }
  } catch (error) {
    print(error);
    print('Sign in not successful');
  }
}
