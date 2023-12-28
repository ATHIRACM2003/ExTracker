import 'dart:convert';
import 'package:expense_dummy/splashscreen.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'Registration.dart';
import 'Home_Page.dart';
import 'package:http/http.dart' as http;

import 'about_us.dart';
import 'main.dart';



class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Get_Usrname() async {
    final _CustomersharedPrefs = await SharedPreferences.getInstance();
    await _CustomersharedPrefs.setString("username",get_username);
  }

  Get_Id() async {
    final _CustomersharedPrefs = await SharedPreferences.getInstance();
    await _CustomersharedPrefs.setString("id",get_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

       // title: Image.asset('assets/cool.png',height: 50,width: 50,),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
           Image.asset("assets/end-user.png",height: 170,width: 170,),


            Form(
              key: formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child: TextFormField(
                      controller: username,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter username";
                        }
                        return null;
                      },
                      onSaved: (username) {},
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          // labelText: 'Email',
                          hintText: 'username'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    //padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: password,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter password";
                        }
                        return null;
                      },
                      onSaved: (name) {},
                      style: TextStyle(),
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter secure password'),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 20,),

            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
              width: MediaQuery.of(context).size.width / 1.3,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlueAccent.shade400,
                ),
                onPressed: ()
                //async
                {
                  setState(() {
                    admin_Login();
                  });

                  if (formkey.currentState!.validate()) {
                    print("session id is $key_value");

                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 35),
                ),

              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'New User?',
                  style: TextStyle(color: Colors.black87, fontSize: 15),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>   Registration()));
                              //builder: (context) =>   About_us()));

                    },
                    child: Text("Create Account"))
              ],
            )
          ],
        ),
      ),
    );
  }


  Future admin_Login() async {
    var url = "http://$ip_address/Expense_Management/Login.php";
    var response = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json'
    }, body: {
      "username": username.text,
      "password": password.text,
    });

    var data = json.decode(response.body);
    // if (data.toString() == "Success") {
    if (data != null) {
      //var responseData = json.decode(response.body);

      for (var singleUser in data) {
        final SharedPreferences sharedpreferences =
        await SharedPreferences.getInstance();

        await sharedpreferences.setString('admin_id', singleUser["id"]);

        // admin_id = singleUser["id"];
        //
        get_username = singleUser["username"];
        get_id =singleUser["id"];
        // print('hello click ${email_text_admin}');
        //
        // // getid = singleUser["id"];
        //
        Get_Id();
         Get_Usrname();
      }

      final snackBar = SnackBar(
        content: Text('Login Successfull'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  Home_Page()));
    } else {
      final snackBar = SnackBar(
        content: Text('Username and password invalid'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}


