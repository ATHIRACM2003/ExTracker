import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'Data Model/Data_Model2.dart';
import 'Data Model/Data_Model3.dart';
import 'main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class list_test extends StatefulWidget {
  @override
  State<list_test> createState() => _list_testState();
}

class _list_testState extends State<list_test> {


  var test;
  @override
  void initState() {
    getRequest();

    // TODO: implement initState
    super.initState();

  }

  var limits = [];


  Future<List<Data_Model3>> getRequest() async {
    //replace your restFull API here.
    String url =
        "http://$ip_address/Expense_Management/Display_budget_limit.php";

    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    //Creating a list to store input data;

    List<Data_Model3> users = [];

    for (var singleUser in responseData) {
      Data_Model3 user = Data_Model3(
          id: singleUser["id"].toString(),
          category: singleUser["category"].toString(),
          budget_limit_value_send: singleUser["budget_limit_value_send"]);

      //Adding user to the list.
      users.add(user);
      setState(() {
        limits=users;
      });

    }
    return users;
  }


  @override
  Widget build(BuildContext context) {

    final category = limits.map((limits) {
      final category_val = limits.category.toString();
      final budget_val = limits.budget_limit_value_send.toString();

      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
           // category_val.contains('salary') ? Text(budget_val):Text("none"),
           // category_val.contains('shopping') ? Text(budget_val):Text("none"),

            category_val.contains('salary') ? Text(test=budget_val)  : Text("no"),



            // Text(
            //   category_val,
            //   style: TextStyle(fontSize: 20, color: Colors.red),
            // ),
            // Text(
            //   budget_val,
            //   style: TextStyle(fontSize: 20, color: Colors.red),
            // ),
          ],
        ),
      );
    }).toList();

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),

          // ...allHorsepower,
          ...category,

          TextButton(onPressed: (){
            print(limits);
          }, child: Text("hbd")),
        ],
      ),
    );
  }
}


