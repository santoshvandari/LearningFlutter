import 'package:flutter/material.dart';

class CurrencyConverter extends StatelessWidget {
  const CurrencyConverter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color.fromRGBO(36, 54, 66, 1),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("0",
                  style: TextStyle(
                    fontSize: 50,
                    color: Color.fromRGBO(226, 241, 231, 1),
                    fontWeight: FontWeight.bold,
                  )),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  style: TextStyle(
                      color: Color.fromRGBO(226, 241, 231, 1), fontSize: 16),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15, 5, 10, 5),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(98, 149, 132, 1),
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(98, 149, 132, 1),
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                      ),
                      hintText: "Please Enter Amount in USD",
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(226, 241, 236, 1),
                      )),
                ),
              ),
            ],
          ),
        ));
  }
}
