import 'package:rxdart/rxdart.dart';
import 'package:dio/dio.dart';

class AddressResult {
  final String result, state, city, neighborhood, street, type;

  AddressResult(this.result, this.state, this.city, this.neighborhood,
      this.street, this.type);

  factory AddressResult.fromJSON(Map<String, dynamic> json) {
    return AddressResult(json['resultado'], json['uf'], json['cidade'],
        json['bairro'], json['logradouro'], json['tipo_logradouro']);
  }
}

class PostalCodeService {
  Observable<AddressResult> fetchAddress(String postalCode) {
    final stream = fetchAddressAsStream(postalCode);
    return Observable(stream);
  }

  Stream<AddressResult> fetchAddressAsStream(String postalCode) {
    final url =
        'http://cep.republicavirtual.com.br/web_cep.php?cep=$postalCode&formato=jsonp';
    final response = Dio().get<Map>(url);
    return response
        .asStream()
        .map((response) => AddressResult.fromJSON(response.data));
  }
}
