import 'package:questions_api/questions_api.dart';

abstract class QuestionsAPI  {
  const QuestionsAPI();

  Future<Question> getRandomQuestion(String filter);

  Future<void> saveQuestion(Question question);

  Future<void> deleteQuestion(Question question);
}

class QuestionNotFoundException implements Exception {}
