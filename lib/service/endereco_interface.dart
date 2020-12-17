import '../models/cep_model.dart';

abstract class CepRepository {
  Future<Endereco> getCep(String cep);
}
