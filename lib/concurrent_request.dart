// import 'dart:convert';
//
// import 'package:expense_dummy/main.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
//
//
// class Concurrent_Request extends StatefulWidget {
//   @override
//   _Concurrent_RequestState createState() => _Concurrent_RequestState();
// }
//
// class _Concurrent_RequestState extends State<Concurrent_Request> {
//
//   //Map<String, dynamic>? post;
//   List<dynamic> ?comments;
//   List<dynamic> ?comments1;
//
//
//   bool _showLoading = true;
//   bool _showComments = true;
//
//   @override
//   void initState() {
//     super.initState();
//
//
//     _fetchData();
//   }
//
//   Future _fetchData() async {
//     setState(() { _showLoading = true; });
//
//     final results = await Future.wait([
//
//       http.get(Uri.parse("http://$ip_address/Crud_operations/display_data2.php")),
//       http.get(Uri.parse("http://$ip_address/Crud_operations/display_data.php")),
//      // http.get(Uri.parse("http://jsonplaceholder.typicode.com/posts/1")),
//
//       //http.get(Uri.parse("http://jsonplaceholder.typicode.com/posts/1")),
//
//       //http://localhost/Crud_operations/display_data.php
//
//     ]);
//
//     setState(() {
//      // post = json.decode(results[1].body);
//       comments = json.decode(results[0].body);
//       comments1 = json.decode(results[1].body);
//     });
//
//     setState(() { _showLoading = false; });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         middle: Text("JSON Placeholder Blog post"),
//       ),
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(12.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(height: 70),
//               if (_showLoading)
//                 Center(child: CupertinoActivityIndicator(animating: true)),
//
//               // if (!_showLoading) ... [
//               //   Text(post!['id'].toString(), style: TextStyle(fontWeight: FontWeight.bold, )),
//
//                 SizedBox(height: 10),
//
//                 _showCommentsToggle(),
//
//                 SizedBox(height: 10),
//
//                 // if (!_showComments)
//                 //   Text(post!['name'], style: TextStyle(fontSize: 14)),
//
//
//               if (_showComments)
//                 ..._commentList1(),
//
//                 if (!_showComments)
//                   ..._commentList(),
//
//
//               ]
//
//           ),
//         ),
//       ),
//     );
//   }
//
//   _showCommentsToggle() {
//     return Row(
//       children: [
//         Text('Show comments',style: TextStyle(fontSize: 20), ),
//         GestureDetector(
//           child: CupertinoSwitch(
//             value: _showComments,
//             onChanged: (bool value) { setState(() { _showComments = value; }); },
//           ),
//           onTap: () { setState(() { _showComments = !_showComments; }); },
//         ),
//       ],
//     );
//   }
//
//   _commentList() {
//     return comments?.map((comment) => Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(comment['catagory'].toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//        Text(comment['name'],  style: TextStyle(fontSize: 14)),
//         Text(comment['place'],  style: TextStyle(fontSize: 14)),
//         SizedBox(height: 15)
//       ],
//     )).toList();
//   }
//
//   _commentList1() {
//     return comments1?.map((comment) => Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(comment['id'].toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//         Text(comment['name'],  style: TextStyle(fontSize: 14)),
//         Text(comment['age'],  style: TextStyle(fontSize: 14)),
//         SizedBox(height: 15)
//       ],
//     )).toList();
//   }
//
//
//
// }