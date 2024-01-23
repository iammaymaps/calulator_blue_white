import 'package:calulator_blue_white/Colors.dart';
import 'package:calulator_blue_white/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final List<String> buttons = [
  'C',
  'AC',
  '%',
  '/',
  '7',
  '8',
  '9',
  '*',
  '4',
  '5',
  '6',
  '-',
  '1',
  '2',
  '3',
  '+',
  '.',
  '0',
  '+/-',
  '=',
];

var questions = "";

var answer = "";

bool isOparator(String x) {
  if (x == '%' ||
      x == '%' ||
      x == '/' ||
      x == '*' ||
      x == '-' ||
      x == '+/-' ||
      x == '+' ||
      x == '=') {
    return true;
  }
  return false;
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueColor,
      body: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Builder(builder: (context) {
                      return IconButton(
                        icon: Icon(
                          Icons.settings_outlined,
                          size: 35.r,
                          color: whiteColor,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    })
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 230.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          answer,
                          style: GoogleFonts.inter(
                            color: whiteColor,
                            fontSize: 60,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          questions,
                          style: GoogleFonts.inter(
                            color: whiteColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    color: whiteColor,
                    child: GridView.builder(
                        itemCount: buttons.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return Keywidget(
                              text: buttons[index],
                              BackgroundColor: Color(0xFF244C41),
                              color: blueColor,
                              Pressed: () {
                                setState(() {
                                  questions = "";
                                  answer = "";
                                });
                              },
                            );
                          } else if (index == 1) {
                            return Keywidget(
                              Pressed: () {
                                setState(() {
                                  questions = questions.substring(
                                      0, questions.length - 1);
                                });
                              },
                              text: buttons[index],
                              BackgroundColor: Color(0xFF244C41),
                              color: blueColor,
                            );
                          } else if (index == buttons.length - 1) {
                            return Keywidget(
                              Pressed: () {
                                setState(() {
                                  equelPressed();
                                });
                              },
                              text: buttons[index],
                              BackgroundColor: Color(0xFF244C41),
                              color: Color(0xFF97F85B),
                            );
                          } else {
                            return Keywidget(
                              Pressed: () {
                                setState(() {
                                  questions += buttons[index];
                                });
                              },
                              text: buttons[index],
                              BackgroundColor: isOparator(buttons[index])
                                  ? blueColor
                                  : Color(0xFF244C41),
                              color: isOparator(buttons[index])
                                  ? Color(0xFF244C41)
                                  : Color(0xFF97F85B),
                            );
                          }
                        }),
                  ))
            ],
          ))
        ],
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          GestureDetector(
            onTap: () async {
              final url =
                  "https://privacy-policy-blue-cal-pal.my.canva.site/privacy-policy";
              if (await canLaunch(url)) {
                await launch(url, forceSafariVC: false);
              } else {
                print("Error on the link");
              }
            },
            child: const ListTile(
              leading: Icon(Icons.error_outline_rounded),
              title: Text("Privacy Policy"),
            ),
          )
        ],
      )),
    );
  }

  void equelPressed() {
    String finalQuestion = questions;
    finalQuestion = finalQuestion.replaceAll('x', '*');

    Parser p = Parser();

    Expression exp = p.parse(finalQuestion);

    ContextModel cm = ContextModel();

    double evel = exp.evaluate(EvaluationType.REAL, cm);

    answer = evel.toString();
  }
}
