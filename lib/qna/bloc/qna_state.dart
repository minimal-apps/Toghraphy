// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'qna_bloc.dart';

enum QnaPageStatus {
  questionPage,
  answerPage,
}

class QnaState extends Equatable {
  final List<Question>? questions;
  final Question? question;
  final int? score;
  final String filter;
  final String? userAnswer;
  final QnaPageStatus? status;

  const QnaState({
    this.question,
    this.filter =
        'التحولات الكبرى للعالم الرأسمالي وانعكاساتها خلال القرن 19م ومطلع القرن 20م',
    this.score,
    this.questions,
    this.userAnswer,
    this.status = QnaPageStatus.questionPage,
  });

  @override
  List<Object?> get props =>
      [question, score, questions, status, filter, userAnswer];

  QnaState copyWith({
    List<Question>? questions,
    Question? question,
    int? score,
    String? filter,
    String? userAnswer,
    QnaPageStatus? status,
  }) {
    return QnaState(
      questions: questions ?? this.questions,
      question: question ?? this.question,
      score: score ?? this.score,
      filter: filter ?? this.filter,
      userAnswer: userAnswer ?? this.userAnswer,
      status: status ?? this.status,
    );
  }
}
