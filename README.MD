
NOT FUNCTIONAL
currently just trying to create Proof of Concept

Creating a template generator and vs extension, 
that enables the user to start from my perferred project structure in flutter

HOW Template Works
INSTALL
1. Install vs code template extension
npm install -g @fabiospampinato/template
2. Get this template
template install cshannon3/template-flutter-package flutter-package

USAGE
1. Create new flutter app using the official vscode flutter extension 
2. Delete the libs folder that has the main.dart file in it
3. Open terminal and create a new libs file from template
template create flutter-package libs
4. Enter the flutter app name for name
5. Update the yaml file to include any packages that the template uses(will list them in the readme)



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



TODO
TOP -> figure out how to 
commands to create models/ Screens/ etc -> need to create a real extension for that

choice of local db, firebase, or no db -> taking too much time to figure out, will make seperate templates for each

Options like webview, maps etc -> delegate to real extension
Structure for api communication and json parsing ->
    Bloc for streams of data - > 
        Test and refract db, firebase, api etc - > 
                do in a seperate api/bloc template
                
Instructions on how to use google console + more examples

Move examples to example templates then give user options on including:
1. Firebase/Local Db
2. Webview
3. Api Class
4. Models/ Models linked to DB
5. Different google services like maps
6. Flare Example
7. Assets Example


list packages that are needed for different applications

 Eventually figure out how to generate full flutter project and not just dart files...until then, explain steps necessary to get project to work
 