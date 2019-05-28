
Creating a template generator and vs extension, 
that enables the user to start from my perferred project structure in flutter


TODO
commands to create models/ Screens/ etc
choice of local db, firebase, or no db
Options like webview, maps etc
Structure for api communication and json parsing
Bloc for streams of data


The core functionality of the app is done through 4 types of widgets:

1. Controllers - The Controllers are ChangeNotifiers that contain all info that must persist outside of any individual widget. They are split into two types:
    a. UI_Controller - all changes to the UI that     affect widgets other than the one that calls for the change go through this controller, which will notify the listeners in the widgets that control the UI trees
    b. Main_Controllers - all changes to the data underlying the app's functionality is done through this controller


2. Models - models store data in organized ways that can be used/modified by the controllers and widgets. They can't directly change the state of any UI or other data.

3. Stateful Widgets - The stateful widgets have the ability monitor and change the state of the app. In this project structure, there are 3 functions of stateful widgets
    a. UI - listens to UI controller and will change the state of its widget tree if called to
    b. Data - listens to Data Controller and will affect it's own state if called to
    c. Isolated - state changes are completely independent from the controller
    *A single widget can have multiple of these functions

4. Stateless Widgets - These have no way to monitor changes in state and can only affect state indirectly(ex through call backs). Functions of stateless:
    a. Structural(Ex Screens)- they can be used to form the structure around the stateful apps


