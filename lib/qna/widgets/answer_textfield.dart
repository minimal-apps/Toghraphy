import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toghraphy/qna/qna.dart';
import 'package:toghraphy/themes/theme.dart';

class AnswerTextField extends StatelessWidget {
  const AnswerTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    return TextField(
      controller: controller,
      onChanged: (text) {
        context.read<QnaBloc>().add(QnaAnswerChanged(text: text));
      },
      style: TextStyle(color: themeState.primaryColor),
      cursorColor: themeState.primaryColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: themeState.bubbleColor,
        contentPadding: const EdgeInsets.only(top: 30, left: 20, right: 10),
        counterStyle: Theme.of(context).textTheme.titleLarge,
        hintStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: themeState.primaryColor.withOpacity(0.4)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: themeState.bubbleColor, width: 2.0),
          borderRadius: BorderRadius.circular(16),
        ),
        labelStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontSize: 16, color: themeState.primaryColor),
        hintText: "اكتب جوابك ...",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: themeState.bubbleColor, width: 2.0),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      keyboardType: TextInputType.multiline,
      maxLines: null,
      minLines: 5,
    );
  }
}
