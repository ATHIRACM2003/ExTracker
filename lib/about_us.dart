import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About_us extends StatefulWidget {
  const About_us({Key? key}) : super(key: key);

  @override
  State<About_us> createState() => _About_usState();
}

class _About_usState extends State<About_us> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Container(
        padding: EdgeInsets.only(top:70),
        decoration: const BoxDecoration(
          color: Colors.white70,
        borderRadius: BorderRadius.all(Radius.circular(15)),),
        height: 900,
        width: double.infinity,
        child:Column(
          children: [
        //margin: const EdgeInsets.symmetric(vertical: 70,horizontal: 30),
        Text("About US",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 24),),
    Container(
      decoration: const BoxDecoration(
       color: Color(0xffffb6c1),
        borderRadius: BorderRadius.all(Radius.circular(15)),),
      margin: const EdgeInsets.fromLTRB(20, 30, 20, 10),
    padding: const EdgeInsets.only(top: 25,left: 10),
    width: 360,
    height: 650,
    //color: Colors.pinkAccent.shade100,
    //child: Align(
    child: Text(
    "Welcome to ExTracker, your trusted companion in financial management and awareness. At Expense Tracker, we believe that understanding and controlling your expenses is the key to achieving your financial goals. Our app is designed with simplicity and effectiveness in mind, empowering individuals to take charge of their finances anytime, anywhere.We provide a user-friendly and comprehensive solution for expense tracking, categorization, analysis, and control.\n\nSmart Categorization\nExpense Tracker provides a pre-defined list of categories, but we understand everyone's spending habits are unique. Customize your expense categories to align with your lifestyle, giving you a deeper understanding of your spending patterns.\nDownload Expense Tracker now and take the first step towards a financially secure future.\nThank you for choosing ExTracker!"
    ,
    style: TextStyle(
    fontSize: 18,
    ),
    ),
    ),

        ],
        ),
      )
    );
  }
}
