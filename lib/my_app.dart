import 'package:flutter/material.dart';
import 'package:projeto_via_cep/pages/cep_pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
   @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: CepPages(),
    );
  }
}