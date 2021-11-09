import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtils{

  static showBottomModalSheet(BuildContext context, Widget body){
    showModalBottomSheet(context: context, builder: (context){return body;});
  }

  static NetworkImage getImage(User? user){
    if(user !=null ){
      return NetworkImage(user.photoURL!);
    }else{
      return NetworkImage("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png");
    }
  }
  
}