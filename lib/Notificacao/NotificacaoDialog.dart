

import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motoboybug_app/Model/Pedido.dart';


class NotificacaoDialog extends StatefulWidget{

  final Pedido detalheCorrida;

  NotificacaoDialog({this.detalheCorrida});

  static const String idScreen = "NotificacaoDialog";
  NotificacaoDialogState createState() =>NotificacaoDialogState();

}

class NotificacaoDialogState extends State<NotificacaoDialog> {

  final assetsAudioPlayer =AssetsAudioPlayer();

  bool cancelado=false;
  int quant;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assetsAudioPlayer.open(
        Audio("sons/somsino.mp3"),
        //autoStart: true,
        //showNotification: true,
        loopMode: LoopMode.single
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    assetsAudioPlayer.stop();


  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Dialog(
      shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12.0)),
      backgroundColor:Colors.transparent,
      elevation:1.0,
      child:Container(
        margin:EdgeInsets.all(5.0),
        width:double.infinity,
        decoration:BoxDecoration(
          color:Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30.0),
            Image.asset("imagens/sino.png",width:100.0,),
            SizedBox(height: 18.0,),
            Text("Pizzaria Burg",style:TextStyle(fontSize:20.0),),
            SizedBox(height: 30.0,),
            Padding(
              padding: EdgeInsets.all(18.0),
              child: Column(
                children: [

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("imagens/desticon.png",height:16.0,width: 16.0,),
                      SizedBox(width:20.0,),
                      Expanded(
                          child: Container(child: Text("Rua Borba n200",style:TextStyle(fontSize:18.0),))
                      ),


                    ],
                  ),
                  SizedBox(height: 15.0,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("imagens/iconquantpedido.png",height:16.0,width: 16.0,),
                      SizedBox(width:20.0,),
                      Expanded(
                          child: Container(child: Text("4 itens",style:TextStyle(fontSize:18.0),))
                      ),


                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
                padding: EdgeInsets.all(20.0),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 200.0,
                        height: 50.0,
                        child:ElevatedButton.icon(
                            icon: Icon(Icons.add, color: Colors.white54,size:18.0,),
                            label:Text(cancelado?"Cancelado":'Aceitar'),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),

                              primary:Colors.red[900],
                              //  onPrimary: Colors.white,
                              onSurface: Colors.grey,
                              shape: const BeveledRectangleBorder
                                (borderRadius: BorderRadius.all(Radius.circular(5))),

                              textStyle: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 20,
                                  fontFamily: "Brand Bold"
                                  ,fontWeight: FontWeight.bold
                              ),
                            ),

                            onPressed: (){

                              assetsAudioPlayer.stop();
                              Navigator.of(context).pop();


                            })
                    ),
                  ],
                ))



          ],
        ),
      ),
    );


  }


}
