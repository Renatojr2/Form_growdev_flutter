import 'package:dio/dio.dart';

import '../models/cep_model.dart';

import './service.dart';

class CepRetpositoryImpl implements CepRepository {
  @override
  Future<Endereco> getCep(String cep) async {
    final response = await Dio().get('https://viacep.com.br/ws/$cep/json/');
    if (response.statusCode != 200) {
      throw Error();
    }
    return Endereco.fromJson(response.data);
  }
}
