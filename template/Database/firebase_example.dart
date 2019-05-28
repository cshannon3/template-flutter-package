import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:{{_ "camelCase" name}}/Components/platform_adaptive.dart';

// TODO check if this works and write instructions on how to set up google console
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

class GroupChatScreen extends StatefulWidget {
  GroupChatScreen({
    Key key,
    this.title,
    this.team}) : super(key: key);

  final String title;
  final Group group;

  @override
  _GroupChatScreenState createState() => new _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> with TickerProviderStateMixin {
  List<ChatMessage> _messages = [];
  DatabaseReference _DBReference = FirebaseDatabase.instance.reference();
  TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;
  @override
  void initState() {
    super.initState();
    _testSignInWithGoogle().then((user) {
      //FirebaseAuth.instance.signInAnonymously().then((user) {
      _DBReference.child("groups").child(widget.group.id).child("messages").onChildAdded.listen((Event event) {
        var val = event.snapshot.value;
        _addMessage(
            name: val['sender']['name'],
            senderImageUrl: val['sender']['imageUrl'],
            text: val['text']
            );
      });
    });
  }
  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }


  Future<FirebaseUser> _testSignInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;
    final FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    _DBReference.child("groups").child(widget.group.id).child("group_name").set(widget.group.name);



    return currentUser;
  }
  void _handleMessageChanged(String text) {
    setState(() {
      _isComposing = text.length > 0;
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    _googleSignIn.signIn().then((user) {
      var myuser = {
          'username': user.displayName,
          'email': user.email
          };
      _DBReference.child("groups").child(widget.group.id).child("members").child(user.id).set(myuser);
      var message = {
        'sender': {'name': user.displayName, 'imageUrl': user.photoUrl},
        'text': text,
      };

      _DBReference.child("groups").child(widget.group.id).child("messages").push().set(message);
    });

  }
  void _addMessage(
      {String name,
        String text,
        String senderImageUrl
        }) {
    var animationController = new AnimationController(
      duration: new Duration(milliseconds: 700),
      vsync: this,
    );
    var sender = new ChatUser(username: name, imageUrl: senderImageUrl);
    var message = new ChatMessage(
        sender: sender,
        text: text,
        animationController: animationController);
    setState(() {
      _messages.insert(0, message);
    });
    animationController?.forward();
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(color: Theme.of(context).accentColor),
        child: new PlatformAdaptiveContainer(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: new Row(children: [

              new Flexible(
                child: new TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                  onChanged: _handleMessageChanged,
                  decoration:
                  new InputDecoration.collapsed(hintText: 'Send a message'),
                ),
              ),
              new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 4.0),
                  child: new PlatformAdaptiveButton(
                    icon: new Icon(Icons.send),
                    onPressed: _isComposing
                        ? () => _handleSubmitted(_textController.text)
                        : null,
                    child: new Text('Send'),
                  )),
            ])));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.group.name),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          new Flexible(
              child: new ListView.builder(
                padding: new EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) =>
                new ChatMessageListItem(_messages[index]),
                itemCount: _messages.length,
              )),
          new Divider(height: 1.0),
          new Container(
              decoration: new BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer()),
        ],
      ),
    );
  }
}
class ChatUser {
  final String username;
  final String imageUrl;

  const ChatUser({this.username, this.imageUrl});
}
class ChatMessage {
  ChatMessage(
      {this.sender,
        this.text,
        this.animationController,
      });
  final ChatUser sender;
  final String text;
  final AnimationController animationController;

}
class ChatMessageListItem extends StatelessWidget {
  ChatMessageListItem(this.message);

  final ChatMessage message;

  Widget build(BuildContext context) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: message.animationController,
          curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Container(
              margin: const EdgeInsets.only(right: 16.0),
              //child: new GoogleUserCircleAvatar(placeholderPhotoUrl: message.sender.imageUrl, identity: null,),
            ),
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Text(message.sender.username,
                    style: Theme.of(context).textTheme.subhead),
                new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new ChatMessageContent(message)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class ChatMessageContent extends StatelessWidget {
  ChatMessageContent(this.message);

  final ChatMessage message;

  Widget build(BuildContext context) {

      return new Text(message.text);
  }
}


class Team {
  final String name;
  final String id;
  //final List<User> members;

  const Team(this.name, this.id); //  this.members);
}
