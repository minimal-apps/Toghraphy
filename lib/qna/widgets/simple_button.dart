import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:toghraphy/themes/theme.dart';

class SimpleButton extends StatelessWidget {
  const SimpleButton(
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
      child: icon == null
          ? Text(
              text,
              style: TextStyle(color: color, fontSize: 12),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: TextStyle(color: color),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Icon(
                    icon,
                    color: color,
                  ),
                )
              ],
            ),
    );
  }
}
