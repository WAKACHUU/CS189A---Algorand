import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:algo_learn/login/login_page.dart';

import 'package:algo_learn/main.dart' as app;
import 'package:algo_learn/profile/profile.dart' as profile;
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import './mock.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });
  group('sign-in test', () {
    testWidgets('press sign in, check if successful jump to sign in page',
        (tester) async {
      // final firestore = FakeFirebaseFirestore();

      await tester.pumpWidget(app.MyApp());

      var textField = find.byKey(Key("signup"));
      await tester.tap(textField);
      await tester.pumpAndSettle();

      expect(find.text("Sign Up"), findsOneWidget);
    });

    testWidgets('log in with wrong password, see if successful',
        (tester) async {
      // final user =
      //     MockUser(isAnonymous: false, uid: '123', email: 'abc@ucsb.edu');

      // final FirebaseAuth auth = MockFirebaseAuth(mockUser: user);

      await tester.pumpWidget(app.MyApp());

      await tester.enterText(
          find.byKey(Key("email-field")), "yijiecai@ucsb.edu");
      await tester.enterText(find.byKey(Key("password-field")), "123456");

      await tester.tap(find.text("Login"));
      await tester.pump();

      expect(find.text("Login"), findsOneWidget);
    });
  });
}
