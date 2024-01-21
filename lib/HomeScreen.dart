import 'package:calulator_blue_white/buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

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
      backgroundColor: Color(0xFF97F85B),
      body: Column(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                child: Text(
                  questions,
                  style: GoogleFonts.unbounded(
                    color: Color(0xFF244C41),
                    fontSize: 80,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                child: Text(
                  answer,
                  style: GoogleFonts.unbounded(
                    color: Color(0xFF244C41),
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    color: Color(0xFF262626),
                    child: GridView.builder(
                        itemCount: buttons.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return Keywidget(
                              text: buttons[index],
                              BackgroundColor: Color(0xFF244C41),
                              color: Color(0xFF97F85B),
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
                              color: Color(0xFF97F85B),
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
                                  ? Color(0xFF97F85B)
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
