import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:questions_api/questions_api.dart';

class FirestoreQuestionsAPI implements QuestionsAPI {
  FirestoreQuestionsAPI({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  late final questionsCollection =
      _firestore.collection("questions").withConverter<Question>(
            fromFirestore: (snapshot, _) => Question.fromJson(snapshot.data()!),
            toFirestore: (question, _) => question.toJson(),
          );

  @override
  Future<void> saveQuestion(Question question) async {
    final check =
        await questionsCollection.where('id', isEqualTo: question.id).get();
    if (check.docs.isEmpty) {
      await questionsCollection.add(question);
    } else {
      final currentQuestionId = check.docs[0].reference.id;
      await questionsCollection
          .doc(currentQuestionId)
          .update(question.toJson());
    }
  }

  String getRandomGeneratedId() {
    const int AUTO_ID_LENGTH = 20;
    const String AUTO_ID_ALPHABET =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

    const int maxRandom = AUTO_ID_ALPHABET.length;
    final Random randomGen = Random();

    String id = '';
    for (int i = 0; i < AUTO_ID_LENGTH; i++) {
      id = id + AUTO_ID_ALPHABET[randomGen.nextInt(maxRandom)];
    }
    return id;
  }

  @override
  Future<Question> getRandomQuestion(String filter) async {
    // return questionsCollection.snapshots().map((snapshot) =>
    //     snapshot.docs.map((question) => question.data()).toList());

    CollectionReference myRef = questionsCollection;
    String _randomIndex = getRandomGeneratedId();
    print(_randomIndex);
    // QuerySnapshot querySnapshot = await _firestore
    //     .collection("questions")
    //     .where('id', isGreaterThanOrEqualTo: _randomIndex).limit(1)
    //     .get();

    // final question = querySnapshot.docs[0].data().toString();
    // print("hello");
    // print(question);
    // final question1 = querySnapshot.docs[0].data() as Question;

    // return question1;

    return await questionsCollection
        .where('lesson')
        .snapshots()
        .first
        .then((snapshot) {
      int randomIndex = Random().nextInt(snapshot.docs.length);
      final element = snapshot.docs[randomIndex].data();
      print(element.toString());
      return element;
    });
  }

  @override
  Future<void> deleteQuestion(Question question) async {
    final check =
        await questionsCollection.where('id', isEqualTo: question.id).get();
    if (check.docs.isEmpty) {
      throw QuestionNotFoundException;
    } else {
      final currentQuestionId = check.docs[0].reference.id;
      await questionsCollection.doc(currentQuestionId).delete();
    }
  }
}
