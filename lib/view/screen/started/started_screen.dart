import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/utill/sizr.dart';

import 'package:flutter_sixvalley_ecommerce/view/screen/auth/auth_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/dashboard/dashboard_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/onboarding/onboarding_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color prmColor = Theme.of(context).primaryColor;
    //var screenSize = MediaQuery.of(context).size;
    double fullHeight = MediaQuery.of(context).size.height;
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
                  Stack(
                    children: [
                      Opacity(
                        opacity: 0.47,
                        child: ClipPath(
                          clipper: WaveCliper(),
                          child: Container(
                            color: const Color(0xff03A197),
                            height: fullHeight * 0.6,
                          ),
                        ),
                      ),
                      ClipPath(
                          clipper: WaveCliper(),
                          child: SizedBox(
                            height: fullHeight * 0.6 - 15,
                            child: Image.asset(
                              "assets/images/onboard4.png",
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width,
                            ),
                            //  ImageConstant.imgImage,
                            //fit: BoxFit.cover,
                          )),
                      Opacity(
                        opacity: 0.21,
                        child: ClipPath(
                          clipper: WaveCliper(),
                          child: Container(
                            color: const Color(0xff028A81),
                            height: fullHeight * 0.6 - 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    getTranslated('Welcome_to_mz5an', context)!,
                    style: onBoardtitle.copyWith(fontSize: height(24)),
                  ),
                  const SizedBox(height: 2),
                  Center(
                    child: Image.asset(
                      Provider.of<ThemeProvider>(context).darkTheme
                          ? Images.logoImageDark
                          : Images.logoImage,
                      fit: BoxFit.fill,
                      width: width(110),
                      height: height(63),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: height(50),
                    margin: const EdgeInsets.symmetric(horizontal: 70),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: prmColor),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const AuthScreen()));
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(getTranslated('sign_in', context)!,
                            style: titilliumSemiBold.copyWith(
                                color: Colors.white, fontSize: height(18))),
                      ),
                    ),
                  ),
                  SizedBox(height: height(10)),
                  Container(
                    height: height(50),
                    margin: const EdgeInsets.symmetric(horizontal: 70),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: prmColor),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const AuthScreen()));
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(getTranslated('sign_up', context)!,
                            style: titilliumSemiBold.copyWith(
                                color: Colors.white, fontSize: height(18))),
                      ),
                    ),
                  ),
                  SizedBox(height: height(10)),
                  Consumer<AuthProvider>(builder: (context, authProvider, _) {
                    return GestureDetector(
                      onTap: () {
                        if (kDebugMode) {
                          print(
                              "===Guest ID===${authProvider.getGuestToken()}====>");
                        }
                        if (!authProvider.isLoading) {
                          Provider.of<AuthProvider>(context, listen: false)
                              .getGuestIdUrl();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const DashBoardScreen()),
                              (route) => false);
                        }
                      },
                      child: Container(
                        height: height(50),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 70,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: prmColor),
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(getTranslated('continu_as_gust', context)!,
                            style: titilliumSemiBold.copyWith(
                                color: Colors.white, fontSize: height(18))),
                      ),
                    );
                  }),
                  const SizedBox(height: 12),
                ],
              ),
            )),
      ],
    ));
  }
}
