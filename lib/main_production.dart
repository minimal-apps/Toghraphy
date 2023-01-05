import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_questions_api/firestore_questions_api.dart';
import 'package:flutter/material.dart';
import 'package:hg_sips/app/app.dart';
import 'package:hg_sips/bootstrap.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:questions_api/questions_api.dart';
import 'package:questions_repository/questions_repository.dart';

import 'package:hg_sips/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
