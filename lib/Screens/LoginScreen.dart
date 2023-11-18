// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task/Screens/home.dart';
import 'package:flutter_task/Screens/register.dart';
import 'package:flutter_task/riverpods/authriverpods.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends ConsumerWidget {
  Login({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef widgetRef) {
    final authNotifer = widgetRef.watch(authProvider);
    
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Image.asset(
                    "assets/logo.png",
                    height: 120,
                    width: 120,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                        ),
                      ),
                      hintText: "Enter your Email",
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      filled: true,
                      fillColor: Color(0xfff5f5f5),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller:
                        passwordController, 
                    obscureText: true, 
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.lock_outline,
                          color: Colors.black,
                        ),
                      ),
                      hintText: "Enter your Password",
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      filled: true,
                      fillColor: Color(0xfff5f5f5),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 4),
                            blurRadius: 5.0)
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                        colors: [
                          Color(0xff6c63ff),
                          Color.fromARGB(255, 201, 151, 230),
                        ],
                      ),
                      color: Color(0xff00FFFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all(Size(300, 50)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {
                      
                        authNotifer
                            .loginUserWuthFirebase(
                                emailController.text, passwordController.text)
                            .then((value) => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Home())));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => Register()));
                      },
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.cairo(
                          color: Color(0xff6c63ff),
                          fontSize: 23,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
