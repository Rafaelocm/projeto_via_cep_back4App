import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final VoidCallback onPressed; 
  final String title; 
  final Color? colorText, backGroundColorButton; 
  final double? tamanhoText, tamanhoButton; 
  final FontWeight? fontWeight; 
  const TextButtonWidget({super.key, required this.onPressed, required this.title, this.colorText, this.tamanhoText, this.fontWeight, this.backGroundColorButton, this.tamanhoButton});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: tamanhoButton,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(backGroundColorButton),
          ),
          child: Text(title, style: TextStyle(color: colorText, fontSize: tamanhoText, fontWeight: fontWeight),),
        ),
      ),
    );
  }
}