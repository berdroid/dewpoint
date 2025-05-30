// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dewpoint/cubit/dewpoint_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dewpoint/main.dart';

void main() {
  testWidgets('Lock/free toggle', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      BlocProvider<DewPointCubit>(
        create: (_) => DewPointCubit(const DewPointState()),
        child: const MyApp(),
      ),
    );

    // Tap the lock/free switch
    await tester.tap(find.byType(Switch));
    await tester.pump();

    expect(find.byType(Switch), findsOneWidget);
  });
}
