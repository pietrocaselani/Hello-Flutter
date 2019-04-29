import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello/address/address_page.dart';
import 'package:hello/postal_code/postal_code_page.dart';

// See -> https://github.com/flutter/flutter/blob/master/packages/flutter/test/widgets/navigator_test.dart
typedef OnObservation = void Function(
    Route<dynamic> route, Route<dynamic> previousRoute);

class NavigatorObserverMock extends NavigatorObserver {
  OnObservation onPushed;

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (onPushed != null) {
      onPushed(route, previousRoute);
    }
  }
}

void main() {
  Map<String, WidgetBuilder> allRoutes() {
    return <String, WidgetBuilder>{
      PostalCodePage.routeName: (BuildContext context) => PostalCodePage(),
      AddressPage.routeName: (BuildContext context) => AddressPage()
    };
  }

  Widget buildTestableWidget(Widget widget) {
    return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
  }

  Widget buildTestableWidgetForNavigation(
      Widget widget, NavigatorObserver observer) {
    return MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
            initialRoute: PostalCodePage.routeName,
            routes: allRoutes(),
            navigatorObservers: [observer]));
  }

  testWidgets('PostalCodePage has an input and button',
      (WidgetTester tester) async {
    final postalCodePage = PostalCodePage();
    await tester.pumpWidget(buildTestableWidget(postalCodePage));

    final appBarTitle = find.text('Busca CEP');
    expect(appBarTitle, findsOneWidget);

    final placeholder = find.text('Digite aqui o CEP');
    expect(placeholder, findsOneWidget);

    final searchButton = find.text('Buscar');
    expect(searchButton, findsOneWidget);
  });

  testWidgets('PostalCodePage input accepts max 8 chars',
      (WidgetTester tester) async {
    final postalCodePage = PostalCodePage();
    await tester.pumpWidget(buildTestableWidget(postalCodePage));

    final textfield = find.byType(TextField);
    expect(textfield, findsOneWidget);
    await tester.enterText(textfield, '123456789');

    final invalidWidget = find.text('123456789');
    expect(invalidWidget, findsNothing);

    final filledTextfield = find.text('12345678');
    expect(filledTextfield, findsOneWidget);
  });

  testWidgets(
      'PostalCodePage button is disable when there is less than 8 chars',
      (WidgetTester tester) async {
    //TODO implement
  });

  testWidgets('PostalCodePage when button is clicked go to address page',
      (WidgetTester tester) async {
    var isPushed = false;

    final observer = NavigatorObserverMock()
      ..onPushed = (Route<dynamic> route, Route<dynamic> previousRoute) {
        isPushed = true;
        expect(route.settings.name == PostalCodePage.routeName, isTrue);
        expect(previousRoute, isNull);
      };

    final postalCodePage = PostalCodePage();
    final widget = buildTestableWidgetForNavigation(postalCodePage, observer);
    await tester.pumpWidget(widget);

    expect(isPushed, isTrue);

    final textfield = find.byType(TextField);
    expect(textfield, findsOneWidget);
    await tester.enterText(textfield, '12345678');

    isPushed = false;
    observer.onPushed = (Route<dynamic> route, Route<dynamic> previousRoute) {
      isPushed = true;
      expect(route.settings.name, AddressPage.routeName);
      expect(previousRoute.settings.name, PostalCodePage.routeName);
    };

    await tester.tap(find.byType(RaisedButton));
    expect(isPushed, isTrue);
  });
}
