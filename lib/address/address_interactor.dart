import 'package:hello/address/address.dart';
import 'package:hello/services/postal_code/postal_code_service.dart';
import 'package:rxdart/rxdart.dart';

class AddressInteractor {
  final PostalCodeService service;

  AddressInteractor(this.service);

  Observable<Address> fetchAddress(String postalCode) {
    return service
        .fetchAddress(postalCode)
        .map((result) => Address.fromResult(result));
  }
}
