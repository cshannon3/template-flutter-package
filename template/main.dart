

import 'package:{{_ "toLower" name}}/controllers.dart';
import 'package:{{_ "toLower" name}}/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //double width = ;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
class Home extends StatefulWidget {
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UIController uiController;
  DataController controller;

  //UI_SCREEN _local_screen;

 @override
  void initState() {
    super.initState();
    
    uiController = UIController();
    controller = DataController();
    uiController.addListener((){
    if (uiController.uiEvent == UI_EVENT.NEWSCREEN){
        setState(() {});
      }
    });
    
  }
  
  Widget _getCurrentScreen(){
    
    switch (uiController.currentScreen){
      case UI_SCREEN.HOMESCREEN:
  
        //return HomeScreen();
        return HomeScreen(controller: controller, uiController: uiController,);
        break;
     
      case UI_SCREEN.HISTORYSCREEN:
        return HistoryScreen();
    
        break;
      case UI_SCREEN.SETTINGSSCREEN:
        return SettingsScreen();
        break;

      case UI_SCREEN.ACTIVITYSCREEN:
        return ActivityScreen(controller: controller, uiController: uiController,);
        break;
    }
    return Container();

  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text("Music"),
      leading: IconButton(
        icon: Icon(Icons.arrow_left),
        onPressed: (){
          uiController.changeScreen(UI_SCREEN.HOMESCREEN);
        },
        ),
        actions: <Widget>[
          IconButton(
        icon: Icon(Icons.home),
        onPressed: (){
          uiController.changeScreen(UI_SCREEN.HOMESCREEN);
        },
        ),
        IconButton(
        icon: Icon(Icons.settings),
        onPressed: (){
          uiController.changeScreen(UI_SCREEN.SETTINGSSCREEN);
        },
        ),
        ],
        ),
        
      body: _getCurrentScreen(),
    );
  }
}