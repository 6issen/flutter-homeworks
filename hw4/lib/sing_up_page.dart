import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hw4/core/utils/validators/app_valid.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final GlobalKey<FormState> _formKey;

  
  
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Sing in',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                  children: [
                    TextFormField(
                      validator: (value) => AppValid.validateEmail(value),
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email, color: Colors.blueGrey,),
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 123, 160, 188),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) => AppValid.validatePassword(value),
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock, color: Colors.blueGrey,),
                        suffixIcon: Icon(Icons.visibility_off, color: Colors.blueGrey,),
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 123, 160, 188),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        log('Form is validate', name: "Form");
                      }
                    },
                        style:TextButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text('LOGIN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}