import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toghraphy/qna/qna.dart';
import 'package:questions_repository/questions_repository.dart';

class QnaFlow extends StatelessWidget {
  static Page page() =>
      const SlidingPage(child: QnaFlow(), key: ValueKey('flowPage'));
  const QnaFlow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              QnaBloc(questionsRepository: context.read<QuestionsRepository>())
                ..add(QnaQuestionRequested())
                ..add(QnaScoreChanged(score: 0)),
        ),
      ],
      child: const QnaFlowView(),
    );
  }
}

class QnaFlowView extends StatelessWidget {
  const QnaFlowView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<QnaPageStatus>(
      state: context.watch<QnaBloc>().state.status,
      onGeneratePages: onGenerateFlowPages,
    );
  }
}
