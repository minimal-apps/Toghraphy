// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class NameField extends StatefulWidget {
  const NameField({
    super.key,
    required this.onChanged,
  });

  final ValueChanged<String> onChanged;
  @override
  State<NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {
  String maxLength = '0/9';

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.black,
      onChanged: (value) {
        widget.onChanged(value);
        setState(() {
          maxLength = '${value.length}/9';
        });
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 30, left: 20, right: 10),
        counterText: maxLength,
        counterStyle: Theme.of(context).textTheme.titleLarge,
        hintStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.black),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        labelText: 'اكتب اسمك',
        labelStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontSize: 16, color: Colors.black),
        hintText: 'أدخل اسمك',
        prefix: const Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.person,
            size: 20,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLength: 9,
    );
  }
}
