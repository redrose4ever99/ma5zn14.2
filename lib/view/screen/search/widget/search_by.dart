import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/search_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/fashion_theme_banner.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/search/widget/partial_matched.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/search/widget/searchby_product_widget.dart';
import 'package:provider/provider.dart';

class SearchByScreen extends StatefulWidget {
  const SearchByScreen({Key? key}) : super(key: key);

  @override
  State<SearchByScreen> createState() => _SearchByScreen();
}

class _SearchByScreen extends State<SearchByScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    Provider.of<SearchProvider>(context, listen: false).cleanSearchProduct();
    Provider.of<SearchProvider>(context, listen: false).initHistoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated('shop_by_category', context),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 5),
                  child: FashionBannersView(),
                ),
                Visibility(
                  visible: false,
                  child: Container(
                      padding: const EdgeInsets.only(
                          top: Dimensions.paddingSizeSmall),
                      decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            )
                          ]),
                      child: const SearchSuggestion()),
                ),
                const SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
                Consumer<SearchProvider>(
                  builder: (context, searchProvider, child) {
                    return const SearchByProductWidget();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
