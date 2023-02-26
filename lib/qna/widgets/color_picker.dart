import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toghraphy/themes/theme.dart';

class ColorPicker extends StatelessWidget {
  ColorPicker({
    super.key,
    required this.themeState,
  });
  final ThemeState themeState;

  @override
  Widget build(BuildContext context) {
    final dropdownItemList = [
      {
        'label': 'deepBrown',
        'value': DeepBrown(),
        'icon': Container(
          key: UniqueKey(),
          decoration: BoxDecoration(
              color: ThemeColors.deepBrown,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: themeState.secondaryColor)),
          height: 20,
          width: 20,
        ),
      },
      {
        'label': 'deepBlue',
        'value': DeepBlue(),
        'icon': Container(
          key: UniqueKey(),
          decoration: BoxDecoration(
              color: ThemeColors.deepBlue,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: themeState.secondaryColor)),
          height: 20,
          width: 20,
        ),
      },
      {
        'label': 'deepRed',
        'value': DeepRed(),
        'icon': Container(
          key: UniqueKey(),
          decoration: BoxDecoration(
              color: ThemeColors.deepRed,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: themeState.secondaryColor)),
          height: 20,
          width: 20,
        ),
      },
      {
        'label': 'deepGreen',
        'value': DeepGreen(),
        'icon': Container(
          key: UniqueKey(),
          decoration: BoxDecoration(
              color: ThemeColors.deepGreen,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: themeState.secondaryColor)),
          height: 20,
          width: 20,
        ),
      },
      {
        'label': 'deepPink',
        'value': DeepPink(),
        'icon': Container(
          key: UniqueKey(),
          decoration: BoxDecoration(
              color: ThemeColors.deepPink,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: themeState.secondaryColor)),
          height: 20,
          width: 20,
        ),
      },
      {
        'label': 'deepPurple',
        'value': DeepPurple(),
        'icon': Container(
          key: UniqueKey(),
          decoration: BoxDecoration(
              color: ThemeColors.deepPurple,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: themeState.secondaryColor)),
          height: 20,
          width: 20,
        ),
      },
      {
        'label': 'shallowBrown',
        'value': ShallowBrown(),
        'icon': Container(
          key: UniqueKey(),
          decoration: BoxDecoration(
              color: ThemeColors.shallowBrown,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: themeState.secondaryColor)),
          height: 20,
          width: 20,
        ),
      },
      {
        'label': 'shallowBlue',
        'value': ShallowBlue(),
        'icon': Container(
          key: UniqueKey(),
          decoration: BoxDecoration(
              color: ThemeColors.shallowBlue,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: themeState.secondaryColor)),
          height: 20,
          width: 20,
        ),
      },
      {
        'label': 'shallowRed',
        'value': ShallowRed(),
        'icon': Container(
          key: UniqueKey(),
          decoration: BoxDecoration(
              color: ThemeColors.shallowRed,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: themeState.secondaryColor)),
          height: 20,
          width: 20,
        ),
      },
      {
        'label': 'shallowGreen',
        'value': ShallowGreen(),
        'icon': Container(
          key: UniqueKey(),
          decoration: BoxDecoration(
              color: ThemeColors.shallowGreen,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: themeState.secondaryColor)),
          height: 20,
          width: 20,
        ),
      },
      {
        'label': 'shallowPink',
        'value': ShallowPink(),
        'icon': Container(
          key: UniqueKey(),
          decoration: BoxDecoration(
              color: ThemeColors.shallowPink,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: themeState.secondaryColor)),
          height: 20,
          width: 20,
        ),
      },
      {
        'label': 'shallowPurple',
        'value': ShallowPurple(),
        'icon': Container(
          key: UniqueKey(),
          decoration: BoxDecoration(
              color: ThemeColors.shallowPurple,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: themeState.secondaryColor)),
          height: 20,
          width: 20,
        ),
      },
      {
        'label': 'black',
        'value': Black(),
        'icon': Container(
          key: UniqueKey(),
          decoration: BoxDecoration(
              color: ThemeColors.black,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: themeState.secondaryColor)),
          height: 20,
          width: 20,
        ),
      },
      {
        'label': 'white',
        'value': White(),
        'icon': Container(
          key: UniqueKey(),
          decoration: BoxDecoration(
              color: ThemeColors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: themeState.secondaryColor)),
          height: 20,
          width: 20,
        ),
      },
    ];

    // ! here
    return Container(
      height: 40,
      width: 40,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
          color: themeState.bubbleColor,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: themeState.secondaryColor)),
      child: CoolDropdown(
        resultIcon: Icon(Icons.expand_circle_down, color: Colors.white),
        resultWidth: 50,
        iconSize: 15,
        dropdownWidth: 50,
        dropdownHeight: 200,
        dropdownItemHeight: 30,
        dropdownItemGap: 10,
        isDropdownLabel: false,
        isResultLabel: false,
        isResultIconLabel: false,
        resultBD: const BoxDecoration(
          color: Colors.transparent,
        ),
        dropdownList: dropdownItemList,
        onChange: (Map<String, dynamic> event) {
          final newEvent = event['value'] as ThemeEvent;
          print(newEvent);
          context.read<ThemeBloc>().add(newEvent);
        },
        defaultValue: dropdownItemList[1],
        resultIconLeftGap: 0,
        resultPadding: EdgeInsets.zero,
        resultIconRotationValue: 1,
        dropdownPadding: EdgeInsets.zero,
        resultAlign: Alignment.center,
        resultMainAxis: MainAxisAlignment.center,
        dropdownItemMainAxis: MainAxisAlignment.center,
        selectedItemBD: BoxDecoration(
            border: Border(
                left: BorderSide(
                    color: Colors.black.withOpacity(0.7), width: 3))),
        triangleWidth: 10,
        triangleHeight: 10,
        gap: 20,
      ),
    );
  }
}