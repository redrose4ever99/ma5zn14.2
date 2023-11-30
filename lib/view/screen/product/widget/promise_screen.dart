import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/utill/sizr.dart';

class PromiseScreen extends StatelessWidget {
  const PromiseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color background1 = Theme.of(context).scaffoldBackgroundColor;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                    width: width(61),
                    height: width(61),
                    decoration: BoxDecoration(
                        color: background1,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                        child: Image.asset(
                      Images.rialableDelivery,
                      width: 26,
                      height: 18,
                    ))),
                Padding(
                  padding:
                      const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                  child: Text(
                    getTranslated('Reliable_shipping', context)!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: textRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: Dimensions.paddingSizeDefault,
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  width: width(61),
                  height: width(61),
                  decoration: BoxDecoration(
                      color: background1,
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                      child: Image.asset(
                    Images.safePayment,
                    width: 26,
                    height: 19,
                  )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                  child: Text(getTranslated('payment_on_resive', context)!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: textRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall)),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: Dimensions.paddingSizeDefault,
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  width: width(61),
                  height: width(61),
                  decoration: BoxDecoration(
                      color: background1,
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                      child: Image.asset(
                    Images.saveShop,
                    width: 26,
                    height: 19,
                  )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                  child: Text(getTranslated('Safe_shopping', context)!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: textRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall)),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: Dimensions.paddingSizeDefault,
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  width: width(61),
                  height: width(61),
                  decoration: BoxDecoration(
                      color: background1,
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                      child: Image.asset(
                    Images.freeReturn,
                    width: 26,
                    height: 19,
                  )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                  child: Text(getTranslated('Free_returns', context)!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: textRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
