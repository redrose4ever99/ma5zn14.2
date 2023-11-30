import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';

class SearchWidgetHomePage extends StatelessWidget {
  const SearchWidgetHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeExtraExtraSmall),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.homePagePadding,
            vertical: Dimensions.paddingSizeSmall),
        child: Container(
          padding: const EdgeInsets.only(
              left: Dimensions.homePagePadding,
              right: Dimensions.paddingSizeExtraSmall),
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: Provider.of<ThemeProvider>(context).darkTheme
                ? null
                : [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 0))
                  ],
            borderRadius:
                BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Icon(Icons.search,
                color: Theme.of(context).primaryColor,
                size: Dimensions.iconSizeSmall),
            const SizedBox(width: 4),
            Text(getTranslated('search_hint', context) ?? '',
                style: textRegular.copyWith(
                    color: Theme.of(context).primaryColor)),
          ]),
        ),
      ),
    );
  }
}
