import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toghraphy/qna/qna.dart';
import 'package:toghraphy/themes/theme.dart';

class QnaBubble extends StatelessWidget {
  const QnaBubble(
      {super.key, required this.themeState, required this.isQuestion});

  final ThemeState themeState;
  final bool isQuestion;

  @override
  Widget build(BuildContext context) {
    final qnaState = context.watch<QnaBloc>().state;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: themeState.bubbleColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: themeState.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isQuestion ? "السؤال" : "الجواب",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: themeState.secondaryColor),
                  ),
                ),
                Text(
                  qnaState.question == null
                      ? ''
                      : isQuestion
                          ? qnaState.question!.questionContent
                          : qnaState.question!.answer,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: themeState.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
