import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:untitled1/login/login_page.dart';

import 'package:untitled1/main.dart' as app;
import 'package:untitled1/profile/profile.dart' as profile;
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import './mock.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });
  group('sign-in test', () {
    testWidgets('sign in, check if successful', (tester) async {
      // final firestore = FakeFirebaseFirestore();

      await tester.pumpWidget(app.MyApp());

      var textField = find.byKey(Key("signup"));
      await tester.tap(textField);
      await tester.pump();
      // final Finder fab = find.byKey(const Key('signIn'));
      // expect(fab, fab);
      expect(find.text("Sign Up"), findsOneWidget);

      // // Emulate a tap on the floating action button.
      // await tester.tap(fab);

      // // Trigger a frame.
      // await tester.pumpAndSettle();

      // // Verify the counter increments by 1.
      // expect(find.text('1'), findsOneWidget);
    });
  });
}
