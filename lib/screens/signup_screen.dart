import 'package:flutter/material.dart';
import 'package:linkedin_clone/screens/home_screen.dart';
import 'package:linkedin_clone/screens/login_screen.dart';
import 'package:linkedin_clone/services/auth_methods.dart';
import 'package:linkedin_clone/utils/utils.dart';
import 'package:linkedin_clone/widgets/text_input.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  bool _isloading = true;
  void signupuser() async {
    setState(() {
      _isloading = false;
    });
    String res = await AuthMethods().signUpUser(
        _emailController.text, _nameController.text, _passwordController.text);

    if (res == 'success') {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isloading = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Uperside
              Image.asset(
                'assets/logo.png',
                width: 120,
              ),

              const SizedBox(
                height: 30,
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
                      const Text('or'),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: const Text(
                            'Sign in',
                            style: TextStyle(fontSize: 20),
                          ))
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
                  textController: _nameController, hintText: 'Full name'),
              TextInputBox(
                  textController: _passwordController, hintText: 'Password'),

              //Button

              InkWell(
                onTap: signupuser,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 25),
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15)),
                  child: _isloading ? const Center(
                      child: Text(
                    'Continue',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )):const Center(child: CircularProgressIndicator(color: Colors.white,),) ,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
