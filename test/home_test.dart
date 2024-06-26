import 'package:estilizacao_componentes/components/box_card.dart';
import 'package:estilizacao_componentes/data/bank_http.mocks.dart';
import 'package:estilizacao_componentes/data/bank_inherited.dart';
import 'package:estilizacao_componentes/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  final MockBankHttp httpMock = MockBankHttp();
  testWidgets('My widget has a test "Spent"', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: BankInherited(child: Home(api: MockBankHttp().dolarToReal()))));
    final spentFinder = find.text('Spent');
    expect(spentFinder, findsOneWidget);
  });
  testWidgets('finds a LinearProgressIndicator', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: BankInherited(child: Home(api: MockBankHttp().dolarToReal()))));
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });
  testWidgets('finds a AccontStatus', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: BankInherited(child: Home(api: MockBankHttp().dolarToReal()))));
    expect(find.byKey(const Key('testKey')), findsOneWidget);
  });
  testWidgets('finds five BoxCards', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: BankInherited(child: Home(api: MockBankHttp().dolarToReal()))));
    expect(find.byWidgetPredicate((widget) {
      if (widget is BoxCard) {
        return true;
      } else {
        return false;
      }
    }), findsNWidgets(5));
  });
  testWidgets('When tap Deposit should upload earned in 10', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: BankInherited(child: Home(api: MockBankHttp().dolarToReal()))));
    await tester.tap(find.text('Deposit'));
    await tester.tap(find.text('Earned'));
    await tester
        .pumpAndSettle(); // espera todos os microServiços que alteram a tela acabarem
    expect(find.text('\$10.0'), findsOneWidget);
  });
  testWidgets('testing mockHttp dolarToReal', (tester) async {
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('5'));
    await tester.pumpWidget(MaterialApp(
      home: BankInherited(
        child: Home(api: httpMock.dolarToReal()),
      ),
    ));
    verify(httpMock.dolarToReal()).called(1);
  });
}
