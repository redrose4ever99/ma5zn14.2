import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/localization_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/utill/sizr.dart';

import 'package:flutter_sixvalley_ecommerce/view/screen/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({super.key});

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreen();
}

class _ChooseLanguageScreen extends State<ChooseLanguageScreen> {
  // bool _isArabic = false;
  bool _isEg = true;
  bool _isExpanded = false;
  bool _isExpanded1 = false;
  @override
  Widget build(BuildContext context) {
    _isEg = Provider.of<LocalizationProvider>(context, listen: false)
            .locale
            .languageCode ==
        AppConstants.languages[0].languageCode;
    _isExpanded1 = _isEg;
    _isExpanded = !_isExpanded1;

    Color prmColor = Theme.of(context).primaryColor;
    //var screenSize = MediaQuery.of(context).size;
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      children: [
        Provider.of<ThemeProvider>(context).darkTheme
            ? const SizedBox()
            : SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(Images.background, fit: BoxFit.fill),
              ),
        SizedBox(
            height: fullHeight,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(height: 100),
                  AnimatedContainer(
                    duration: const Duration(seconds: 3),
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.fill,
                      width: width(150),
                      height: height(100),
                      color: prmColor,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Center(
                    child: Text(
                      getTranslated('choose_language_for1', context)!,
                      style: onBoardtitle.copyWith(fontSize: 26),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextButton(
                              onPressed: () {
                                Provider.of<LocalizationProvider>(context,
                                        listen: false)
                                    .setLanguage(Locale(
                                  AppConstants.languages[0].languageCode!,
                                  AppConstants.languages[0].countryCode,
                                ));
                                setState(() {
                                  _isEg = !_isEg;
                                  _isExpanded1 = !_isExpanded1;
                                });
                              },
                              child: AnimatedContainer(
                                curve: Curves.linearToEaseOut,
                                duration: const Duration(seconds: 2),
                                width: _isExpanded1
                                    ? fullWidth / 2.7
                                    : fullWidth / 3.2,
                                height: _isExpanded1
                                    ? fullWidth / 2.7
                                    : fullWidth / 3.2,
                                decoration: BoxDecoration(
                                    border: Border.all(color: prmColor),
                                    color: (_isEg)
                                        ? Theme.of(context).primaryColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        _isExpanded1 ? 50 : fullWidth / 2.7)),
                                alignment: Alignment.center,
                                child: Text(
                                  "English",
                                  style: titilliumBold.copyWith(
                                      fontSize: 18,
                                      color: (_isEg)
                                          ? Colors.white
                                          : Theme.of(context).primaryColor),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextButton(
                              onPressed: () {
                                Provider.of<LocalizationProvider>(context,
                                        listen: false)
                                    .setLanguage(Locale(
                                  AppConstants.languages[1].languageCode!,
                                  AppConstants.languages[1].countryCode,
                                ));

                                setState(() {
                                  _isEg = !_isEg;
                                  _isExpanded = !_isExpanded;
                                });
                              },
                              child: AnimatedContainer(
                                curve: Curves.linearToEaseOut,
                                duration: const Duration(seconds: 2),
                                width: _isExpanded
                                    ? fullWidth / 2.7
                                    : fullWidth / 3.2,
                                height: _isExpanded
                                    ? fullWidth / 2.7
                                    : fullWidth / 3.2,
                                decoration: BoxDecoration(
                                    border: Border.all(color: prmColor),
                                    color: (!_isEg)
                                        ? Theme.of(context).primaryColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        _isExpanded ? 50 : fullWidth / 2.7)),
                                alignment: Alignment.center,
                                child: Text("العربية",
                                    style: titilliumBold.copyWith(
                                        fontSize: 18,
                                        color: (!_isEg)
                                            ? Colors.white
                                            : Theme.of(context).primaryColor)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 70),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).scaffoldBackgroundColor),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => OnBoardingScreen(
                                indicatorColor: ColorResources.grey,
                                selectedIndicatorColor:
                                    Theme.of(context).primaryColor)));
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Center(
                          child: Image.asset(
                            "assets/images/Next_button.png",
                            fit: BoxFit.fill,
                            width: width(130),
                            height: height(130),
                            matchTextDirection: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            )),
      ],
    ));
  }
}
