import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

//void main() {  runApp(new MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Firebase Auth Demo',
      home: new MyHomePage(title: 'Firebase Auth Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String> _message = new Future<String>.value('');

  Future<String> _testSignInWithGoogle() async {
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

    return 'signInWithGoogle succeeded: $user';
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new MaterialButton(
              child: const Text('Test signInAnonymously'),
              onPressed: signOut),
          new MaterialButton(
            color: Colors.white,
              splashColor: Colors.red,
              child: const Text('Test signInWithGoogle'),
              onPressed: () {
                setState(() {
                  _message = _testSignInWithGoogle();
                });
              }),
          new FutureBuilder<String>(
              future: _message,
              builder: (_, AsyncSnapshot<String> snapshot) {
                return new Text(snapshot.data ?? '',
                    style: const TextStyle(
                        color: const Color.fromARGB(255, 0, 155, 0)));
              }),
        ],
      ),
    );
  }

  void signOut() async {
      await _googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      if(_auth.currentUser() != null)
        print('Fucked Outta here!: ');
      if(_googleSignIn.currentUser == null)
        print('Fucked outta everywhere');
      if(_auth.currentUser() == Future.value(null))
        print('OAOAOA');
  }
}