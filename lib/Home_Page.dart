import 'dart:convert';
import 'package:expense_dummy/settings.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Data Model/Data_Model.dart';
import 'Data Model/Data_Model2.dart';
import 'Registration.dart';
import 'Add_Transaction.dart';
import 'confirm_dialog.dart';
import 'info_snackbar.dart';
// import 'main.dart';
import '';
import 'main.dart';

class Home_Page extends StatefulWidget {
  @override
  _Home_PageState createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  var budget_result;

  var lim;

  var bb;

  var test = '80';

  var get_percentage;

  Registration reg_obj = Registration();

  DateTime selectedDate = DateTime.now();
  Map? data;
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  List<FlSpot> dataSet = [];
  DateTime today = DateTime.now();
  DateTime now = DateTime.now();
  int index = 1;

  int index1 = 1;
  DateTime today1 = DateTime.now();


   List<Data_Model> _user= [];

  @override
  void initState() {
    getRequest();
    get_percentage = '0';
    // TODO: implement initState
    super.initState();
  }

  List<String> months = [
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

//Applying get request.

  Future<List<Data_Model>> getRequest() async {
    //replace your restFull API here.
    String url =
        "http://$ip_address/Expense_Management/Display_Transaction_data.php";

    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    //Creating a list to store input data;
    List<Data_Model> users = [];
    for (var singleUser in responseData) {
      Data_Model user = Data_Model(
        id: singleUser["id"].toString(),
        amount: int.parse(singleUser["amount"]),
        type: singleUser["type"].toString(),
        note: singleUser["note"].toString(),
        date: DateTime.parse(singleUser["date"]),
        category: singleUser["category"].toString(),
        budget_limit_value_send:singleUser["budget_limit_value_send"]


      );

      //Adding user to the list.
      users.add(user);
    }
    return users;
  }

  Future<List<Data_Model1>> getRequest1() async {
    //replace your restFull API here.
    String url =
        "http://$ip_address/Expense_Management/Display_budget_limit.php";

    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    //Creating a list to store input data;
    List<Data_Model1> users1 = [];
    for (var singleUser in responseData) {
      Data_Model1 user = Data_Model1(
        id: singleUser["id"].toString(),
        budget_limit: (singleUser["budget_limit"]),
        category: singleUser["category"].toString(),
      );

      //Adding user to the list.
      users1.add(user);
    }
    return users1;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print(get_percentage);

            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => AddExpenseNoGradient(),
              ),
            )
                .then((value) {
              setState(() {});
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              16.0,
            ),
          ),
          backgroundColor: Colors.cyan.shade600,
          child: Icon(
            Icons.add_outlined,
            size: 32.0,
          ),
        ),
        body: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [

                Flexible(
                  child: FutureBuilder(
                      future: getRequest(),
                      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: Colors.red.shade900,
                                    strokeWidth: 5,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Data Loading Please Wait!",
                                    style: TextStyle(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }


                         _user = snapshot.data;

                        getTotalBalance(snapshot.data!);
                        getPlotPoints(snapshot.data!);

                        return ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(
                                12.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    maxRadius: 20,
                                    child: Image.asset("assets/card-payment.png"),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 200.0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Welcome",
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.w700,
                                            //  color: Static.PrimaryMaterialColor[800],
                                          ),
                                          maxLines: 1,
                                        ),
                                        Text("${get_username}"),
                                        // Text("${get_id}"),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        12.0,
                                      ),
                                      color: Colors.white70,
                                    ),
                                    padding: EdgeInsets.all(
                                      12.0,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(
                                          MaterialPageRoute(
                                            builder: (context) => Settings(),
                                          ),
                                        )
                                            .then((value) {
                                          setState(() {});
                                        });
                                      },
                                      child: Icon(
                                        Icons.settings,
                                        size: 32.0,
                                        color: Color(0xff3E454C),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            selectMonth(),

                            //selecWeek(),

                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              margin: EdgeInsets.all(
                                12.0,
                              ),
                              child: Ink(
                                decoration: BoxDecoration(
                                  color: Colors.teal.shade600,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      24.0,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        24.0,
                                      ),
                                    ),
                                    // color: Static.PrimaryColor,
                                  ),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 18.0,
                                    horizontal: 8.0,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Total Balance',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          // fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12.0,
                                      ),
                                      Text(
                                        'Rs $totalBalance',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 36.0,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            cardIncome(
                                              totalIncome.toString(),
                                            ),
                                            cardExpense(
                                              totalExpense.toString(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(
                                12.0,
                              ),
                              child: Text(
                                "${months[today.month - 1]} ${today.year}",
                                //"${months[today.month]} ${today.year}",

                                // "  ${months[selectedDate.month]}",

                                style: TextStyle(
                                  fontSize: 32.0,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            dataSet.isEmpty || dataSet.length < 2
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 40.0,
                                      horizontal: 20.0,
                                    ),
                                    margin: EdgeInsets.all(
                                      12.0,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        8.0,
                                      ),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(
                                              0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      "Not Enough Data to render Chart",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 400.0,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 40.0,
                                      horizontal: 12.0,
                                    ),
                                    margin: EdgeInsets.all(
                                      12.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(
                                              0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: LineChart(
                                      LineChartData(
                                        borderData: FlBorderData(
                                          show: false,
                                        ),
                                        lineBarsData: [
                                          LineChartBarData(
                                            // spots: getPlotPoints(snapshot.data!),
                                            spots: getPlotPoints(snapshot.data!),
                                            isCurved: false,
                                            barWidth: 2.5,
                                            // colors: [
                                            //   Static.PrimaryColor,
                                            // ],
                                            showingIndicators: [200, 200, 90, 10],
                                            dotData: FlDotData(
                                              show: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                            // access_limit(),


                           // Get_Limit_Fnction(),


                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                "Recent Transactions",
                                style: TextStyle(
                                  fontSize: 32.0,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length + 1,
                              itemBuilder: (context, index) {
                                Data_Model dataAtIndex;
                                try {
                                  // dataAtIndex = snapshot.data![index];
                                  dataAtIndex = snapshot.data![index];
                                } catch (e) {
                                  // deleteAt deletes that key and value,
                                  // hence makign it null here., as we still build on the length.
                                  return Container();
                                }

                                if (dataAtIndex.date.month == today.month) {
                                  if (dataAtIndex.type == "Income") {
                                    return incomeTile(
                                      dataAtIndex.amount,
                                      dataAtIndex.note,
                                      dataAtIndex.date,
                                      index,
                                      dataAtIndex.id,
                                      dataAtIndex.category,
                                    );
                                  } else {
                                    return expenseTile(
                                      dataAtIndex.amount,
                                      dataAtIndex.note,
                                      dataAtIndex.date,
                                      index,
                                      dataAtIndex.id,
                                      dataAtIndex.category,
                                      dataAtIndex.budget_limit_value_send,
                                    );
                                  }
                                } else {
                                  return Container();
                                }
                              },
                            ),

                            SizedBox(
                              height: 50,
                            ),
                          ],
                        );
                      }),



                ),
                // Container(
                //   height: 100,
                //   width: 400,
                //   color: Colors.orange.shade100,
                //   child: Container(
                //     padding: EdgeInsets.all(16.0),
                //     child: FutureBuilder(
                //       future: getRequest1(),
                //       builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                //         if (snapshot.data == null) {
                //           return Container(
                //             child: Center(
                //               child: CircularProgressIndicator(),
                //             ),
                //           );
                //         } else {
                //           return Column(
                //             children: [
                //               Text("Budget Limit",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                //               Flexible(
                //                 child: ListView.builder(
                //
                //
                //                   itemCount: snapshot.data.length,
                //                   itemBuilder: (ctx, index) =>
                //
                //                       Row(
                //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //                         children: [
                //
                //                           Text(snapshot.data[index].category),
                //                           Text(snapshot.data[index].budget_limit),
                //
                //
                //                         ],
                //                       )
                //
                //                 ),
                //               ),
                //             ],
                //           );
                //         }
                //       },
                //     ),
                //   ),
                // ),

              ],
            )),
      ),
    );
  }

  getTotalBalance(List<Data_Model> entireData) {
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;
    for (Data_Model data in entireData) {
      if (data.date.month == today.month) {
        if (data.type == "Income") {
          totalBalance += data.amount;

          //Add and assignment
          //totalbBalance = totalBalance + data.Amount
          totalIncome += data.amount;
        } else {
          // totalBalance -=int.parse( data.amount);
          totalBalance -= data.amount;
          totalExpense += data.amount;
        }
      }
    }
  }

  List<FlSpot> getPlotPoints(List<Data_Model> entireData) {
    dataSet = [];
    List tempdataSet = [];

    for (Data_Model item in entireData) {
      if (item.date.month == today.month && item.type == "Expense") {
        tempdataSet.add(item);
      }
    }
    //
    // Sorting the list as per the date
    tempdataSet.sort((a, b) => a.date.day.compareTo(b.date.day));
    //
    for (var i = 0; i < tempdataSet.length; i++) {
      dataSet.add(
        FlSpot(
          tempdataSet[i].date.day.toDouble(),
          tempdataSet[i].amount.toDouble(),
        ),
      );
    }
    return dataSet;
  }

  Widget cardIncome(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          padding: EdgeInsets.all(
            6.0,
          ),
          child: Icon(
            Icons.arrow_downward,
            size: 28.0,
            color: Colors.green[700],
          ),
          margin: EdgeInsets.only(
            right: 8.0,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Income",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white70,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget cardExpense(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          padding: EdgeInsets.all(
            6.0,
          ),
          child: Icon(
            Icons.arrow_upward,
            size: 28.0,
            color: Colors.red[700],
          ),
          margin: EdgeInsets.only(
            right: 8.0,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Expense",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white70,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget selectMonth() {
    return Padding(
      padding: EdgeInsets.all(
        2.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                index = 4;
                today = DateTime(now.year, now.month - 2, today.day);
              });
            },
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
                color: index == 4 ? Colors.lightBlueAccent.shade400 : Colors.grey.shade300,
              ),
              alignment: Alignment.center,
              child: Text(
                months[now.month - 3],
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: index == 4 ? Colors.white : Colors.blue,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                index = 2;
                today = DateTime(now.year, now.month - 1, today.day);
              });
            },
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
                color: index == 2 ? Colors.lightBlueAccent.shade400 : Colors.grey.shade300,
              ),
              alignment: Alignment.center,
              child: Text(
                months[now.month - 2],
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: index == 2 ? Colors.white : Colors.blue,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                index = 1;
                today = DateTime.now();
              });
            },
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
                color: index == 1 ? Colors.lightBlueAccent.shade400 : Colors.grey.shade300,
              ),
              alignment: Alignment.center,
              child: Text(
                months[now.month - 1],
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: index == 1 ? Colors.white : Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget expenseTile(
      var value, String note, DateTime date, var index, snap, String category, String budget_limit_value_send) {
    return InkWell(
      splashColor: Colors.blue,
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          deleteInfoSnackBar,
        );
      },
      onLongPress: () async {
        bool? answer = await showConfirmDialog(
          context,
          "WARNING",
          "This will delete this record. This action is irreversible. Do you want to continue ?",
        );
        if (answer != null && answer) {
          setState(() {
            delrecord(snap);

          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(18.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_circle_up_outlined,
                          size: 28.0,
                          color: Colors.red[700],
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          "Expense",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),

                    //
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        "${date.day} ${months[date.month - 1]} ",
                        style: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "- $value".toString(),
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    //

                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        category.toString(),
                        style: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        note,
                        style: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        children: [
                          Text("Budget Limit:",style: TextStyle(color: Colors.red.shade900),),
                          Text(
                             budget_limit_value_send.toString(),
                            style: TextStyle(
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),



            LinearPercentIndicator(
              animationDuration: 2000,
              lineHeight: 20,
              animation: true,
              progressColor: Colors.orange.shade700,
              linearStrokeCap: LinearStrokeCap.roundAll,
              percent: double.parse(get_percentage) / 100,

               center: Calculation(int.parse(budget_limit_value_send), value),


            ),
          ],
        ),
      ),
    );
  }

  Calculation(
    var limi,
    var val,
  ) {
    var test = (val / limi) * 100;
    return Text("${double.parse(get_percentage = test.toString())}%");
  }

  // String calculation2(List<Data_Model> _user) {
  //
  //   for (int i = 0; i < _user.length; i++) {
  //
  //     // var test = _user[i].amount + _user[i].amount * 100;
  //
  //     var test = int.parse(_user[i].amount) + int.parse(_user[i].amount) * 100 .toString()
  //
  //     get_percentage = test.toString();
  //
  //   }
  //   return get_percentage;
  // }


  Widget incomeTile(
      int value, String note, DateTime date, int index, snap, String category) {
    return InkWell(
      splashColor: Colors.blue,
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          deleteInfoSnackBar,
        );
      },
      onLongPress: () async {
        bool? answer = await showConfirmDialog(
          context,
          "WARNING",
          "This will delete this record. This action is irreversible. Do you want to continue ?",
        );

        if (answer != null && answer) {
          //  await dbHelper.deleteData(index);
          setState(() {
            delrecord(snap);
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(18.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
        //  color: Color(0xffced4eb),
          color: Colors.black12,
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.arrow_circle_down_outlined,
                      size: 28.0,
                      color: Colors.green[700],
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      "Credit",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                //
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "${date.day} ${months[date.month - 1]} ",
                    style: TextStyle(
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                //
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "+ $value",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                //
                //

                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    note,
                    style: TextStyle(
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> delrecord(String id) async {
    String url = "http://$ip_address/Expense_Management/Delete_Transaction.php";
    var res = await http.post(Uri.parse(url), body: {
      "id": id,
    });
    var resoponse = jsonDecode(res.body);
    if (resoponse["success"] == "true") {
      setState(() {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home_Page()));
      });
      print("success");
    }
  }
}
