import 'package:hello/address/address.dart';
import 'package:hello/services/postal_code/postal_code_service.dart';
import 'package:rxdart/rxdart.dart';

class AddressInteractor {
  final PostalCodeService service;

  AddressInteractor(this.service);

  Stream<Address> featchAddressAsStream(String postalCode) {
    return service
        .fetchAddressAsStream(postalCode)
        .map((result) => Address.fromResult(result));
  }

  Observable<Address> fetchAddress(String postalCode) {
    return service
        .fetchAddress(postalCode)
        .map((result) => Address.fromResult(result));
  }
}
