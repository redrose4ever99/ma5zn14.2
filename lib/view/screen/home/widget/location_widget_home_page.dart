import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/address/saved_address_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';

import 'package:provider/provider.dart';

class LocationWidgetHomePage extends StatelessWidget {
  const LocationWidgetHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, orderProvider, _) {
      return Consumer<ProfileProvider>(builder: (context, profileProvider, _) {
        return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const SavedAddressListScreen()));
            },
            icon: Icon(Icons.location_pin,
                color: Theme.of(context).primaryColor.withOpacity(.8),
                size: 25),
          ),
          (Provider.of<OrderProvider>(context, listen: false).addressIndex ==
                      null ||
                  Provider.of<ProfileProvider>(context, listen: false)
                      .addressList
                      .isEmpty)
              ? Text(getTranslated('add_your_address', context) ?? '',
                  style: textRegular.copyWith(
                      color: Theme.of(context).hintColor, fontSize: 14))
              : Text(
                  Provider.of<ProfileProvider>(context, listen: false)
                      .addressList[
                          Provider.of<OrderProvider>(context, listen: false)
                              .addressIndex!]
                      .address!,
                  style: textRegular.copyWith(
                      color: Theme.of(context).hintColor, fontSize: 14)),
        ]);
      });
    });
  }
}
