import 'package:flutter/material.dart';

class ClimateDaysScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Climates"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text("Veja como será o clima nos próximos 5 dias."),
      ),
    );
  }
}
