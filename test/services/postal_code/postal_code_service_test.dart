import 'package:test/test.dart';
import 'package:hello/services/postal_code/postal_code_service.dart';

main() {
  test('We can create AddressResult from a JSON', () {
    final json = {
      'resultado': '1',
      'resultado_txt': 'sucesso - cep completo',
      'uf': 'SP',
      'cidade': 'São Paulo',
      'bairro': 'Consolação',
      'tipo_logradouro': 'Rua',
      'logradouro': 'Frei Caneca'
    };

    final result = AddressResult.fromJSON(json);
    final expectedResult = AddressResult(
        '1', 'SP', 'São Paulo', 'Consolação', 'Frei Caneca', 'Rua');

    expect(result, expectedResult);
  });
}
