// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';
import 'dart:math' as math;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:toghraphy/qna/qna.dart';
import 'package:toghraphy/themes/theme.dart';

class QuestionsPage extends StatelessWidget {
  const QuestionsPage({super.key});
  static Page page() => const SlidingPage(child: QuestionsPage());

  @override
  Widget build(BuildContext context) {
    return const QuestionsView();
  }
}

class QuestionsView extends StatefulWidget {
  const QuestionsView({super.key});

  @override
  State<QuestionsView> createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView> {
  AdWidget? adWidget;
  final myBanner = BannerAd(
    adUnitId: 'ca-app-pub-9274006447661564/1672608508',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: BannerAdListener(
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
        print('Ad failed to load: $error');
      },
      onAdOpened: (Ad ad) => print('Ad opened.'),
      onAdClosed: (Ad ad) => print('Ad closed.'),
      onAdImpression: (Ad ad) => print('Ad impression.'),
    ),
  );
  @override
  void initState() {
    super.initState();
    showAd();
  }

  Future<void> showAd() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      await myBanner.load().onError((error, stackTrace) {
        adWidget = null;
        return;
      });

      setState(() {
        adWidget = AdWidget(ad: myBanner);
      });
    }
  }

  final TextEditingController controller = TextEditingController();
  bool isAnswerShown = false;
  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Directionality(
          textDirection: TextDirection.rtl,
          child: FloatingActionButton(
            backgroundColor: themeState.primaryColor,
            elevation: 0,
            child: ColorPicker(themeState: themeState),
            onPressed: () {},
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
        bottomNavigationBar: BottomAppBar(
          color: themeState.bubbleColor,
          notchMargin: 0,
          child: Row(
            children: [
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: IconButton(
                  icon: Icon(
                    isAnswerShown ? Icons.visibility_off : Icons.visibility,
                    color: themeState.primaryColor,
                  ),
                  iconSize: 41,
                  onPressed: () {
                    setState(() {
                      isAnswerShown = !isAnswerShown;
                    });
                  },
                ),
              ),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: IconButton(
                  icon: Icon(
                    Icons.next_plan,
                    color: themeState.primaryColor,
                  ),
                  iconSize: 41,
                  onPressed: () {
                    context.read<QnaBloc>()
                      ..add(
                        QnaQuestionRequested(),
                      )
                      ..add(QnaAnswerChanged(text: ''));
                    setState(controller.clear);
                  },
                ),
              ),
            ],
          ),
        ),
        backgroundColor: themeState.backgroundColor,
        appBar: AppBar(
          toolbarHeight: 70,
          centerTitle: true,
          backgroundColor: themeState.primaryColor,
          title: Text(
            "تغرافيا",
            style: TextStyle(
                color: themeState.secondaryColor, fontWeight: FontWeight.bold),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(120.0),
            child: DropDownAppBar(themeState: themeState),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: double.maxFinite,
            child: Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minWidth: constraints.maxWidth,
                          minHeight: constraints.maxHeight),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          QnaBubble(
                            themeState: themeState,
                            isQuestion: true,
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            alignment: Alignment.center,
                            width: adWidget != null
                                ? myBanner.size.width.toDouble()
                                : 0,
                            height: adWidget != null
                                ? myBanner.size.height.toDouble()
                                : 0,
                            child: adWidget,
                          ),
                          TextFieldSection(
                            themeState: themeState,
                            controller: controller,
                          ),
                          if (isAnswerShown)
                            QnaBubble(
                              themeState: themeState,
                              isQuestion: false,
                            )
                          else
                            Container(),
                          // ButtonsSection(
                          //   themeState: themeState,
                          //   onNextQuestion: controller.clear,
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldSection extends StatefulWidget {
  const TextFieldSection({
    Key? key,
    required this.controller,
    required this.themeState,
  }) : super(key: key);
  final TextEditingController controller;
  final ThemeState themeState;

  @override
  State<TextFieldSection> createState() => _TextFieldSectionState();
}

class _TextFieldSectionState extends State<TextFieldSection> {
  List<bool> optionsState = [false, true, false];
  String spokenText = '';
  @override
  Widget build(BuildContext context) {
    final qnaState = context.watch<QnaBloc>().state;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: widget.themeState.bubbleColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            margin: EdgeInsets.only(bottom: 10, top: 10),
            decoration: BoxDecoration(
              color: widget.themeState.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "جوابك",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: widget.themeState.secondaryColor),
            ),
          ),
          if (optionsState[1])
            AnswerTextField(
              controller: widget.controller,
            ),
          if (optionsState[0])
            Text(
              spokenText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: widget.themeState.primaryColor,
              ),
            ),
          if (optionsState[2])
            ChoicesWidget(qnaState: qnaState, widget: widget),
          InputOptionsWidget(
            onVoice: (text) {
              setState(() {
                spokenText = text;
              });
            },
            optionsStateChanged: (list) {
              setState(() {
                optionsState = list as List<bool>;
              });
              print(optionsState);
            },
            themeState: widget.themeState,
          )
        ],
      ),
    );
  }
}

