import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:questions_api/questions_api.dart';
import 'package:questions_repository/questions_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'qna_event.dart';
part 'qna_state.dart';

class QnaBloc extends Bloc<QnaEvent, QnaState> {
  QnaBloc({required QuestionsRepository questionsRepository})
      : _questionsRepository = questionsRepository,
        super(const QnaState()) {
    on<QnaQuestionRequested>(_onQnaQuestionRequested);
    on<QnaFilterChanged>(_onQnaFilterChanged);
    on<QnaAnswerChanged>(_onQnaAnswerChanged);
    on<QnaScoreChanged>(_onQnaScoreChanged);
    on<QnaAnswerSubmitted>(_onQnaAnswerSubmitted);
    on<QnaAnswerRequested>(_onQnaAnswerRequested);
    on<QnaQuestionRegistered>(_onQnaQuestionRegistered);
    on<QnaNavigationTriggered>(_onQnaNavigationTriggered);
  }

  final QuestionsRepository _questionsRepository;

  Future<void> _onQnaQuestionRequested(
    QnaQuestionRequested event,
    Emitter<QnaState> emit,
  ) async {
    final question =
        await _questionsRepository.getRandomQuestion(state.filterLesson);
    emit(state.copyWith(question: question));
    // emit(state.copyWith(
    //     question: Question(
    //         questionContent: "text",
    //         answer: "text",
    //         lesson: "text",
    //         subject: "text",
    //         choices: ["choice 1", "choice 2", "choice 3"],
    //         correctChoiceIndex: 0)));
  }

  Future<void> _onQnaFilterChanged(
    QnaFilterChanged event,
    Emitter<QnaState> emit,
  ) async {
    emit(state.copyWith(
        filterLesson: event.filterLesson, filterSubject: event.filterSubject,),);
    final question =
        await _questionsRepository.getRandomQuestion(state.filterLesson);
    emit(state.copyWith(question: question));
  }

  Future<void> _onQnaAnswerChanged(
    QnaAnswerChanged event,
    Emitter<QnaState> emit,
  ) async {
    emit(state.copyWith(userAnswer: event.text));
  }

  Future<void> _onQnaScoreChanged(
    QnaScoreChanged event,
    Emitter<QnaState> emit,
  ) async {
    if (event.score == 0) {
      final prefs = await SharedPreferences.getInstance();
      prefs.getInt('score') ?? prefs.setInt('score', 0);
      emit(state.copyWith(score: prefs.getInt('score')));
    } else {
      emit(state.copyWith(score: event.score));
    }
  }

  Future<void> _onQnaAnswerSubmitted(
    QnaAnswerSubmitted event,
    Emitter<QnaState> emit,
  ) async {
    // final prefs = await SharedPreferences.getInstance();
    // prefs.getInt('score') ?? prefs.setInt('score', 0);
    // final score = prefs.getInt('score');

    // await prefs.setInt("score", score! + 10);
  }

  Future<void> _onQnaAnswerRequested(
    QnaAnswerRequested event,
    Emitter<QnaState> emit,
  ) async {}

  Future<void> _onQnaQuestionRegistered(
    QnaQuestionRegistered event,
    Emitter<QnaState> emit,
  ) async {}

  void _onQnaNavigationTriggered(
    QnaNavigationTriggered event,
    Emitter<QnaState> emit,
  ) {
    emit(state.copyWith(status: event.status));
  }
}
