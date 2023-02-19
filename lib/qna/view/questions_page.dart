// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:toghraphy/qna/qna.dart';
import 'package:toghraphy/themes/theme.dart';
import 'package:questions_repository/questions_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeState.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(190.0),
          child: DropDownAppBar(themeState: themeState),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: double.maxFinite,
            child: Center(
              child: LayoutBuilder(builder: (context, constraints) {
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
                        QuestionSection(themeState: themeState),
                        TextFieldSection(
                          themeState: themeState,
                          controller: controller,
                        ),
                        ButtonsSection(
                          themeState: themeState,
                          onNextQuestion: controller.clear,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: adWidget != null
                              ? myBanner.size.width.toDouble()
                              : 0,
                          height: adWidget != null
                              ? myBanner.size.height.toDouble()
                              : 0,
                          child: adWidget,
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonsSection extends StatefulWidget {
  const ButtonsSection({
    Key? key,
    required this.themeState,
    required this.onNextQuestion,
  }) : super(key: key);

  final ThemeState themeState;
  final VoidCallback onNextQuestion;

  @override
  State<ButtonsSection> createState() => _ButtonsSectionState();
}

class _ButtonsSectionState extends State<ButtonsSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SimpleButton(
                text: "قارن جوابك بالجواب الصحيح",
                color: widget.themeState.primaryColor,
                onPressed: () {
                  context.read<QnaBloc>().add(
                        QnaNavigationTriggered(
                          status: QnaPageStatus.answerPage,
                        ),
                      );
                }),
            SimpleButton(
                icon: Icons.arrow_forward_ios,
                text: "السؤال الموالي ",
                color: widget.themeState.primaryColor,
                onPressed: () {
                  context.read<QnaBloc>()
                    ..add(
                      QnaQuestionRequested(),
                    )
                    ..add(QnaAnswerChanged(text: ""));
                  setState(() {
                    widget.onNextQuestion();
                  });
                })
          ],
        ),
      ],
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "الجواب",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: widget.themeState.secondaryColor),
        ),
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
            contentPadding: const EdgeInsets.only(top: 30, left: 20, right: 10),
            counterStyle: Theme.of(context).textTheme.headline6,
            hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: widget.themeState.primaryColor.withOpacity(0.4)),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: widget.themeState.bubbleColor, width: 2.0),
              borderRadius: BorderRadius.circular(16),
            ),
            labelStyle: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontSize: 16, color: widget.themeState.primaryColor),
            hintText: "اكتب جوابك ...",
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: widget.themeState.bubbleColor, width: 2.0),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          keyboardType: TextInputType.multiline,
          maxLines: null,
          minLines: 5,
        ),
      ],
    );
  }
}

class QuestionSection extends StatelessWidget {
  const QuestionSection({
    Key? key,
    required this.themeState,
  }) : super(key: key);

  final ThemeState themeState;

  @override
  Widget build(BuildContext context) {
    final qnaState = context.watch<QnaBloc>().state;
    print('hello');
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Text(
            "السؤال",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: themeState.secondaryColor),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: themeState.bubbleColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              qnaState.question == null
                  ? ''
                  : qnaState.question!.questionContent,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: themeState.primaryColor,
              ),
            ),
          )
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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'مرحبا  $userName',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: widget.themeState.secondaryColor),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: widget.themeState.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(color: widget.themeState.secondaryColor)),
                  child: Text(
                    "النقاط : ${qnaState.score}",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: widget.themeState.secondaryColor),
                  ),
                ),
                ColorPicker(themeState: widget.themeState)
              ],
            ),
          ),
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
                    print("heeey");
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
