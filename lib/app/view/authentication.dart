import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toghraphy/app/app.dart';
import 'package:toghraphy/app/widgets/widgets.dart';
import 'package:toghraphy/qna/animation/animation.dart';

class Authentication extends StatelessWidget {
  Authentication({
    super.key,
  });
  static Page page() => SlidingPage(
      child: Authentication(), key: const ValueKey('authentication'),);

  String name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    'assets/logo.png',
                    width: 250,
                  ),
                ),
                const Text(
                  'التطبيق الأول من نوعه لتسهيل حفظ التاريخ و الجغرافيا على طلاب الأولى باكلوريا',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                )
              ],
            ),
            NameField(
              onChanged: (value) {
                print(value);
                name = value;
              },
            ),
            SizedBox(
                width: double.maxFinite,
                child: SubmitButton(
                    text: 'ابدأ',
                    color: Colors.white,
                    onPressed: () async {
                      if (name.isNotEmpty) {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('name', name);
                        context.read<AppBloc>().add(AppOpened());
                      }
                    },),)
          ],
        ),
      ),
    );
  }
}
