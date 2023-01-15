part of 'qna_bloc.dart';

@immutable
abstract class QnaEvent extends Equatable {}

class QnaQuestionRequested extends QnaEvent {
  QnaQuestionRequested();
  @override
  List<Object> get props => [];
}

class QnaFilterChanged extends QnaEvent {
  QnaFilterChanged({required this.filter});
  final String filter;
  @override
  List<Object> get props => [filter];
}

class QnaAnswerChanged extends QnaEvent {
  QnaAnswerChanged({
    required this.text,
  });
  final String text;

  @override
  List<Object> get props => [text];
}

class QnaScoreChanged extends QnaEvent {
  QnaScoreChanged({
    required this.score,
  });
  final int score;

  @override
  List<Object> get props => [score];
}

class QnaAnswerSubmitted extends QnaEvent {
  QnaAnswerSubmitted({
    required this.answer,
  });
  final String answer;

  @override
  List<Object> get props => [answer];
}

class QnaAnswerRequested extends QnaEvent {
  QnaAnswerRequested({
    required this.answer,
  });
  final String answer;

  @override
  List<Object> get props => [answer];
}

class QnaQuestionRegistered extends QnaEvent {
  QnaQuestionRegistered({
    required this.question,
  });
  final Question question;

  @override
  List<Object> get props => [question];
}

class QnaNavigationTriggered extends QnaEvent {
  QnaNavigationTriggered({
    required this.status,
  });
  final QnaPageStatus status;
  @override
  List<Object> get props => [status];
}
