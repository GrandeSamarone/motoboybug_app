import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:motoboybug_app/Model/Pedido.dart';
import 'package:firebase_core/firebase_core.dart';

import 'NotificacaoDialog.dart';
class PushNotificacao{
  final FirebaseMessaging firebaseMessaging=FirebaseMessaging.instance;
  Pedido detalheCorrida=Pedido();



  Future<void> initialize(context) async {
    await Firebase.initializeApp();
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );
    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(initialize);

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
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

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        detalheCorrida.lat_ponto="latponto.toString()";
        detalheCorrida.long_ponto="longponto.toString()";
        detalheCorrida.end_ponto="end_ponto";
        detalheCorrida.nome_ponto="nome_ponto";
        detalheCorrida.quant_itens="4";
        detalheCorrida.telefone="telefone";
        detalheCorrida.id_doc="id_Doc";
        showDialog(
            context:context,
            barrierDismissible: false,
            builder: (BuildContext context)=>NotificacaoDialog(detalheCorrida:detalheCorrida) );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      detalheCorrida.lat_ponto="latponto.toString()";
      detalheCorrida.long_ponto="longponto.toString()";
      detalheCorrida.end_ponto="end_ponto";
      detalheCorrida.nome_ponto="nome_ponto";
      detalheCorrida.quant_itens="4";
      detalheCorrida.telefone="telefone";
      detalheCorrida.id_doc="id_Doc";
      showDialog(
          context:context,
          barrierDismissible: false,
          builder: (BuildContext context)=>NotificacaoDialog(detalheCorrida:detalheCorrida) );
    }
    );
  }

  void MostrarInformacaodaNotificacao(BuildContext context,Map<String, dynamic> Dados){
    // print("INFORMACAO DO PUSH::::${Dados["data"]}");
    // print("INFORMACAO ::::${Dados["data"]["distrito"]}");
    Timer _timer;
    double latponto=double.parse(Dados["data"]["lat_ponto"]);
    double longponto=double.parse(Dados["data"]["long_ponto"]);
    String end_ponto=Dados["data"]["end_ponto"];
    String nome_ponto=Dados["data"]["nome_ponto"];
    String Quant_itens=Dados["data"]["quant_itens"];
    String telefone=Dados["data"]["telefone"];
    String id_Doc=Dados["data"]["id_doc"];


    Pedido detalheCorrida=Pedido();
    detalheCorrida.lat_ponto=latponto.toString();
    detalheCorrida.long_ponto=longponto.toString();
    detalheCorrida.end_ponto=end_ponto;
    detalheCorrida.nome_ponto=nome_ponto;
    detalheCorrida.quant_itens=Quant_itens;
    detalheCorrida.telefone=telefone;
    detalheCorrida.id_doc=id_Doc;


    showDialog(
        context:context,
        barrierDismissible: false,
        builder: (BuildContext context)=>NotificacaoDialog(detalheCorrida:detalheCorrida) );
  }

}