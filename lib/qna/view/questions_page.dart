// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';
import 'dart:math' as math;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:toghraphy/qna/qna.dart';
import 'package:toghraphy/themes/theme.dart';
import 'package:questions_repository/questions_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

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
            )),
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
                          QuestionAndAnswerSection(
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
                            QuestionAndAnswerSection(
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

// class ButtonsSection extends StatefulWidget {
//   const ButtonsSection({
//     Key? key,
//     required this.themeState,
//     required this.onNextQuestion,
//   }) : super(key: key);

//   final ThemeState themeState;
//   final VoidCallback onNextQuestion;

//   @override
//   State<ButtonsSection> createState() => _ButtonsSectionState();
// }

// class _ButtonsSectionState extends State<ButtonsSection> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SimpleButton(
//                 text: "قارن جوابك بالجواب الصحيح",
//                 color: widget.themeState.primaryColor,
//                 onPressed: () {
//                   context.read<QnaBloc>().add(
//                         QnaNavigationTriggered(
//                           status: QnaPageStatus.answerPage,
//                         ),
//                       );
//                 }),
//             SimpleButton(
//                 icon: Icons.arrow_forward_ios,
//                 text: "السؤال الموالي ",
//                 color: widget.themeState.primaryColor,
//                 onPressed: () {
//                   context.read<QnaBloc>()
//                     ..add(
//                       QnaQuestionRequested(),
//                     )
//                     ..add(QnaAnswerChanged(text: ""));
//                   setState(() {
//                     widget.onNextQuestion();
//                   });
//                 })
//           ],
//         ),
//       ],
//     );
//   }
// }

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
            TextField(
              controller: widget.controller,
              onChanged: (text) {
                context.read<QnaBloc>().add(QnaAnswerChanged(text: text));
              },
              style: TextStyle(color: widget.themeState.primaryColor),
              cursorColor: widget.themeState.primaryColor,
              decoration: InputDecoration(
                filled: true,
                fillColor: widget.themeState.bubbleColor,
                contentPadding:
                    const EdgeInsets.only(top: 30, left: 20, right: 10),
                counterStyle: Theme.of(context).textTheme.headline6,
                hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: widget.themeState.primaryColor.withOpacity(0.4)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.themeState.bubbleColor, width: 2.0),
                  borderRadius: BorderRadius.circular(16),
                ),
                labelStyle: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 16, color: widget.themeState.primaryColor),
                hintText: "اكتب جوابك ...",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.themeState.bubbleColor, width: 2.0),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 5,
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

class InputOptionsWidget extends StatefulWidget {
  const InputOptionsWidget(
      {Key? key,
      required this.themeState,
      required this.optionsStateChanged,
      required this.onVoice})
      : super(key: key);
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
              final  available = await speech.initialize();

              if (available) {
                await speech.listen(
                    localeId: 'ar_MA',
                    onResult: (result) {
                      widget.onVoice(result.recognizedWords);
                    });
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

class QuestionAndAnswerSection extends StatelessWidget {
  const QuestionAndAnswerSection(
      {Key? key, required this.themeState, required this.isQuestion})
      : super(key: key);

  final ThemeState themeState;
  final bool isQuestion;

  @override
  Widget build(BuildContext context) {
    final qnaState = context.watch<QnaBloc>().state;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: themeState.bubbleColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: themeState.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isQuestion ? "السؤال" : "الجواب",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: themeState.secondaryColor),
                  ),
                ),
                Text(
                  qnaState.question == null
                      ? ''
                      : isQuestion
                          ? qnaState.question!.questionContent
                          : qnaState.question!.answer,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: themeState.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DropDownAppBar extends StatefulWidget {
  const DropDownAppBar({
    Key? key,
    required this.themeState,
  }) : super(key: key);

  final ThemeState themeState;

  @override
  State<DropDownAppBar> createState() => _DropDownAppBarState();
}

class _DropDownAppBarState extends State<DropDownAppBar> {
  List<String> historyLessons = [
    'التحولات الاقتصادية والمالية والاجتماعية والفكرية في العالم في القرن 19م',
    'التنافس الإمبريالي واندلاع الحرب العالمية الأولى',
    'اليقظة الفكرية بالمشرق العربي',
    'الضغوط الاستعمارية على المغرب ومحاولات الإصلاح',
    'أوربا من نهاية الحرب العالمية الأولى إلى أزمة 1929م',
    'الحرب العالمية الثانية (الأسباب والنتائج)',
    'نظام الحماية بالمغرب والاستغلال الاستعماري',
    'نضال المغرب من أجل تحقيق الاستقلال واستكمال الوحدة الترابية',
  ];
  List<String> geographyLessons = [
    'مفهوم التنمية، تعدد المقاربات، التقسيمات الكبرى للعالم (خريطة التنمية)',
    'المجال المغربي: الموارد الطبيعية والبشرية',
    'الاختيارات الكبرى لسياسة إعداد التراب الوطني',
    'التهيئة الحضرية والريفية: أزمة المدينة والريف وأشكال التدخل',
    'العالم العربي: مشكل الماء وظاهرة التصحر',
    'الولايات المتحدة الأمريكية قوة اقتصادية عظمى',
    'الاتحاد الأوربي نحو اندماج شامل',
    'الصين قوة اقتصادية صاعدة',
  ];
  List<String> dropDownLessons = [''];
  String mainDropDown = '';
  String userName = '';
  int userScore = 0;
  @override
  void initState() {
    dropDownLessons = historyLessons;
    mainDropDown = 'التاريخ';
    getUserPrefs();
    super.initState();
  }

  Future<void> getUserPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final qnaState = context.watch<QnaBloc>().state;

    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 20, right: 5, left: 5),
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: CustomDropDown(
                  onChanged: (v) {
                    setState(() {
                      mainDropDown = v;
                      if (v == "التاريخ") {
                        context.read<QnaBloc>().add(QnaFilterChanged(
                            filterLesson: historyLessons[0],
                            filterSubject: 'التاريخ'));
                      } else {
                        context.read<QnaBloc>().add(QnaFilterChanged(
                            filterLesson: geographyLessons[0],
                            filterSubject: 'الجغرافيا'));
                      }
                    });
                  },
                  items: const ["التاريخ", "الجغرافيا"],
                ),
              ),
              if (mainDropDown == "التاريخ")
                CustomDropDownBottom(
                  key: UniqueKey(),
                  onChanged: (lesson) {
                    context.read<QnaBloc>().add(QnaFilterChanged(
                        filterLesson: lesson!, filterSubject: 'التاريخ'));
                  },
                  items: historyLessons,
                )
              else
                CustomDropDownBottom(
                  key: UniqueKey(),
                  onChanged: (lesson) {
                    context.read<QnaBloc>().add(QnaFilterChanged(
                        filterLesson: lesson!, filterSubject: "الجغرافيا"));
                  },
                  items: geographyLessons,
                )
            ],
          )
        ],
      ),
    );
  }
}
