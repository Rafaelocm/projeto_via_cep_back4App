import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projeto_via_cep/model/cep_model.dart';

class Back4AppRepository{

  Future<void> createCep(ViaCepModel viaCepModel) async {
    var dio = Dio(); 
    dio.options.headers["X-Parse-Application-Id"] = dotenv.get("BACK4APPAPLICATIONID");
    dio.options.headers["X-Parse-REST-API-Key"] = dotenv.get("BACK4APPRESTAPIKEY");
    dio.options.headers["Content-Type"] = dotenv.get("BACK4APPCONTENTAPI");
    await dio.post("https://parseapi.back4app.com/classes/CepModel", data: viaCepModel.toJson());
  }

  Future<ViaCepModelList> readingCep() async{
    var dio = Dio();
    dio.options.headers["X-Parse-Application-Id"] = dotenv.get("BACK4APPAPLICATIONID");
    dio.options.headers["X-Parse-REST-API-Key"] = dotenv.get("BACK4APPRESTAPIKEY");
    dio.options.headers["Content-Type"] = dotenv.get("BACK4APPCONTENTAPI");
    var response = await dio.get("https://parseapi.back4app.com/classes/CepModel"); 
    return ViaCepModelList.fromJson(response.data); 
  }


  Future<void> deleteCep(String cep) async{
    var dio = Dio();
    dio.options.headers["X-Parse-Application-Id"] = dotenv.get("BACK4APPAPLICATIONID");
    dio.options.headers["X-Parse-REST-API-Key"] = dotenv.get("BACK4APPRESTAPIKEY");
    dio.options.headers["Content-Type"] = dotenv.get("BACK4APPCONTENTAPI");
    await dio.delete("https://parseapi.back4app.com/classes/CepModel/$cep"); 
  }
}