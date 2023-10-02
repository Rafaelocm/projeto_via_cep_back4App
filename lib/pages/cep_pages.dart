import 'package:flutter/material.dart';
import 'package:projeto_via_cep/model/cep_model.dart';
import 'package:projeto_via_cep/repositories/back4_app_repository.dart';
import 'package:projeto_via_cep/repositories/via_cep_repository.dart';
import 'package:projeto_via_cep/widgets/text_button.dart';
import 'package:projeto_via_cep/widgets/text_field.dart';

class CepPages extends StatefulWidget {
  const CepPages({super.key});

  @override
  State<CepPages> createState() => _CepPagesState();
}

class _CepPagesState extends State<CepPages> {
  var viaCepRepository = ViaCepRepository(); 
  var viaCepModel = ViaCepModel();
  var cepList = ViaCepModelList([]);
  var cepController = TextEditingController(text: "");
  bool carregando = false; 
  Back4AppRepository back4appRepository = Back4AppRepository(); 
 
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obterDados(); 
  }

  obterDados() async{
    setState(() {
      carregando = true; 
    });
    cepList = await back4appRepository.readingCep();
    setState(() {
      carregando = false; 
    });
  }

 void limparTexto(){
  viaCepModel.logradouro = "logradouro";
  viaCepModel.bairro = "bairro";
  viaCepModel.localidade = "localidade";
  viaCepModel.uf = "estado";
 }

  bool verificarCep(ViaCepModel viaCepModel) {
  for (var cep in cepList.ceps) {
    if (cep.cep == viaCepModel.cep) {
      return true; 
    }
  }
    return false; 
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold
      (appBar: AppBar(title: const Text("Consultar Cep")), 
      floatingActionButton: FloatingActionButton(onPressed: () {
        showModalBottomSheet(context: context, builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              children: [
                TextFieldWidget(
                  label: "CEP", 
                  controller: cepController, 
                  keyboardType: TextInputType.number,
                  onChanged: (value) async {
                     var cep = value.toString().replaceAll(RegExp(r'[^0-9]'), ""); 
                    if(cep.length == 8){
                      viaCepModel = await viaCepRepository.obterCep(cepController.text); 
                      if(viaCepModel.logradouro == null || viaCepModel.localidade == null || 
                      viaCepModel.bairro == null || viaCepModel.uf == null){
                        setState(() {
                          limparTexto(); 
                        });
                      }
                     } 
                    }
                  ), 
                  TextFieldWidget(label: viaCepModel.logradouro ?? "logradouro", enabled: true), 
                  TextFieldWidget(label: viaCepModel.bairro ?? "bairro", enabled: true), 
                  TextFieldWidget(label: viaCepModel.localidade ?? "localidade", enabled: true),
                  TextFieldWidget(label: viaCepModel.uf ?? "estado", enabled: true), 
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                     TextButtonWidget(onPressed: () async {
                      cepController.clear(); 
                        limparTexto();
                      Navigator.pop(context); 
                    }, title: "Fechar", colorText: Colors.red, fontWeight: FontWeight.w600, tamanhoText: 18),
                    TextButtonWidget(onPressed: () async {
                      if(verificarCep(viaCepModel)){
                        cepController.clear(); 
                        limparTexto(); 
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cep já cadastrado", style: TextStyle(color: Colors.red),)));
                        Navigator.pop(context);
                        return; 
                      } else{
                        cepController.clear();
                        limparTexto(); 
                        await back4appRepository.createCep(viaCepModel);
                        obterDados();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cadastrado com sucesso")));
                        Navigator.pop(context);
                      }
                      setState(() {}); 
                    }, title: "Cadastrar", colorText: Colors.white, fontWeight: FontWeight.w600, tamanhoText: 18, backGroundColorButton: Colors.blue)
                      ],
                    ),
                  )
              ],
            ),
          ); 
        },); 
      }, child:const Icon(Icons.search)),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: ListView.builder(
          itemCount: cepList.ceps.length,
          itemBuilder: (_, int index) {
           var cep = cepList.ceps[index];
          return Dismissible(key: Key(cep.objectId!), onDismissed: (direction) async {
            await back4appRepository.deleteCep(cep.objectId!);
            cepList.ceps.removeAt(index); 
          }, background: Container(color: Colors.red), 
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              title: Text("Cep: ${cep.cep}"),
              isThreeLine: true,
              subtitle: Text("End: ${cep.logradouro} - ${cep.localidade} ${cep.uf}"),
              trailing: const Icon(
                Icons.border_color
              ),
              onTap: () {
                
              },
            ),
          ));
        }),
      )));
  }
}