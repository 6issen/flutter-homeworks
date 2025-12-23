import 'package:flutter/material.dart';

class JustPAge extends StatefulWidget {
  const JustPAge({super.key});

  @override
  State<JustPAge> createState() => _JustPAgeState();
}

class _JustPAgeState extends State<JustPAge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(child: Row(children: [],),)
      ),
    );
  }
}
