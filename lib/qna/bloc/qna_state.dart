// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'qna_bloc.dart';

enum QnaPageStatus {
  questionPage,
  answerPage,
}

class QnaState extends Equatable {
  final Stream<List<Question>?>? questions;
  final Question? question;
  final int? score;
  final String filterLesson;
  final String filterSubject;
  final String? userAnswer;
  final String? userQuestion;
  final QnaPageStatus? status;

  const QnaState({
    this.question,
    this.filterLesson =
       'التحولات الاقتصادية والمالية والاجتماعية والفكرية في العالم في القرن 19م',
    this.filterSubject = 'التاريخ',
    this.score,
    this.questions,
    this.userAnswer,
    this.userQuestion,
    this.status = QnaPageStatus.questionPage,
  });

  @override
  List<Object?> get props => [
        question,
        score,
        questions,
        status,
        filterLesson,
        filterSubject,
        userAnswer,
        userQuestion
      ];

  QnaState copyWith({
    Stream<List<Question>>? questions,
    Question? question,
    int? score,
    String? filterLesson,
    String? filterSubject,
    String? userAnswer,
    String? userQuestion,
    QnaPageStatus? status,
  }) {
    return QnaState(
      questions: questions ?? this.questions,
      question: question ?? this.question,
      score: score ?? this.score,
      filterLesson: filterLesson ?? this.filterLesson,
      filterSubject: filterSubject ?? this.filterSubject,
      userAnswer: userAnswer ?? this.userAnswer,
      userQuestion: userQuestion ?? this.userQuestion,
      status: status ?? this.status,
    );
  }
}
