import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toghraphy/qna/qna.dart';
import 'package:toghraphy/themes/theme.dart';


class DropDownAppBar extends StatefulWidget {
  const DropDownAppBar({
    super.key,
    required this.themeState,
  });

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
  
  @override
  void initState() {
    dropDownLessons = historyLessons;
    mainDropDown = 'التاريخ';
    super.initState();
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
                padding: const EdgeInsets.only(bottom: 8),
                child: CustomDropDown(
                  onChanged: (v) {
                    setState(() {
                      mainDropDown = v;
                      if (v == 'التاريخ') {
                        context.read<QnaBloc>().add(QnaFilterChanged(
                            filterLesson: historyLessons[0],
                            filterSubject: 'التاريخ',),);
                      } else {
                        context.read<QnaBloc>().add(QnaFilterChanged(
                            filterLesson: geographyLessons[0],
                            filterSubject: 'الجغرافيا',),);
                      }
                    });
                  },
                  items: const ['التاريخ', 'الجغرافيا'],
                ),
              ),
              if (mainDropDown == 'التاريخ')
                CustomDropDownBottom(
                  key: UniqueKey(),
                  onChanged: (lesson) {
                    context.read<QnaBloc>().add(QnaFilterChanged(
                        filterLesson: lesson!, filterSubject: 'التاريخ',),);
                  },
                  items: historyLessons,
                )
              else
                CustomDropDownBottom(
                  key: UniqueKey(),
                  onChanged: (lesson) {
                    context.read<QnaBloc>().add(QnaFilterChanged(
                        filterLesson: lesson!, filterSubject: 'الجغرافيا',),);
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