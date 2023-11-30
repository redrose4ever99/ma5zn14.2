import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/onboarding_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/utill/sizr.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/started/started_screen.dart';

import 'package:provider/provider.dart';

class OnBoardingScreen extends StatelessWidget {
  final Color indicatorColor;
  final Color selectedIndicatorColor;

  OnBoardingScreen({
    Key? key,
    this.indicatorColor = Colors.grey,
    this.selectedIndicatorColor = Colors.black,
  }) : super(key: key);

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    Provider.of<OnBoardingProvider>(context, listen: false)
        .initBoardingList(context);

    double fullHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Provider.of<ThemeProvider>(context).darkTheme
              ? const SizedBox()
              : SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.asset(Images.background, fit: BoxFit.fill),
                ),
          Consumer<OnBoardingProvider>(
            builder: (context, onBoardingList, child) => ListView(
              children: [
                SizedBox(
                  height: fullHeight * 0.8,
                  child: PageView.builder(
                    itemCount: onBoardingList.onBoardingList.length,
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Stack(
                            children: [
                              AnimatedOpacity(
                                duration: const Duration(seconds: 2),
                                opacity: 0.47,
                                child: ClipPath(
                                  clipper: WaveCliper(),
                                  child: Container(
                                    color: const Color(0xff03A197),
                                    height: screenSize.height * 0.6,
                                  ),
                                ),
                              ),
                              ClipPath(
                                  clipper: WaveCliper(),
                                  child: SizedBox(
                                    height: screenSize.height * 0.6 - 15,
                                    child: Image.asset(
                                      onBoardingList
                                          .onBoardingList[index].imageUrl,
                                      fit: BoxFit.fill,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                    //  ImageConstant.imgImage,
                                    //fit: BoxFit.cover,
                                  )),
                              AnimatedOpacity(
                                duration: const Duration(seconds: 1),
                                opacity: 0.21,
                                child: ClipPath(
                                  clipper: WaveCliper(),
                                  child: Container(
                                    color: const Color(0xff028A81),
                                    height: screenSize.height * 0.6 - 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _pageIndicators(
                                onBoardingList.onBoardingList, context),
                          ),
                          const SizedBox(height: 10),
                          Text(onBoardingList.onBoardingList[index].title,
                              style: onBoardtitle, textAlign: TextAlign.center),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Center(
                              child: Text(
                                  onBoardingList
                                      .onBoardingList[index].description,
                                  textAlign: TextAlign.center,
                                  style: onBoarddescrip.copyWith(
                                    fontSize: 14,
                                  )),
                            ),
                          ),
                          const Spacer(),
                        ],
                      );
                    },
                    onPageChanged: (index) {
                      onBoardingList.changeSelectIndex(index);
                    },
                  ),
                ),
                Container(
                  height: fullHeight * 0.09,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 70, vertical: Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Theme.of(context).primaryColor),
                  child: TextButton(
                    onPressed: () {
                      if (Provider.of<OnBoardingProvider>(context,
                                  listen: false)
                              .selectedIndex ==
                          onBoardingList.onBoardingList.length - 1) {
                        Provider.of<SplashProvider>(context, listen: false)
                            .disableIntro();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const StartScreen()));
                      } else {
                        _pageController.animateToPage(
                            Provider.of<OnBoardingProvider>(context,
                                        listen: false)
                                    .selectedIndex +
                                1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInCirc);
                      }
                    },
                    child: Container(
                      height: height(42),
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                          onBoardingList.selectedIndex ==
                                  onBoardingList.onBoardingList.length - 1
                              ? getTranslated('GET_STARTED', context)!
                              : getTranslated('NEXT', context)!,
                          style: titilliumSemiBold.copyWith(
                              color: Colors.white,
                              fontSize: Dimensions.fontSizeLarge)),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _pageIndicators(var onBoardingList, BuildContext context) {
    List<Container> indicators = [];

    for (int i = 0; i < onBoardingList.length; i++) {
      indicators.add(
        Container(
          width: i == Provider.of<OnBoardingProvider>(context).selectedIndex
              ? 18
              : 7,
          height: 7,
          margin: const EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            color: i == Provider.of<OnBoardingProvider>(context).selectedIndex
                ? Theme.of(context).primaryColor
                : Colors.white,
            borderRadius:
                i == Provider.of<OnBoardingProvider>(context).selectedIndex
                    ? BorderRadius.circular(50)
                    : BorderRadius.circular(25),
          ),
        ),
      );
    }
    return indicators;
  }
}

class WaveCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = Path();
    path.lineTo(0, size.height);

    path.quadraticBezierTo(size.width * 0.15 + 30, size.height * 0.92,
        size.width * 0.3 + 40, size.height * 0.97);
    path.quadraticBezierTo(size.width * 0.75 + 40, size.height * 1.1,
        size.width, size.height * 0.5);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
