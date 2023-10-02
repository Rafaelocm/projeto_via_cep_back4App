import 'package:dio/dio.dart';
import 'package:projeto_via_cep/model/cep_model.dart';

class ViaCepRepository{


  Future<ViaCepModel> obterCep(String cep)async{
    var dio = Dio();
    var response = await dio.get("https://viacep.com.br/ws/$cep/json/");
    print(response.data);
    return ViaCepModel.fromJson(response.data);
  }

}