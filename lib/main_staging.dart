import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_questions_api/firestore_questions_api.dart';
import 'package:questions_repository/questions_repository.dart';
import 'package:toghraphy/app/app.dart';
import 'package:toghraphy/bootstrap.dart';

void main() {
  final firestore = FirebaseFirestore.instance;
  final firestoreQuestionsApi = FirestoreQuestionsAPI(firestore: firestore);
  final questionsRepository =
      QuestionsRepository(questionsApi: firestoreQuestionsApi);
  bootstrap(() => App(
        questionsRepository: questionsRepository,
      ),);
}
