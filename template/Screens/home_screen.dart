import 'package:flutter/material.dart';
import 'package:{{name}}/Controllers/data_controller.dart';
import 'package:{{name}}/Controllers/ui_controller.dart';
import 'package:{{name}}/Models/activity_model.dart';
import 'package:{{name}}/shared.dart';


class HomeScreen extends StatelessWidget {
  final DataController controller;
  final UIController uiController;



  const HomeScreen({Key key, this.controller, this.uiController}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return Container();
  }
}