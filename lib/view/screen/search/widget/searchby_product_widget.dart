import 'package:flutter_sixvalley_ecommerce/helper/product_type.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/banner_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_filter_custom_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/spener.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/footer_banner.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/products_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/search_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/paginated_list_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/search/widget/search_filter_bottom_sheet.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class SearchByProductWidget extends StatefulWidget {
  const SearchByProductWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchByProductWidget> createState() => _SearchByProductWidget();
}

class _SearchByProductWidget extends State<SearchByProductWidget> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    //bool isDark = Provider.of<ThemeProvider>(context, listen: false).darkTheme;
    List<String?> types = [
      getTranslated('new_arrival', context),
      getTranslated('top_product', context),
      getTranslated('best_selling', context),
      getTranslated('discounted_product', context)
    ];
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      child: Consumer<SearchProvider>(
          builder: (context, searchProductProvider, _) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (c) => const SearchFilterBottomSheet()),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: Dimensions.paddingSizeExtraSmall,
                              horizontal: Dimensions.paddingSizeExtraSmall),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(.25))),
                          child: Row(
                            children: [
                              const Text(
                                "ترتيب",
                                style: onBoardtitle,
                              ),
                              SizedBox(
                                  width: 30,
                                  height: 29,
                                  child: Image.asset(Images.sort,
                                      color: Provider.of<ThemeProvider>(context,
                                                  listen: false)
                                              .darkTheme
                                          ? Colors.white
                                          : Theme.of(context).primaryColor)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: Dimensions.paddingSizeDefault,
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (c) => const ProductFilterCustomDialog(
                                    fromShop: false,
                                  ));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: Dimensions.paddingSizeExtraSmall,
                              horizontal: Dimensions.paddingSizeExtraSmall),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(.25))),
                          child: Row(
                            children: [
                              const Text("تصفية", style: onBoardtitle),
                              SizedBox(
                                  width: 30,
                                  height: 29,
                                  child: Image.asset(Images.dropdown,
                                      color: Provider.of<ThemeProvider>(context,
                                                  listen: false)
                                              .darkTheme
                                          ? Colors.white
                                          : Theme.of(context).primaryColor)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //

              searchProductProvider.isLoadFilter
                  ? const MySpener()
                  : (!searchProductProvider.isClear)
                      ? SingleChildScrollView(
                          controller: scrollController,
                          child: PaginatedListView(
                              scrollController: scrollController,
                              onPaginate: (offset) async {
                                await searchProductProvider.searchProduct(
                                    query: searchProductProvider
                                        .searchController.text,
                                    offset: offset!);
                              },
                              totalSize: searchProductProvider
                                  .searchedProduct?.totalSize,
                              offset:
                                  searchProductProvider.searchedProduct?.offset,
                              itemView: MasonryGridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(0),
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                itemCount: searchProductProvider
                                    .searchedProduct!.products!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ProductWidget(
                                      productModel: searchProductProvider
                                          .searchedProduct!.products![index]);
                                },
                              )),
                        )
                      : Column(
                          children: [
                            const SizedBox(height: Dimensions.homePagePadding),

                            Consumer<BannerProvider>(builder:
                                (context, footerBannerProvider, child) {
                              return footerBannerProvider.mainSectionBanner !=
                                      null
                                  ? SingleBannersView(
                                      bannerModel: footerBannerProvider
                                          .mainSectionBanner,
                                      height:
                                          MediaQuery.of(context).size.width / 4,
                                    )
                                  : const SizedBox();
                            }),
                            // const SizedBox(height: Dimensions.homePagePadding),

                            //Category filter
                            Consumer<ProductProvider>(
                                builder: (ctx, prodProvider, child) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    Dimensions.paddingSizeDefault,
                                    0,
                                    Dimensions.paddingSizeSmall,
                                    Dimensions.paddingSizeExtraSmall),
                                child: Row(children: [
                                  Expanded(
                                      child: Text(
                                          prodProvider.title == 'xyz'
                                              ? getTranslated(
                                                  'new_arrival', context)!
                                              : prodProvider.title!,
                                          style: titleHeader)),
                                  prodProvider.latestProductList != null
                                      ? PopupMenuButton(
                                          itemBuilder: (context) {
                                            return [
                                              PopupMenuItem(
                                                  value: ProductType.newArrival,
                                                  textStyle:
                                                      textRegular.copyWith(
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                                  child: Text(getTranslated(
                                                      'new_arrival',
                                                      context)!)),
                                              PopupMenuItem(
                                                  value: ProductType.topProduct,
                                                  textStyle:
                                                      textRegular.copyWith(
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                                  child: Text(getTranslated(
                                                      'top_product',
                                                      context)!)),
                                              PopupMenuItem(
                                                  value:
                                                      ProductType.bestSelling,
                                                  textStyle:
                                                      textRegular.copyWith(
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                                  child: Text(getTranslated(
                                                      'best_selling',
                                                      context)!)),
                                              PopupMenuItem(
                                                  value: ProductType
                                                      .discountedProduct,
                                                  textStyle:
                                                      textRegular.copyWith(
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                                  child: Text(getTranslated(
                                                      'discounted_product',
                                                      context)!)),
                                            ];
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions
                                                          .paddingSizeSmall)),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: Dimensions
                                                          .paddingSizeSmall,
                                                      vertical: Dimensions
                                                          .paddingSizeSmall),
                                              child: Image.asset(
                                                  Images.dropdown,
                                                  scale: 3)),
                                          onSelected: (dynamic value) {
                                            if (value ==
                                                ProductType.newArrival) {
                                              Provider.of<ProductProvider>(
                                                      context,
                                                      listen: false)
                                                  .changeTypeOfProduct(
                                                      value, types[0]);
                                            } else if (value ==
                                                ProductType.topProduct) {
                                              Provider.of<ProductProvider>(
                                                      context,
                                                      listen: false)
                                                  .changeTypeOfProduct(
                                                      value, types[1]);
                                            } else if (value ==
                                                ProductType.bestSelling) {
                                              Provider.of<ProductProvider>(
                                                      context,
                                                      listen: false)
                                                  .changeTypeOfProduct(
                                                      value, types[2]);
                                            } else if (value ==
                                                ProductType.discountedProduct) {
                                              Provider.of<ProductProvider>(
                                                      context,
                                                      listen: false)
                                                  .changeTypeOfProduct(
                                                      value, types[3]);
                                            }

                                            ProductView(
                                              isHomePage: false,
                                              productType: value,
                                            );
                                            Provider.of<ProductProvider>(
                                                    context,
                                                    listen: false)
                                                .getLatestProductList(1,
                                                    reload: true);
                                          })
                                      : const SizedBox(),
                                ]),
                              );
                            }),

                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.homePagePadding),
                              child: ProductView(
                                isHomePage: false,
                                productType: ProductType.newArrival,
                              ),
                            ),
                            const SizedBox(height: Dimensions.homePagePadding),
                          ],
                        ),
            ],
          ),
        );
      }),
    );
  }
}
