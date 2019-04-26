import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello/address/address.dart';
import 'package:hello/address/address_interactor.dart';
import 'package:hello/main.dart';
import 'package:hello/postal_code/postal_code.dart';
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
  final _streamController = StreamController<_ViewState>();

  @override
  void initState() {
    super.initState();

    final stream = widget.interactor
        .fetchAddress(widget.postalCode)
        .map((address) => _ViewState.address(address))
        .onErrorResume((error) => Observable.just(_ViewState.error(error)));

    _streamController.addStream(stream, cancelOnError: false);
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<_ViewState>(
            initialData: _ViewState.loading(widget.postalCode),
            stream: _streamController.stream,
            builder: (context, snapshot) => snapshot.data.build(context)));
  }
}

abstract class _ViewState {
  static _ViewState address(Address address) {
    return _AddressViewState(address);
  }

  static _ViewState error(dynamic error) {
    return _ErrorViewState(error);
  }

  static _ViewState loading(String postalCode) {
    return _LoadingViewState(postalCode);
  }

  Widget build(BuildContext context);
}

class _AddressViewState extends _ViewState {
  final Address _address;

  _AddressViewState(this._address);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(_address.street));
  }
}

class _ErrorViewState extends _ViewState {
  final dynamic _error;

  _ErrorViewState(this._error);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(_error.toString()));
  }
}

class _LoadingViewState extends _ViewState {
  final String _postalCode;

  _LoadingViewState(this._postalCode);

  @override
  Widget build(BuildContext context) {
    final message = 'Buscando endereço para CEP $_postalCode';
    return Center(child: Text(message));
  }
}
