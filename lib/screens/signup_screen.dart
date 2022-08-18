import 'package:flutter/material.dart';
import 'package:linkedin_clone/screens/login_screen.dart';
import 'package:linkedin_clone/widgets/text_input.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Uperside

              Image.asset(
                'assets/logo.png',
                width: 120,
              ),

             const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 const Text(
                    'Join LinkedIn',
                    style: TextStyle(fontSize: 40),
                  ),
                  Row(
                    children: [
                      Text('or'),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text('Sign in'))
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              //Input Fields

              TextInputBox(textController: _emailController, hintText: 'Email'),
              TextInputBox(
                  textController: _passwordController, hintText: 'Password'),

              //Button

              InkWell(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 25),
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15)),
                  child: const Center(
                      child: Text(
                    'Continue',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
