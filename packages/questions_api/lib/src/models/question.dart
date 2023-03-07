// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'question.g.dart';

@JsonSerializable()
class Question extends Equatable {
  final String id;
  final String questionContent;
  final String answer;
  final String lesson;
  final String subject;
  final List<String> choices;
  final int correctChoiceIndex;

  Question({
    String? id,
    required this.questionContent,
    required this.answer,
    required this.lesson,
    required this.subject,
    required this.choices,
    required this.correctChoiceIndex
  }) : id = id ?? const Uuid().v4();

  @override
  List<Object> get props => [
        id,
        questionContent,
        answer,
        lesson,
        subject,
        choices,
        correctChoiceIndex
      ];

  Question copyWith({
    String? id,
    String? questionContent,
    String? answer,
    String? lesson,
    String? subject,
    List<String>? choices,
    int? correctChoiceIndex,
  }) {
    return Question(
      id: id ?? this.id,
      questionContent: questionContent ?? this.questionContent,
      answer: answer ?? this.answer,
      lesson: lesson ?? this.lesson,
      subject: subject ?? this.subject,
      choices: choices ?? this.choices,
      correctChoiceIndex: correctChoiceIndex ?? this.correctChoiceIndex,
    );
  }

    factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  @override
  bool get stringify => true;
}

