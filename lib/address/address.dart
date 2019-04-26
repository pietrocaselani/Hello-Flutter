import 'package:hello/services/postal_code/postal_code_service.dart';

class Address {
  final String state, city, neighborhood, street, type;

  Address(this.state, this.city, this.neighborhood, this.street, this.type);

  Address.fromResult(AddressResult result)
      : state = result.state,
        city = result.city,
        neighborhood = result.neighborhood,
        street = result.street,
        type = result.type;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Address &&
              runtimeType == other.runtimeType &&
              state == other.state &&
              city == other.city &&
              neighborhood == other.neighborhood &&
              street == other.street &&
              type == other.type;

  @override
  int get hashCode =>
      state.hashCode ^
      city.hashCode ^
      neighborhood.hashCode ^
      street.hashCode ^
      type.hashCode;



}