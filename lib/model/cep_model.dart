class ViaCepModelList {
  List<ViaCepModel> ceps = [];

  ViaCepModelList(this.ceps);

  ViaCepModelList.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      ceps = <ViaCepModel>[];
      json['results'].forEach((v) {
        ceps.add(ViaCepModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = ceps.map((v) => v.toJson()).toList();
    return data;
  }
}

class ViaCepModel {
  String? objectId; 
  String? cep;
  String? logradouro;
  String? complemento;
  String? bairro;
  String? localidade;
  String? uf;

  ViaCepModel(
      {
      this.objectId,
      this.cep,
      this.logradouro,
      this.complemento,
      this.bairro,
      this.localidade,
      this.uf,
     });

    void limparTexto(){
      logradouro = "logradouro";
      bairro = "bairro";
      localidade = "localidade";
      uf = "estado";
    }

    bool verificarCampos(){
      if(logradouro == "logradouro" || bairro == "bairro" || localidade == "localidade" || uf == "estado" ||
      logradouro == null || bairro == null || localidade == null || uf == null){
        return true; 
      } else{
        return false; 
      }
    }

  ViaCepModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    cep = json['cep'];
    logradouro = json['logradouro'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId; 
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    return data;
  }

   Map<String, dynamic> toEndPoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    return data;
  }
}
