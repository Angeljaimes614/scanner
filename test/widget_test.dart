import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget); // Debería encontrar exactamente un widget con texto "0"
    expect(find.text('1'), findsNothing); // No debería encontrar ningún widget con texto "1"

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump(); // Rebuild the widget after the state has changed.

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing); // Ahora no debería encontrar ningún widget con texto "0"
    expect(find.text('1'), findsOneWidget); // Debería encontrar exactamente un widget con texto "1"
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo'),
        ),
        body: const Center(
          child: Text('You have pushed the button this many times: 0'), // Asegúrate de que el texto inicial sea "0"
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
