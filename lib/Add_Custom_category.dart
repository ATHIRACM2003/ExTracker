import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'main.dart';
import 'package:http/http.dart' as http;




class Custom_category extends StatefulWidget {
  const Custom_category({Key? key}) : super(key: key);

  @override
  State<Custom_category> createState() => _Custom_categoryState();
}

class _Custom_categoryState extends State<Custom_category> {

  TextEditingController category = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late bool status;
  late String message;

  @override
  void initState() {
    category = TextEditingController();


    status = false;
    message = "";

    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add your Custom category"),
        backgroundColor: Colors.lightBlueAccent.shade400,
        centerTitle: true,

      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key:_formkey,
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: category,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintText: "Enter category",
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                SizedBox(height:20),


                SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Submit();
                        category.clear();



                      },
                      child: Text("SUBMIT"),
                    ),
                   // Text(status ? message : message,style: TextStyle(color: Colors.red.shade900),),







                  ],
                )

              ],
            ),
          ),
        ),

      ),

    );
  }
  Future Submit() async {
    var APIURL =
        "http://$ip_address/Expense_Management/Add_category.php";


    //json maping user entered details
    Map maped_data = {
      'category': category.text,

    };
    //send  data using http post to our php code
    http.Response reponse = await http.post(Uri.parse(APIURL), body: maped_data);

    //getting response from php code, here
    var data = jsonDecode(reponse.body);
    var responseMessage = data["message"];
    var responseError = data["error"];

    // print("DATA: ${data}");
    print(data);

    if (responseError) {
      setState(() {
        status = false;
        message = responseMessage;
      });
    } else {
      category.clear();


      setState(() {
        status = true;
        message = responseMessage;
      });
      Fluttertoast.showToast(
          msg: "Added successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey);
    }
  }

}
