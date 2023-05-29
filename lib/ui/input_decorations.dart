import 'package:flutter/material.dart';

class InputDecorations{

   

  
  static InputDecoration authInputDecoration({

    required String label,
    required String hintText,
    IconData? icono,
  }){

    return InputDecoration(
              enabledBorder:const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.deepPurple
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide:  BorderSide(
                  color: Colors.deepPurple,
                  width: 2,  
                )
              ),
              hintText: hintText,
              labelText: label,
              labelStyle: const  TextStyle(
                color: Colors.grey
              ),
              prefixIcon: icono != null ?
              Icon(icono,color: Colors.deepPurple,): null
            );
  }

}