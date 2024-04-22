import 'package:estilizacao_componentes/components/box_card.dart';
import 'package:estilizacao_componentes/data/bank_inherited.dart';
import 'package:estilizacao_componentes/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('My widget has a test "Spent"', (tester) async {
    await tester
        .pumpWidget(MaterialApp(home: BankInherited(child: const Home())));
    final spentFinder = find.text('Spent');
    expect(spentFinder, findsOneWidget);
  });
  testWidgets('finds a LinearProgressIndicator', (tester) async {
    await tester
        .pumpWidget(MaterialApp(home: BankInherited(child: const Home())));
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });
  testWidgets('finds a AccontStatus', (tester) async {
    await tester
        .pumpWidget(MaterialApp(home: BankInherited(child: const Home())));
    expect(find.byKey(const Key('testKey')), findsOneWidget);
  });
  testWidgets('finds five BoxCards', (tester) async {
    await tester
        .pumpWidget(MaterialApp(home: BankInherited(child: const Home())));
    expect(find.byWidgetPredicate((widget) {
      if (widget is BoxCard) {
        return true;
      } else {
        return false;
      }
    }), findsNWidgets(5));
  });
  testWidgets('When tap Deposit should upload earned in 10', (tester) async {
    await tester
        .pumpWidget(MaterialApp(home: BankInherited(child: const Home())));
    await tester.tap(find.text('Deposit'));
    await tester.tap(find.text('Earned'));
    await tester
        .pumpAndSettle(); // espera todos os microServiços que alteram a tela acabarem
    expect(find.text('\$10.0'), findsOneWidget);
  });
}
