import 'dart:convert';

import 'package:expense_dummy/Home_Page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Add_Custom_category.dart';
import 'package:http/http.dart' as http;

import 'Data Model/Data_Model.dart';
import 'Data Model/Data_Model2.dart';
import 'Data Model/Data_Model3.dart';
import 'list _Test.dart';
import 'main.dart';

class AddExpenseNoGradient extends StatefulWidget {
  const AddExpenseNoGradient({Key? key}) : super(key: key);

  @override
  _AddExpenseNoGradientState createState() => _AddExpenseNoGradientState();
}

class _AddExpenseNoGradientState extends State<AddExpenseNoGradient> {
  TextEditingController budget_controller = TextEditingController();

var test;
  var test1;
  var test2;
  var test3;
  var test4;

  @override
  void initState() {
    budget_limit_value_send = '';
    percentage1;

    getRequest1();

    budget_item;

    // TODO: implement initState
    super.initState();
    getAllCategory();
  }

  var  hascontain_sal;

  String? selectedValue;
  var categoryItemList = [];
  var category_item = [];
  var budget_item;
  var limits = [];

  Future getAllCategory() async {
    var url =
        "http://$ip_address/Expense_Management/display_Custom_category.php";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryItemList = jsonData;
      });
    }
  }

  Future<List<Data_Model1>> getRequest1() async {
    //replace your restFull API here.
    String url =
        "http://$ip_address/Expense_Management/Display_budget_limit.php";

    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    setState(() {
      category_item = responseData;
      hascontain_sal = category_item.contains('salary');
    });

    //Creating a list to store input data;
    List<Data_Model1> users = [];
    for (var singleUser in responseData) {
      Data_Model1 user = Data_Model1(
        id: singleUser["id"].toString(),
        category: singleUser["category"].toString(),
        budget_limit: singleUser["budget_limit"].toString(),
      );

      users.add(user);
    }
    return users;
  }

// String bb ='km';
//   var _currencies = [
//     "Food",
//     "Transport",
//     "Personal",
//     "Shopping",
//     "Medical",
//     "Rent",
//     "Movie",
//     "Salary"
//   ];

  //String dropdownValue = 'Salary';

  DateTime selectedDate = DateTime.now();
  dynamic amount;
  dynamic note = "Expense";
  dynamic type = "Income";

  List<dynamic> months = [
    "null",
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final category = limits.map((limits) {
      final category_val = limits.category.toString();
      final budget_val = limits.budget_limit_value_send.toString();



      return Row(
        children: [

          category_val.contains('salary') ? Text(test=budget_val)  :
          category_val.contains('food') ? Text(test1=budget_val)  :
          category_val.contains('shopping') ? Text(test2=budget_val)  :
          category_val.contains('transportation') ? Text(test3=budget_val)  :
          category_val.contains('entertainment') ? Text(test4=budget_val)  :


          Text("no"),

          // selectedValue == 'salary' ? budget_controller.text =
          //     budget_controller.text=budget_val
          //
          //     :


        ],
      );

    }).toList();


    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      backgroundColor: Colors.white,
      //
      body: ListView(
        padding: EdgeInsets.all(
          12.0,
        ),
        children: [
          Text(
            "\nAdd Transaction & Set Budget Limit ",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          //
          SizedBox(
            height: 20.0,
          ),
          //
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  //  color: Static.PrimaryColor,
                  borderRadius: BorderRadius.circular(
                    16.0,
                  ),
                ),
                padding: EdgeInsets.all(
                  12.0,
                ),
                child: Icon(
                  Icons.attach_money,
                  size: 24.0,
                  // color: Colors.grey[700],
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "0",
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                  onChanged: (val) {
                    try {
                      amount = int.parse(val);

                      amount >= 10 && amount <= 100
                          ? percentage1 = '20'
                          : amount >= 110 && amount <= 200
                              ? percentage1 = '40'
                              : amount >= 210 && amount <= 400
                                  ? percentage1 = '60'
                                  : amount >= 410 && amount <= 500
                                      ? percentage1 = '80'
                                      : amount == 500
                                          ? 'budget exceeded'
                                          : "no";
                    } catch (e) {
                      // show Error
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          duration: Duration(
                            seconds: 2,
                          ),
                          content: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                "Enter only Numbers as Amount",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  // textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          //
          SizedBox(
            height: 20.0,
          ),
          //

          //
          // TextFormField(
          //   controller: budget_controller,
          // ),
          //
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  //   color: Static.PrimaryColor,
                  borderRadius: BorderRadius.circular(
                    16.0,
                  ),
                ),
                padding: EdgeInsets.all(
                  12.0,
                ),
                child: Icon(
                  Icons.description,
                  size: 24.0,
                  // color: Colors.grey[700],
                  color: Colors.blue,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 20),
                  child: DropdownButtonFormField(
                    hint: Text("Select your category"),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        //<-- SEE HERE
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        //<-- SEE HERE
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      filled: true,
                     // fillColor: Color(0xffe2e7ef),
                      fillColor: Colors.white,
                    ),
                    dropdownColor: Color(0xffe2e7ef),
                    // value: dropdownValue,
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;

                        // selectedValue == "food" ? budget_limit_value_send ='500' :
                        // selectedValue == "shopping" ?  budget_limit_value_send = "2000":
                        // selectedValue =="transportation" ? budget_limit_value_send ='1000':
                        // selectedValue =="movies" ?budget_limit_value_send ='500':
                        // selectedValue =="salary" ?budget_limit_value_send ='salary':SizedBox(height: 1,);

                        // selectedValue == "food"
                        //     ? budget_limit_value_send = budget_controller.text
                        //     : selectedValue == "shopping"
                        //         ? budget_limit_value_send =
                        //             budget_controller.text
                        //         : selectedValue == "transportation"
                        //             ? budget_limit_value_send =
                        //                 budget_controller.text
                        //             : selectedValue == "movies"
                        //                 ? budget_limit_value_send =
                        //                     budget_controller.text
                        //                 // : selectedValue == "salary"
                        //                 //     ? budget_limit_value_send=
                        //                     : SizedBox(
                        //                         height: 5,
                        //                       );
                        //

                        // selectedValue == 'salary' ?
                        // budget_controller.text='20000' : budget_controller.text ='set budget limit';

                        // selectedValue == 'salary' ?
                        // budget_controller.text=category_item.last.toString()
                        //
                        //     : budget_controller.text ='set budget limit';

                        selectedValue == 'salary' ? budget_controller.text = test:
                        selectedValue == 'food' ? budget_controller.text = test1:
                        selectedValue == 'shopping' ? budget_controller.text = test2:
                        selectedValue == 'transportation' ? budget_controller.text = test3:
                        selectedValue == 'entertainment' ? budget_controller.text = test4:

                        "add";



                        
                      });
                    },
                    items: categoryItemList.map((category) {
                      return DropdownMenuItem<String>(
                          value: category['category'],
                          child: Text(category['category']));
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),

          //  Text(dropdownValue),

          // selectedValue == 'salary'
          //     ? SizedBox(
          //         height: 5,
          //       )
          //     :

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.wallet,
                  color: Colors.blue,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 25, right: 20, top: 20),
                  child: TextFormField(
                    controller: budget_controller,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a Budget Limit";
                      }
                      return null;
                    },
                    onSaved: (name) {},
                    obscureText: false,
                    decoration: InputDecoration(
                      label: Text("Set Budget Limit"),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          // color: Colors.grey[400],
                          color: Colors.grey.shade500,
                          width: 2,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.grey.shade500,
                      )),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  //   color: Static.PrimaryColor,
                  borderRadius: BorderRadius.circular(
                    16.0,
                  ),
                ),
                padding: EdgeInsets.all(
                  12.0,
                ),
                child: Icon(
                  Icons.description,
                  size: 24.0,
                  // color: Colors.grey[700],
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Note on Transaction",
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                  onChanged: (val) {
                    note = val;
                  },
                ),
              ),
            ],
          ),
          //
          SizedBox(
            height: 20.0,
          ),
          //
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  //    color: Static.PrimaryColor,
                  borderRadius: BorderRadius.circular(
                    16.0,
                  ),
                ),
                padding: EdgeInsets.all(
                  12.0,
                ),
                child: Icon(
                  Icons.attach_money,
                  size: 24.0,
                  // color: Colors.grey[700],
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              ChoiceChip(
                label: Text(
                  "Income",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: type == "Income" ? Colors.white : Colors.black,
                  ),
                ),
                selectedColor: Colors.blue.shade700,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      type = "Income";
                      if (note.isEmpty || note == "Expense") {
                        note = 'Income';
                      }
                    });
                  }
                },
                selected: type == "Income" ? true : false,
              ),
              SizedBox(
                width: 8.0,
              ),
              ChoiceChip(
                label: Text(
                  "Expense",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: type == "Expense" ? Colors.white : Colors.black,
                  ),
                ),
                selectedColor: Colors.blue.shade700,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      type = "Expense";

                      if (note.isEmpty || note == "Income") {
                        note = 'Expense';
                      }
                    });
                  }
                },
                selected: type == "Expense" ? true : false,
              ),
            ],
          ),
          //
          SizedBox(
            height: 20.0,
          ),
          //
          SizedBox(
            height: 50.0,
            child: TextButton(
              onPressed: () {
                _selectDate(context);
                //
                // to make sure that no keyboard is shown after selecting Date
                FocusScope.of(context).unfocus();
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  EdgeInsets.zero,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // color: Static.PrimaryColor,
                      borderRadius: BorderRadius.circular(
                        16.0,
                      ),
                    ),
                    padding: EdgeInsets.all(
                      12.0,
                    ),
                    child: Icon(
                      Icons.date_range,
                      size: 24.0,
                      // color: Colors.grey[700],
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    // "${selectedDate.day } - ${selectedDate.month} -${selectedDate.year} ",
                    "${selectedDate.day} ${months[selectedDate.month]}",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 20.0,
          ),
          //
          //
          // category_item == 'shopping' && budget_item =='2000' ? Text(""):
          // TextButton(onPressed: (){}, child: Text("add")),
          //
          // category_item == 'food' && budget_item =='500' ? Text(""):
          // TextButton(onPressed: (){}, child: Text("add")),

          SizedBox(
            height: 50.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlueAccent.shade400,
              ),
              onPressed: () {
                if (amount != null) {
                  print(category_item);
                  print(budget_item);

                  setState(() {
                    Submit();

                    selectedValue == 'salary' && amount > 20000
                        ? print("limited")
                        : print("go");
                    selectedValue == 'shopping' && amount > 5000
                        ? print("limited")
                        : print("go");
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red[700],
                      content: Text(
                        "Please enter a valid Amount !",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }
              },
              child: Text(
                "Add",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 50.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlueAccent.shade400,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Custom_category()));
              },
              child: Text(
                "Add Custom Category",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          SizedBox(
            height: 50,
          ),

          Container(
            height:300,
            width: 400,
           // color: Colors.orange.shade100,
            child: FutureBuilder(
              future: getRequest(),
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      SizedBox(height: 10,),
                      Text(
                        "Budget Limit Status",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20,color: Colors.teal.shade900),
                      ),
                      Flexible(
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (ctx, index) =>
                                Card(
                                  child: ListTile(
                            leading:Text(snapshot.data[index].category),
                            trailing:Text(snapshot.data[index].budget_limit_value_send) ,
                          ),
                                )
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),

          // Text(category_item.toString()),


          // TextButton(onPressed: (){
          //
          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>list_test()));
          //
          // }, child: Text("vgv")),
        ],
      ),
    );
  }

  Future Submit() async {
    var APIURL = "http://$ip_address/Expense_Management/Add_transaction.php";

    //json maping user entered details
    Map maped_data = {
      'amount': amount.toString(),
      'type': type.toString(),
      'date': selectedDate.toString(),
      'note': note.toString(),
      'category': selectedValue,
      'budget_limit_value_send': budget_controller.text,
    };
    //send  data using http post to our php code
    http.Response reponse =
        await http.post(Uri.parse(APIURL), body: maped_data);

    //getting response from php code, here
    var data = jsonDecode(reponse.body);
    var responseMessage = data["message"];
    var responseError = data["error"];

    // print("DATA: ${data}");
    print(data);

    if (responseError) {
      setState(() {});
    } else {
      setState(() {});
      Fluttertoast.showToast(
          msg: "Add successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home_Page()));
    }
  }

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
      setState(() {
        limits=users;
      });

      //Adding user to the list.
      users.add(user);
    }
    return users;
  }
}

// code for floating action button
//  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.of(context)
//                 .push(
//               MaterialPageRoute(
//                 builder: (context) => AddExpenseNoGradient(),
//               ),
//             )
//                 .then((value) {
//               setState(() {});
//             });
//           },
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(
//               16.0,
//             ),
//           ),
//           backgroundColor: Colors.grey,
//           child: Icon(
//             Icons.add_outlined,
//             size: 32.0,
//           ),
//         ),

//    Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 10,right: 20),
//                   child: DropdownButtonFormField(
//                     decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         //<-- SEE HERE
//                         borderSide: BorderSide(color: Colors.grey, width: 2),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         //<-- SEE HERE
//                         borderSide: BorderSide(color: Colors.grey, width: 2),
//                       ),
//                       filled: true,
//                       fillColor: Color(0xffe2e7ef),
//                     ),
//                     dropdownColor: Color(0xffe2e7ef),
//                    // value: dropdownValue,
//                     value: dropdownValue,
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         dropdownValue = newValue!;
//                       });
//                     },
//                     items: <String>['Shopping', 'Food', 'Transportation', 'Freelance','Salary','Gifts']
//                         .map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                          value: value,
//                         child: Text(
//                           value,
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       );
//                     }).toList(),
//
//
//
//
//                   ),
//                 ),
//               ),
