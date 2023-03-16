import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:toghraphy/themes/theme.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton(
      {super.key,
      required this.text,
      this.icon,
      this.background,
      required this.color,
      required this.onPressed,});
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color color;
  final Color? background;
  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    return TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: color,
              ),),
          backgroundColor: background ?? themeState.secondaryColor,
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            text,
            style: TextStyle(color: color, fontSize: 20),
          ),
        ),);
  }
}
