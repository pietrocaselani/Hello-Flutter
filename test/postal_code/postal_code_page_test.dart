import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello/postal_code/postal_code_page.dart';

void main() {
  Widget buildTestableWidget(Widget widget) {
    return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
  }

  testWidgets('PostalCodePage has an input and button', (WidgetTester tester) async {
    var postalCodePage = PostalCodePage();
    await tester.pumpWidget(buildTestableWidget(postalCodePage));

    print(tester.allWidgets);

    final appBarTitle = find.text('Busca CEP');
    expect(appBarTitle, findsOneWidget);

    final placeholder = find.text('Digite aqui o CEP');
    expect(placeholder, findsOneWidget);

    final searchButton = find.text('Buscar');
    expect(searchButton, findsOneWidget);
  });
}
