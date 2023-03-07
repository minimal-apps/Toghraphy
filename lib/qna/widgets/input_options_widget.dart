import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:toghraphy/themes/theme.dart';

class InputOptionsWidget extends StatefulWidget {
  const InputOptionsWidget({
    super.key,
    required this.themeState,
    required this.optionsStateChanged,
    required this.onVoice,
  });
  final ThemeState themeState;
  final void Function(List<bool>) optionsStateChanged;
  final void Function(String) onVoice;

  @override
  State<InputOptionsWidget> createState() => _InputOptionsWidgetState();
}

class _InputOptionsWidgetState extends State<InputOptionsWidget> {
  List<bool> active = [false, true, false];
  void init() {
    active = active.map((e) => false).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async {
              init();
              setState(() {
                active[0] = true;
              });
              widget.optionsStateChanged(active);
              final speech = stt.SpeechToText();
              final available = await speech.initialize();

              if (available) {
                await speech.listen(
                    localeId: 'ar_MA',
                    onResult: (result) {
                      widget.onVoice(result.recognizedWords);
                    },);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: widget.themeState.primaryColor,
                border: Border.all(
                  color: widget.themeState.secondaryColor,
                  width: 2,
                ),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
              ),
              child: Text(
                'صوتي',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: active[0]
                        ? widget.themeState.secondaryColor.withOpacity(0.5)
                        : widget.themeState.secondaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              init();
              setState(() {
                active[1] = true;
              });
              widget.optionsStateChanged(active);
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: widget.themeState.primaryColor,
                border: Border.all(
                    color: widget.themeState.secondaryColor, width: 2),
              ),
              child: Text(
                'مكتوب',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: active[1]
                        ? widget.themeState.secondaryColor.withOpacity(0.5)
                        : widget.themeState.secondaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              init();
              setState(() {
                active[2] = true;
              });
              widget.optionsStateChanged(active);
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: widget.themeState.primaryColor,
                border: Border.all(
                    color: widget.themeState.secondaryColor, width: 2),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16)),
              ),
              child: Text(
                'اختيارات',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: active[2]
                      ? widget.themeState.secondaryColor.withOpacity(0.5)
                      : widget.themeState.secondaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
