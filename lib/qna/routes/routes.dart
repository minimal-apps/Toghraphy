import 'package:flutter/material.dart';
import 'package:toghraphy/qna/qna.dart';

List<Page> onGenerateFlowPages(
    QnaPageStatus status, List<Page<dynamic>> pages,) {
  print('hello');
  print(status.name);
  return [
    QuestionsPage.page(),
    if (status == QnaPageStatus.answerPage) AnswerPage.page()
  ];
}
