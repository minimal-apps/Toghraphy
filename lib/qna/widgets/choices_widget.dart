// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toghraphy/qna/qna.dart';
import 'package:toghraphy/themes/theme.dart';

class ChoicesWidget extends StatefulWidget {
  const ChoicesWidget(
      {super.key,
      required this.qnaState,
      required this.widget,
      required this.isShown,});

  final QnaState qnaState;
  final TextFieldSection widget;
  final bool isShown;

  @override
  State<ChoicesWidget> createState() => _ChoicesWidgetState();
}

class _ChoicesWidgetState extends State<ChoicesWidget> {
  late List<bool> values;
  int clicked = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;

    values = widget.qnaState.question!.choices != null
        ? List.generate(
            widget.qnaState.question!.choices!.length,
            (index) => false,
          )
        : [];
    values.isNotEmpty ? values[clicked] = true : (){}();

    return widget.qnaState.question!.choices != null &&
            widget.qnaState.question!.choices!.isNotEmpty
        ? Column(
            children: widget.qnaState.question!.choices!.mapIndexed((index, e) {
              return ListTile(
                leading: Checkbox(
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  activeColor: themeState.secondaryColor,
                  checkColor:
                      widget.isShown ? Colors.green : themeState.primaryColor,
                  value: widget.isShown
                      ? (index == widget.qnaState.question!.correctChoiceIndex!
                          ? true
                          : false)
                      : values[index],
                  onChanged: (v) {
                    if (!widget.isShown) {
                      values = List.generate(
                        widget.qnaState.question!.choices!.length,
                        (index) => false,
                      );
                      setState(() {
                        values[index] = !values[index];
                        clicked = index;
                      });
                    } else {
                      setState(() {
                        values = List.generate(
                          widget.qnaState.question!.choices!.length,
                          (index) => false,
                        );
                        final index =
                            widget.qnaState.question!.correctChoiceIndex!;
                        values[index] = !values[index];
                      });
                    }
                  },
                ),
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
          )
        : const Text('هذا السؤال لا يتوفر على اختيارات');
  }
}
