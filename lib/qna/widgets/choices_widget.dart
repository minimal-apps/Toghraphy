// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toghraphy/qna/qna.dart';
import 'package:toghraphy/themes/theme.dart';

class ChoicesWidget extends StatefulWidget {
  const ChoicesWidget({
    super.key,
    required this.qnaState,
    required this.widget,
  });

  final QnaState qnaState;
  final TextFieldSection widget;

  @override
  State<ChoicesWidget> createState() => _ChoicesWidgetState();
}

class _ChoicesWidgetState extends State<ChoicesWidget> {
  List<bool> values = [false, false, false];
  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;

    return Column(
      children: widget.qnaState.question!.choices.mapIndexed((index, e) {
        return ListTile(
          leading: Checkbox(
              overlayColor: const MaterialStatePropertyAll(Colors.transparent),
              activeColor: themeState.secondaryColor,
              checkColor: themeState.primaryColor,
              value: values[index],
              onChanged: (v) {
                values = [false, false, false];
                setState(() {
                  values[index] = !values[index];
                });
              },),
          title: Text(
            e,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: widget.widget.themeState.primaryColor,
            ),
          ),
        );
      }).toList(),
    );
  }
}
