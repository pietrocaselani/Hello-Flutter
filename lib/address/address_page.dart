import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello/main.dart';
import 'package:hello/postal_code/postal_code.dart';
import 'package:hello/services/postal_code/PostalCodeService.dart';
import 'package:rxdart/rxdart.dart';

class AddressPage extends StatelessWidget {
  static const routeName = '/address';

  final _interactor = AddressInteractor(Environment.postalCodeService);

  @override
  Widget build(BuildContext context) {
    final PostalCode postalCode = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text("Endereço"),
        ),
        body: Padding(
          child: _AddressScreen(
              postalCode: postalCode.postalCode, interactor: _interactor),
          padding: EdgeInsets.only(left: 10, top: 10, right: 10),
        ));
  }
}

class _AddressScreen extends StatefulWidget {
  final String postalCode;
  final AddressInteractor interactor;

  const _AddressScreen({Key key, this.postalCode, this.interactor})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<_AddressScreen> {
  Address address;
  bool loading = true;
  String errorMessage;

  @override
  void initState() {
    super.initState();

    widget.interactor.fetchAddress(widget.postalCode).listen(
        (addressParam) => setState(() {
              this.loading = false;
              this.address = addressParam;
            }),
        onError: (error) => setState(() {
              this.loading = false;
              this.errorMessage = error.toString();
            }));
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return _loadingWidget();

    if (errorMessage != null) return _errorWidget();

    if (address != null) return _addressWidget();

    return Text('WTF: What a terrible failure!');
  }

  Widget _loadingWidget() {
    final message = 'Buscando endereço para CEP ${widget.postalCode}';
    return Center(child: Text(message));
  }

  Widget _errorWidget() {
    return Center(child: Text(errorMessage));
  }

  Widget _addressWidget() {
    return Center(child: Text(address.street));
  }
}

class Address {
  final String state, city, neighborhood, street, type;

  Address(this.state, this.city, this.neighborhood, this.street, this.type);
}

class AddressInteractor {
  final PostalCodeService service;

  AddressInteractor(this.service);

  Observable<Address> fetchAddress(String postalCode) {
    return service.fetchAddress(postalCode).map((result) => Address(
        result.state,
        result.city,
        result.neighborhood,
        result.street,
        result.type));
  }
}
