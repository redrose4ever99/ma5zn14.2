import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';

class ShopCatWidgetHomePage extends StatelessWidget {
  const ShopCatWidgetHomePage({super.key});

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
              right: Dimensions.homePagePadding),
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
            Image.asset(
              Images.dropdn,
              color: Theme.of(context).primaryColor,
              width: 10,
              height: 7,
            ),
            const SizedBox(width: 5),
            Text(getTranslated('shop_by_category', context) ?? '',
                style: textRegular.copyWith(
                    color: Theme.of(context).primaryColor)),
          ]),
        ),
      ),
    );
  }
}



//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: Dimensions.homePagePadding),
//       child: Container(
//         height: 100,
//         padding: const EdgeInsets.only(
//             left: Dimensions.homePagePadding,
//             right: Dimensions.homePagePadding),
//         decoration: BoxDecoration(
//           color: Theme.of(context).cardColor,
//           borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
//         ),
//         child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
//           Padding(
//             padding: const EdgeInsets.all(4),
//             child: SizedBox(
//               width: 20,
//               height: 20,
//               child: Image.asset(
//                 Images.dropdn,
//                 color: Theme.of(context).primaryColor,
//                 width: 13.14,
//                 height: 8.58,
//               ),
//             ),
//           ),
//           Text(getTranslated('shop_by_category', context) ?? '',
//               style: textRegular.copyWith(
//                   color: Theme.of(context).hintColor, fontSize: 12)),
//         ]),
//       ),
//     );
//   }
// }// Text(getTranslated('shop_by_category', context) ?? '',



