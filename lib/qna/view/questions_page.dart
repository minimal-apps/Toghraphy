// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hg_sips/qna/qna.dart';
import 'package:hg_sips/themes/theme.dart';
import 'package:questions_repository/questions_repository.dart';

class QuestionsPage extends StatelessWidget {
  const QuestionsPage({super.key});
  static Page page() => const SlidingPage(child: QuestionsPage());

  @override
  Widget build(BuildContext context) {
    return const QuestionsView();
  }
}

class QuestionsView extends StatelessWidget {
  const QuestionsView({super.key});

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
                        TextFieldSection(themeState: themeState),
                        ButtonsSection(themeState: themeState)
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

class ButtonsSection extends StatelessWidget {
  const ButtonsSection({
    Key? key,
    required this.themeState,
  }) : super(key: key);

  final ThemeState themeState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SimpleButton(
                text: "قارن جوابك بالجواب الصحيح",
                color: themeState.primaryColor,
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
                color: themeState.primaryColor,
                onPressed: () {
                  context.read<QnaBloc>().add(
                        QnaQuestionRequested(),
                      );
                })
          ],
        ),
      ],
    );
  }
}

class TextFieldSection extends StatelessWidget {
  const TextFieldSection({
    Key? key,
    required this.themeState,
  }) : super(key: key);

  final ThemeState themeState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "الجواب",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: themeState.secondaryColor),
        ),
        TextField(
          onChanged: (text) {
            context.read<QnaBloc>().add(QnaAnswerChanged(text: text));
          },
          style: TextStyle(color: themeState.primaryColor),
          cursorColor: themeState.primaryColor,
          decoration: InputDecoration(
            filled: true,
            fillColor: themeState.bubbleColor,
            contentPadding: const EdgeInsets.only(top: 30, left: 20, right: 10),
            counterStyle: Theme.of(context).textTheme.headline6,
            hintStyle: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: themeState.primaryColor.withOpacity(0.4)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: themeState.bubbleColor, width: 2.0),
              borderRadius: BorderRadius.circular(16),
            ),
            labelStyle: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontSize: 16, color: themeState.primaryColor),
            hintText: "اكتب جوابك ...",
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: themeState.bubbleColor, width: 2.0),
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
              "",
              // qnaState.question!.questionContent,
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
    'التحولات الكبرى للعالم الرأسمالي وانعكاساتها خلال القرن 19م ومطلع القرن 20م',
    'التحولات الاقتصادية والمالية والاجتماعية والفكرية في العالم في القرن 19م',
    'التنافس الإمبريالي واندلاع الحرب العالمية الأولى',
    'اليقظة الفكرية بالمشرق العربي',
    'الضغوط الاستعمارية على المغرب ومحاولات الإصلاح',
    'أوربا من نهاية الحرب العالمية الأولى إلى أزمة 1929م',
    'الحرب العالمية الثانية (الأسباب والنتائج)',
    'نظام الحماية بالمغرب والاستغلال الاستعماري',
    'نضال المغرب من أجل تحقيق الاستقلال واستكمال الوحدة الترابية',
    'العولمة والتحديات الراهنة',
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
  @override
  void initState() {
    dropDownLessons = historyLessons;
    mainDropDown = 'التاريخ';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  "مرحبا مجددا محمود",
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
                    "النقاط : 15",
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
                    });
                  },
                  items: const ["التاريخ", "الجغرافيا"],
                ),
              ),
              if (mainDropDown == "التاريخ")
                CustomDropDown(
                  key: UniqueKey(),
                  onChanged: (v) {
                    context.read<QnaBloc>().add(QnaFilterChanged(filter: v));
                  },
                  items: historyLessons,
                )
              else
                CustomDropDown(
                  key: UniqueKey(),
                  onChanged: (v) {
                    context.read<QnaBloc>().add(QnaFilterChanged(filter: v));
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
