import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motoboybug_app/Model/Pedido.dart';

import 'NotificacaoDialog.dart';
class PushNotificacao{
  final FirebaseMessaging firebaseMessaging=FirebaseMessaging();
  Future initialize(context) async {



      firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
          MostrarInformacaodaNotificacao(context,message);

        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");


        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");

          MostrarInformacaodaNotificacao(context,message);



        },
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