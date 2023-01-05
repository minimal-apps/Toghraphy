// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question extends Equatable {
  final String id;
  final String questionContent;
  final String answer;
  final String lesson;
  final String subject;

  Question({
    String? id,
    required this.questionContent,
    required this.answer,
    required this.lesson,
    required this.subject,
  }) : id = id ?? const Uuid().v4();

  @override
  List<Object> get props => [
        id,
        questionContent,
        answer,
        lesson,
        subject,
      ];

  Question copyWith({
    String? id,
    String? questionContent,
    String? answer,
    String? lesson,
    String? subject,
  }) {
    return Question(
      id: id ?? this.id,
      questionContent: questionContent ?? this.questionContent,
      answer: answer ?? this.answer,
      lesson: lesson ?? this.lesson,
      subject: subject ?? this.subject,
    );
  }

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  @override
  bool get stringify => true;
}
