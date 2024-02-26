import 'package:authsystem/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final key = GlobalKey<FormState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  dynamic token = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Login')),
      ),
      body: Form(
        key: key,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value == "") {
                    return 'Enter a valid email!';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value == null || value == "") {
                    return 'Enter a Password!';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => {
                  if (!key.currentState!.validate())
                    {print("Form Data Not Valid!")}
                  else
                    {
                      _prefs.then((SharedPreferences prefs) {
                        prefs.setString('email', emailController.text);
                        prefs.setString('password', passwordController.text);
                        navigateToNextPageId();
                      })
                    }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToNextPageId() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => HomePage()));
  }
}
