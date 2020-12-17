class Endereco {
  String cep;
  String rua;
  String bairro;
  String uf;
  String cidade;
  String pais;

  Endereco({this.bairro, this.cep, this.cidade, this.rua, this.uf, this.pais});

  factory Endereco.fromJson(Map<String, dynamic> json) {
    return Endereco(
      cep: json['cep'],
      rua: json['logradouro'],
      uf: json['uf'],
      bairro: json['bairro'],
      cidade: json['localidade'],
    );
  }

  @override
  String toString() {
    return '$cep, $rua, $bairro, $cidade';
  }
}
