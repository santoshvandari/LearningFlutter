import 'package:flutter/material.dart';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  State createState() => _CurrencyConverterHome();
}

class _CurrencyConverterHome extends State {
  double convertedvalue = 0;
  double exchangerate = 144;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(36, 54, 66, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(36, 54, 66, 1),
        foregroundColor: const Color.fromRGBO(226, 241, 231, 1),
        title: const Text("Currency Converter"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text Area
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "NPR ${convertedvalue.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 50,
                  color: Color.fromRGBO(226, 241, 231, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Input field
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                controller: textEditingController,
                style: const TextStyle(
                    color: Color.fromRGBO(226, 241, 231, 1), fontSize: 16),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(15, 5, 10, 5),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(98, 149, 132, 1),
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(98, 149, 132, 1),
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                  ),
                  hintText: "Please Enter Amount in USD",
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(226, 241, 236, 1),
                  ),
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                  prefixIconColor: Color.fromRGBO(226, 241, 236, 1),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),

            // button
            TextButton(
              onPressed: () {
                try {
                  double value = double.parse(textEditingController.text);
                  debugPrint(value.toString());
                  setState(() {
                    convertedvalue = value * exchangerate;
                  });
                } catch (e) {
                  debugPrint(e.toString());
                  setState(() {
                    convertedvalue = 0.0;
                  });
                }
              },
              style: TextButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(256, 116, 120, 1),
                  foregroundColor: const Color.fromRGBO(226, 241, 231, 1),
                  maximumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  "Calculate",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
