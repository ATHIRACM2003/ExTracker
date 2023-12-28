// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData.dark(),
//       initialRoute: MyHomePage.id,
//       routes: {
//         MyHomePage.id: (context) => MyHomePage(),
//       },
//     );
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   static const String id = "HOMESCREEN";
//
//   Future<String> createFuture(String name, int seconds) {
//     final c = new Completer<String>();
//     new Timer(Duration(seconds: seconds), () {
//       c.complete("$name resultString");
//     });
//     return c.future;
//   }
//
//   Future myFutureMethodOverall() async {
//     Future<String> future1 = createFuture("Future1", 1); // will take 1 sec
//     Future<String> future2 = createFuture("Future2", 3); // will take 3 secs
//     return await Future.wait([future1, future2]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//           child: FutureBuilder(
//               future: myFutureMethodOverall(),
//               builder: (BuildContext context, AsyncSnapshot snapshot) {
//                 print(snapshot.connectionState);
//                 if (snapshot.hasData) {
//                   if (snapshot.data != null) {
//                     return Container(
//                         child:
//                         Text("Futures complete with Data ${snapshot.data}"));
//                   } else {
//                     return Row(
//                       children: <Widget>[
//                         Container(
//                             width: 300,
//                             child: Text(
//                                 "Waiting for both Futures to complete...")),
//                         new CircularProgressIndicator(),
//                       ],
//                     );
//                   }
//                 } else {
//                   return Row(
//                     children: <Widget>[
//                       Container(
//                           width: 300,
//                           child: Text(
//                               "Waiting for both Futures to complete...")),
//                       new CircularProgressIndicator(),
//                     ],
//                   );
//                 }
//               })),
//     );
//   }
// }