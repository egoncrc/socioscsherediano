import 'package:flutter/material.dart';

class InputDecorations{
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon
  }){
    return  InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  enabledBorder: const OutlineInputBorder(
                    //borderRadius: BorderRadius.circular(30),
                    
                    borderSide: BorderSide(
                      color: Colors.white
                    ),                    
                  ),
                  focusedBorder: OutlineInputBorder(
                    //borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 2
                    )
                  ),
                  hintText: hintText,
                  // labelText: labelText,
                  labelStyle: const TextStyle(
                    color: Colors.grey
                  ),
                  prefix: prefixIcon != null
                  ? Icon(prefixIcon, color: Colors.grey.shade700,)
                  : null
                );
  }
}