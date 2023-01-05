import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hg_sips/themes/theme.dart';

class CustomDropDown extends StatefulWidget {
  CustomDropDown({super.key, required this.items, required this.onChanged});
  final void Function(String) onChanged;
  List<String> items;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  late String currentValue = widget.items[0];

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      decoration: BoxDecoration(
          color: themeState.primaryColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: themeState.secondaryColor)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          icon: Icon(
            Icons.expand_more,
            color: themeState.secondaryColor,
          ),
          dropdownColor: themeState.primaryColor,
          isExpanded: true,
          elevation: 0,
          value: currentValue.isNotEmpty
              ? currentValue
              : null, // guard it with null if empty
          items: widget.items
              .map(
                (e) => DropdownMenuItem<String>(
                  key: UniqueKey(),
                  child: Text(
                    e,
                    style: TextStyle(
                      color: themeState.secondaryColor,
                      fontSize: 13,
                    ),
                  ),
                  value: e,
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              currentValue = value ?? currentValue;
            });
            widget.onChanged(currentValue);
          },
        ),
      ),
    );
  }
}
