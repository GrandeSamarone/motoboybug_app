import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'Notificacao/NotificacaoDialog.dart';
import 'Notificacao/PushNotificacao.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(

        primarySwatch: Colors.blue,

      ),
      home: MyHomePage(title: 'Motoboy'),
    debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key,  this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String token;
  FirebaseMessaging firebaseMessaging=FirebaseMessaging();
  PushNotificacao pushNotificacao= PushNotificacao();
  void _incrementCounter() {

    showDialog(
        context:context,
        barrierDismissible: false,
        builder: (BuildContext context)=>NotificacaoDialog() );

  }

  @override
  Widget build(BuildContext context) {
    pushNotificacao.initialize(context);
    getToken();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                "APP MOTOBOY"
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Future getToken()async{
    token = await firebaseMessaging.getToken();
    print("Token do usuario: "+token);
  }
}
