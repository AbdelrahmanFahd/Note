import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_note_screen.dart';
import 'screens/view_note_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Notes',
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.white,
          accentColor: Colors.white,
          scaffoldBackgroundColor: const Color(0xff070706)),
      home: const LoginScreen(),
      routes: {
        HomeScreen.routeName: (ctx) => const HomeScreen(),
        AddNoteScreen.routeName: (ctx) => AddNoteScreen(),
        ViewNoteScreen.routeName: (ctx) => const ViewNoteScreen(),
      },
    );
  }
}

// import 'package:flutter/material.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       routes: {
//         ExtractArgumentsScreen.routeName: (context) =>
//             const ExtractArgumentsScreen(),
//       },
//       onGenerateRoute: (settings) {
//         if (settings.name == PassArgumentsScreen.routeName) {
//           final args = settings.arguments as ScreenArguments;
//
//           return MaterialPageRoute(
//             builder: (context) {
//               return PassArgumentsScreen(
//                 title: args.title,
//                 message: args.message,
//               );
//             },
//           );
//         }
//         // The code only supports
//         // PassArgumentsScreen.routeName right now.
//         // Other values need to be implemented if we
//         // add them. The assertion here will help remind
//         // us of that higher up in the call stack, since
//         // this assertion would otherwise fire somewhere
//         // in the framework.
//         assert(false, 'Need to implement ${settings.name}');
//         return null;
//       },
//       title: 'Navigation with Arguments',
//       home: const HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Screen'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // A button that navigates to a named route.
//             // The named route extracts the arguments
//             // by itself.
//             ElevatedButton(
//               onPressed: () {
//                 // When the user taps the button,
//                 // navigate to a named route and
//                 // provide the arguments as an optional
//                 // parameter.
//                 Navigator.pushNamed(
//                   context,
//                   ExtractArgumentsScreen.routeName,
//                   arguments: ScreenArguments(
//                     'Extract Arguments Screen',
//                     'This message is extracted in the build method.',
//                   ),
//                 );
//               },
//               child: const Text('Navigate to screen that extracts arguments'),
//             ),
//             // A button that navigates to a named route.
//             // For this route, extract the arguments in
//             // the onGenerateRoute function and pass them
//             // to the screen.
//             ElevatedButton(
//               onPressed: () {
//                 // When the user taps the button, navigate
//                 // to a named route and provide the arguments
//                 // as an optional parameter.
//                 Navigator.pushNamed(
//                   context,
//                   PassArgumentsScreen.routeName,
//                   arguments: ScreenArguments(
//                     'Accept Arguments Screen',
//                     'This message is extracted in the onGenerateRoute '
//                         'function.',
//                   ),
//                 );
//               },
//               child: const Text('Navigate to a named that accepts arguments'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // A Widget that extracts the necessary arguments from
// // the ModalRoute.
// class ExtractArgumentsScreen extends StatelessWidget {
//   const ExtractArgumentsScreen({Key? key}) : super(key: key);
//
//   static const routeName = '/extractArguments';
//
//   @override
//   Widget build(BuildContext context) {
//     // Extract the arguments from the current ModalRoute
//     // settings and cast them as ScreenArguments.
//     final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(args.title),
//       ),
//       body: Center(
//         child: Text(args.message),
//       ),
//     );
//   }
// }
//
// // A Widget that accepts the necessary arguments via the
// // constructor.
// class PassArgumentsScreen extends StatelessWidget {
//   static const routeName = '/passArguments';
//
//   final String title;
//   final String message;
//
//   // This Widget accepts the arguments as constructor
//   // parameters. It does not extract the arguments from
//   // the ModalRoute.
//   //
//   // The arguments are extracted by the onGenerateRoute
//   // function provided to the MaterialApp widget.
//   const PassArgumentsScreen({
//     Key? key,
//     required this.title,
//     required this.message,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: Center(
//         child: Text(message),
//       ),
//     );
//   }
// }
//
// // You can pass any object to the arguments parameter.
// // In this example, create a class that contains both
// // a customizable title and message.
// class ScreenArguments {
//   final String title;
//   final String message;
//
//   ScreenArguments(this.title, this.message);
// }
