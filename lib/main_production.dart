import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firestore_questions_api/firestore_questions_api.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:questions_repository/questions_repository.dart';
import 'package:toghraphy/app/app.dart';
import 'package:toghraphy/bootstrap.dart';
import 'package:toghraphy/firebase_options.dart';

void main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    print('\x1B[35m$details\x1B[0m');
    return Container();
  };
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  await MobileAds.instance.initialize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  final firestore = FirebaseFirestore.instance;
  final firestoreQuestionsApi = FirestoreQuestionsAPI(firestore: firestore);
  final questionsRepository =
      QuestionsRepository(questionsApi: firestoreQuestionsApi);

  await bootstrap(
    () => App(
      questionsRepository: questionsRepository,
    ),
  );
}
