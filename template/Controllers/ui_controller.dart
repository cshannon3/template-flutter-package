import 'package:flutter/material.dart';

enum UI_SCREEN{
  HOMESCREEN,
  HISTORYSCREEN,
  SETTINGSSCREEN,
  ACTIVITYSCREEN

  //.. etc
}
enum UI_OVERLAY {
  CURRENTTASK,
  MENU,
  NONE,
}


enum UI_EVENT {
  NEWSCREEN,
  NEWOVERLAY, 
  CLOSEOVERLAY,
  NONE
}
class UIController extends ChangeNotifier{

  UI_SCREEN _currentScreen = UI_SCREEN.HOMESCREEN;
  UI_OVERLAY _currentOverlay = UI_OVERLAY.NONE;
  
  UI_EVENT _uiEvent = UI_EVENT.NONE;


  UI_SCREEN get currentScreen => _currentScreen;
  UI_OVERLAY get currentOverlay => _currentOverlay;
  UI_EVENT get uiEvent => _uiEvent;
  void changeScreen(UI_SCREEN newScreen){
    _currentScreen=newScreen;
    _currentOverlay =UI_OVERLAY.NONE;
    _uiEvent = UI_EVENT.NEWSCREEN;
    notifyListeners();
  }

  void addOverlay(UI_OVERLAY newOverlay){
    _currentOverlay = newOverlay;
    _uiEvent = UI_EVENT.NEWOVERLAY;
    notifyListeners();
  }

  void closeOverlay(){
    _currentOverlay =UI_OVERLAY.NONE;
    _uiEvent = UI_EVENT.CLOSEOVERLAY;
    notifyListeners();
  }



}
