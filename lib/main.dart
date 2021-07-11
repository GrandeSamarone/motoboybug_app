import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'Model/Pedido.dart';
import 'Notificacao/NotificacaoDialog.dart';
import 'Notificacao/PushNotificacao.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  RawDatagramSocket.bind(InternetAddress.anyIPv4, 0)
      .then((RawDatagramSocket socket) {
    Map<String, dynamic> map = Map();
    map['title'] = "Title Teste";
    map['subtitle'] = "Subtitle teste";
    socket.send(Uint8List.fromList(jsonEncode(map).codeUnits),
        InternetAddress("127.0.0.1"), 3306);
  });
}

AndroidNotificationChannel channel;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

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
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String token;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  PushNotificacao pushNotificacao = PushNotificacao();

  @override
  void initState() {
    super.initState();
    MethodChannel serviceChannel = MethodChannel("motoboy");
    serviceChannel.invokeMethod("startService");
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
            TextButton(
                onPressed: () {
                  onActionSelected();
                },
                child: Text("Assinar Topico motoboyteste"))
          ],
        ),
      ),
    );
  }

  Future getToken() async {
    token = await firebaseMessaging.getToken();
    print("Token user: " + token);
  }

  Future<void> onActionSelected() async {
    await FirebaseMessaging.instance.subscribeToTopic('motoboyteste');
    print("assinou o topico");
  }
}
