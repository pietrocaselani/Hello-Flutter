import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello/address/address_page.dart';
import 'package:hello/postal_code/postal_code.dart';

class PostalCodePage extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Busca CEP"),
        ),
        body: Padding(
          child: _PostalCodeScreen(),
          padding: EdgeInsets.only(left: 10, top: 10, right: 10),
        ));
  }
}

class _PostalCodeScreen extends StatelessWidget {
  final postalCodeInputController = _PostalCodeInputController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _PostalCodeInputWidget(controller: postalCodeInputController),
        _searchPostalCodeButton(context)
      ],
    );
  }

  Widget _searchPostalCodeButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: RaisedButton(
        color: Colors.grey,
        onPressed: () => {routeToAddressPage(context)},
        child: Text("Buscar"),
      ),
    );
  }

  routeToAddressPage(BuildContext context) {
    final postalCode = postalCodeInputController.postalCode();

    Navigator.pushNamed(context, AddressPage.routeName,
        arguments: PostalCode(postalCode));
  }
}

class _PostalCodeInputWidget extends StatefulWidget {
  final _PostalCodeInputController controller;

  const _PostalCodeInputWidget({Key key, this.controller}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostalCodeInputWidgetState();
}

class _PostalCodeInputWidgetState extends State<_PostalCodeInputWidget> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _postalCodeTextField();
  }

  Widget _postalCodeTextField() {
    return TextField(
      controller: widget.controller.inputController,
      maxLength: 8,
      maxLengthEnforced: true,
      keyboardType: TextInputType.number,
      autofocus: true,
      autocorrect: false,
      decoration: InputDecoration(hintText: 'Digite aqui o CEP'),
    );
  }
}

class _PostalCodeInputController {
  final inputController = TextEditingController();

  dispose() => inputController.dispose();

  String postalCode() => inputController.text;
}
