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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressResult &&
          runtimeType == other.runtimeType &&
          result == other.result &&
          state == other.state &&
          city == other.city &&
          neighborhood == other.neighborhood &&
          street == other.street &&
          type == other.type;

  @override
  int get hashCode =>
      result.hashCode ^
      state.hashCode ^
      city.hashCode ^
      neighborhood.hashCode ^
      street.hashCode ^
      type.hashCode;
}

class PostalCodeService {
  Observable<AddressResult> fetchAddress(String postalCode) {
    final url =
        'http://cep.republicavirtual.com.br/web_cep.php?cep=$postalCode&formato=jsonp';
    final response = Dio().get<Map>(url);
    final stream = response
        .asStream()
        .map((response) => AddressResult.fromJSON(response.data));
    return Observable(stream);
  }
}
