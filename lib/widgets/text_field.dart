import 'dart:async';

import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label; 
  final TextEditingController? controller; 
  final bool? enabled; 
  const TextFieldWidget({super.key, required this.label, this.controller, this.onChanged, this.keyboardType, this.enabled});
  final ValueChanged? onChanged; 
  final TextInputType? keyboardType; 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          labelText: label, 
          enabled: enabled ?? false ? false : true, 
          border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black), 
          borderRadius: BorderRadius.circular(10)), 
          labelStyle: const TextStyle(fontSize: 18)
        ),
        keyboardType: keyboardType,
        controller: controller,
        onChanged: onChanged,
      ),
    );
  }
}