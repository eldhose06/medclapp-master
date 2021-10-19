import 'package:flutter/material.dart';
import 'package:medclapp/utils/styles.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:medclapp/utils/globals.dart' as globals;

class Instruction1Screen extends StatefulWidget {
  @override
  _Instruction1ScreenState createState() => _Instruction1ScreenState();
}

class _Instruction1ScreenState extends State<Instruction1Screen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/login');
    // Navigator.pushNamed(context, '/dashboard');
  }

  void _onIntroDone(context) {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/login');
    // Navigator.pushNamed(context, '/dashboard');
  }

  Widget _buildImage(String assetName) {
    return Container(
      child: Center(
        child: Align(
          child: Image.asset(
            'lib/assets/images/onboarding/$assetName.png',
            fit: BoxFit.contain,
          ),
          alignment: Alignment.center,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: Styles.instructionTitleText,
      bodyTextStyle: Styles.instructionDescriptionText,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return Directionality(
        textDirection: globals.defaultLanguage == 'Arabic'
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: IntroductionScreen(
          key: introKey,
          pages: [
            PageViewModel(
              title: '',
              body: 'Align all your medical datas in one palce',
              image: _buildImage('board1'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: '',
              body: 'Get your lab report on your mobile',
              image: _buildImage('board2'),
              decoration: pageDecoration,
            ),
            // PageViewModel(
            //   title: 'Instruction Title 3 Details',
            //   body: 'Instruction Detail 3 Details',
            //   image: _buildImage('3'),
            //   decoration: pageDecoration,
            // ),
          ],
          onDone: () => _onIntroDone(context),
          onSkip: () => _onIntroEnd(context),
          showSkipButton: true,
          skipFlex: 0,
          nextFlex: 0,
          skip: globals.defaultLanguage == 'Arabic'
              ? const Text(
                  'SKIP',
                  style: Styles.skipText,
                )
              : const Text(
                  'SKIP',
                  style: Styles.skipText,
                ),
          next: const Icon(Icons.arrow_forward),
          done: const Text('Done',
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.green)),
          dotsDecorator: const DotsDecorator(
            size: Size(12.0, 12.0),
            color: Colors.grey,
            activeSize: Size(12.0, 12.0),
            activeColor: Styles.secondaryColor,
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        ));
  }
}
