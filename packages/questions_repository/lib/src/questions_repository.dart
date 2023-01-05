import 'package:questions_api/questions_api.dart';

class QuestionsRepository {
  const QuestionsRepository({
    required QuestionsAPI questionsApi,
  }) : _questionsApi = questionsApi;

  final QuestionsAPI _questionsApi;

  Future<Question> getRandomQuestion(String filter) =>
      _questionsApi.getRandomQuestion(filter);

  Future<void> saveQuestion(Question question) =>
      _questionsApi.saveQuestion(question);

  Future<void> deleteQuestion(Question question) =>
      _questionsApi.deleteQuestion(question);
}
