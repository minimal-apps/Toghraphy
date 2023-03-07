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

  @override
  Future<Question> getRandomQuestion(String filter) async {
    // return questionsCollection.snapshots().map((snapshot) =>
    //     snapshot.docs.map((question) => question.data()).toList());

    CollectionReference myRef = questionsCollection;
    AggregateQuery aggregateQuery =
        await questionsCollection.where("lesson", isEqualTo: filter).count();
    int count = (await aggregateQuery.get()).count;
    if(count > 0){
    int _randomIndex = Random().nextInt(count);
    print(_randomIndex);

    final Question question =
        (await questionsCollection.where("lesson", isEqualTo: filter).get())
            .docs[_randomIndex].data() ;
    return question;
    }


    return Question(questionContent: "", answer: "", lesson: "", subject: "",choices: [],correctChoiceIndex: 0);

    // return await questionsCollection
    //     .where('lesson', isEqualTo: filter)
    //     .snapshots()
    //     .first
    //     .then((snapshot) {
    //   int randomIndex = Random().nextInt(snapshot.docs.length);
    //   final element = snapshot.docs[randomIndex].data();
    //   print(element.toString());
    //   return element;
    // });
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
