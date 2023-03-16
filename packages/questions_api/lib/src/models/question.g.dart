// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: json['id'] as String?,
      questionContent: json['questionContent'] as String?,
      answer: json['answer'] as String?,
      lesson: json['lesson'] as String?,
      subject: json['subject'] as String?,
      choices:
          (json['choices'] as List<dynamic>?)?.map((e) => e as String).toList(),
      correctChoiceIndex: json['correctChoiceIndex'] as int?,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'questionContent': instance.questionContent,
      'answer': instance.answer,
      'lesson': instance.lesson,
      'subject': instance.subject,
      'choices': instance.choices,
      'correctChoiceIndex': instance.correctChoiceIndex,
    };
