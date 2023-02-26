import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toghraphy/app/app.dart';
import 'package:questions_repository/questions_repository.dart';

import '../../themes/theme.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required QuestionsRepository questionsRepository,
  }) : _questionsRepository = questionsRepository;

  final QuestionsRepository _questionsRepository;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _questionsRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppBloc()..add(AppOpened()),
          ),
          BlocProvider(
            create: (context) => ThemeBloc(),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: Colors.transparent,
        ),
        fontFamily: 'Tajawal',
        useMaterial3: true,
      ),
      home: FlowBuilder<PageStatus>(
          state: context.watch<AppBloc>().state.status,
          onGeneratePages: onGeneratePages),
    );
  }
}
