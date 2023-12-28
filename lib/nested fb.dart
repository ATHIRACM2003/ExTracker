import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class FutureBuilderJSON extends StatefulWidget {


  _FutureBuilderJSONState createState() => _FutureBuilderJSONState();
}

class _FutureBuilderJSONState extends State<FutureBuilderJSON> {
  Future<List<Project>> _getProjects() async {
    // var data = await http.get("http://studieplaneraren.pythonanywhere.com/api/projects/hugo/?format=json");
    var data = await http.get(Uri.parse("http://studieplaneraren.pythonanywhere.com/api/projects/hugo/?format=json"));
    var jsonData = json.decode(data.body); //an array of json objects
    List<Project> allProjects = [];
    for (var JData in jsonData) {
      Project project = Project(
        JData["id"],
        JData["title"],
        JData["description"],
        JData["deadline"],
        JData["subject"],
        JData["days_left"],
        JData["users"],
      );
      allProjects.add(project);
    }

    return allProjects;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 8, right: 8),
      child: FutureBuilder<List<Project>>(
        future: _getProjects(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              List<dynamic> users = snapshot.data![index].users;

              List<Widget> ws = <Widget>[];

              users.forEach((u) {
                var oneChar = u['username'].substring(0, 1).toUpperCase();
                var w = CircleAvatar(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  child: Text(oneChar),
                );
                ws.add(w);
              });
              // String username =
              //     users != null ? users[0]['username'] : 'Default';
              // var oneChar = username.substring(0, 1).toUpperCase();

              // return CircleAvatar(
              //   foregroundColor: Colors.white,
              //   backgroundColor: Colors.blue,
              //   child: Text(oneChar),
              // );
              return Column(
                children: ws,
              );
            },
          );
        },
      ),
    );
  }
}

class Project {
  final int id;
  final String title;
  final String description;
  final String deadline;
  final String subject;
  final String days_left;
  final List<dynamic> users;

  Project(
      this.id,
      this.title,
      this.description,
      this.deadline,
      this.subject,
      this.days_left,
      this.users,
      );
}

class User {
  final String username;
  final String fullname;
  User(this.username, this.fullname);
}