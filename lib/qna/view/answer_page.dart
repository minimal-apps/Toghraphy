import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hg_sips/app/app.dart';
import 'package:hg_sips/qna/qna.dart';
import 'package:hg_sips/themes/theme.dart';

class AnswerPage extends StatelessWidget {
  const AnswerPage({super.key});
  static Page page() =>
      const SlidingPage(child: AnswerPage(), key: ValueKey('answerPage'));

  @override
  Widget build(BuildContext context) {
    return const AnswerView();
  }
}

class AnswerView extends StatelessWidget {
  const AnswerView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    final qnaState = context.watch<QnaBloc>().state;

    return SafeArea(
      child: Scaffold(
        backgroundColor: themeState.backgroundColor,
        body: Stack(children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 20),
                    child: Column(
                      children: [
                        Text(
                          "جوابك",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: themeState.secondaryColor),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: themeState.bubbleColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            context.watch<QnaBloc>().state.userAnswer ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: themeState.primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 10),
                    child: Column(
                      children: [
                        Text(
                          "الجواب الصحيح",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: themeState.secondaryColor),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: themeState.bubbleColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            qnaState.question!.answer,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: themeState.primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SimpleButton(
                            icon: Icons.check,
                            text: "جوابك صحيح",
                            color: themeState.primaryColor,
                            onPressed: () {}),
                        SimpleButton(
                            icon: Icons.close,
                            text: "جوابك غير صحيح",
                            color: themeState.secondaryColor,
                            background: themeState.primaryColor,
                            onPressed: () {})
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: themeState.secondaryColor,
                  shape: const CircleBorder(),
                ),
                child: Icon(
                  Icons.close,
                  color: themeState.primaryColor,
                ),
                onPressed: () {
                  context.read<QnaBloc>().add(QnaNavigationTriggered(
                      status: QnaPageStatus.questionPage));
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
