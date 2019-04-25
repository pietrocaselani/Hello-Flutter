import 'package:flutter/material.dart';
import 'package:hello/address/address_page.dart';
import 'package:hello/postal_code/postal_code_page.dart';
import 'package:hello/services/postal_code/PostalCodeService.dart';

void main() => runApp(MyApp());

class Environment {
  static final postalCodeService = PostalCodeService();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: _allRoutes,
        initialRoute: _initialRoute(),
        theme: ThemeData(
            primaryColor: Colors.blue,
            primaryColorDark: Colors.blueGrey,
            primaryColorLight: Colors.lightBlue),
        title: 'Title');
  }

  Map<String, WidgetBuilder> get _allRoutes {
    return <String, WidgetBuilder>{
      PostalCodePage.routeName: (BuildContext context) => PostalCodePage(),
      AddressPage.routeName: (BuildContext context) => AddressPage()
    };
  }

  String _initialRoute() => PostalCodePage.routeName;
}
