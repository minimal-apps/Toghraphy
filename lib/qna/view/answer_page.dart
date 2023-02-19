import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:toghraphy/app/app.dart';
import 'package:toghraphy/qna/qna.dart';
import 'package:toghraphy/themes/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnswerPage extends StatelessWidget {
  const AnswerPage({super.key});
  static Page page() =>
      const SlidingPage(child: AnswerPage(), key: ValueKey('answerPage'));

  @override
  Widget build(BuildContext context) {
    return const AnswerView();
  }
}

class AnswerView extends StatefulWidget {
  const AnswerView({super.key});

  @override
  State<AnswerView> createState() => _AnswerViewState();
}

class _AnswerViewState extends State<AnswerView> {
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
    final connectivityResult = await (Connectivity().checkConnectivity());
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

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    final qnaState = context.watch<QnaBloc>().state;

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: themeState.backgroundColor,
          body: Stack(children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 20),
                      child: Column(
                        children: [
                          Text(
                            "الجواب الصحيح",
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
                                  ? ""
                                  : qnaState.question!.answer,
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 10),
                      child: Column(
                        children: [
                          Text(
                            "جوابك",
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
                              context.watch<QnaBloc>().state.userAnswer ?? '',
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SimpleButton(
                            icon: Icons.check,
                            text: 'جوابك صحيح',
                            color: themeState.primaryColor,
                            onPressed: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              final newScore = prefs.getInt('score')! + 5;
                              await prefs.setInt('score', newScore);
                              context.read<QnaBloc>()
                                ..add(QnaScoreChanged(score: newScore))
                                ..add(
                                  QnaNavigationTriggered(
                                    status: QnaPageStatus.questionPage,
                                  ),
                                );
                            },
                          ),
                          SimpleButton(
                              icon: Icons.close,
                              text: "جوابك غير صحيح",
                              color: themeState.secondaryColor,
                              background: themeState.primaryColor,
                              onPressed: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                final newScore = prefs.getInt('score')! - 5;
                                await prefs.setInt('score', newScore);
                                context.read<QnaBloc>()
                                  ..add(QnaScoreChanged(score: newScore))
                                  ..add(
                                    QnaNavigationTriggered(
                                      status: QnaPageStatus.questionPage,
                                    ),
                                  );
                              })
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width:
                          adWidget != null ? myBanner.size.width.toDouble() : 0,
                      height: adWidget != null
                          ? myBanner.size.height.toDouble()
                          : 0,
                      child: adWidget,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: themeState.secondaryColor,
                    shape: const CircleBorder(),
                  ),
                  child: Icon(
                    Icons.close,
                    color: themeState.primaryColor,
                  ),
                  onPressed: () {
                    context.read<QnaBloc>().add(QnaNavigationTriggered(
                        status: QnaPageStatus.questionPage));
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
