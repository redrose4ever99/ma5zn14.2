import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/network_info.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_exit_card.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/category/all_category_screen.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/aster_theme_home_page.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/fashion_theme_home_page.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/home_screens.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/more/more_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/notification/notification_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/order_screen.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  DashBoardScreenState createState() => DashBoardScreenState();
}

class DashBoardScreenState extends State<DashBoardScreen> {
  int _pageIndex = 2;
  late List<NavigationModel> _screens;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  final PageStorageBucket bucket = PageStorageBucket();

  bool singleVendor = false;
  @override
  void initState() {
    super.initState();
    singleVendor = Provider.of<SplashProvider>(context, listen: false)
            .configModel!
            .businessMode ==
        "single";

    _screens = [
      NavigationModel(
          name: 'orders',
          icon: Images.shoppingImage,
          screen: const OrderScreen(isBacButtonExist: false)),
      NavigationModel(
          name: 'notification',
          icon: Images.notification,
          screen: const NotificationScreen()),
      NavigationModel(
          name: 'home',
          icon: Images.homeImage,
          screen: (Provider.of<SplashProvider>(context, listen: false)
                      .configModel!
                      .activeTheme ==
                  "default")
              ? const HomePage()
              : (Provider.of<SplashProvider>(context, listen: false)
                          .configModel!
                          .activeTheme ==
                      "theme_aster")
                  ? const AsterThemeHomePage()
                  : const FashionThemeHomePage()),
      NavigationModel(
          name: 'all_category',
          icon: Images.category,
          screen: const AllCategoryScreen()),
      NavigationModel(
          name: 'more', icon: Images.moreImage, screen: const MoreScreen()),
    ];

    NetworkInfo.checkConnectivity(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (_pageIndex != 0) {
            _setPage(0);
            return false;
          } else {
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (_) => const CustomExitCard());
          }
          return false;
        },
        child: Scaffold(
          key: _scaffoldKey,
          body: PageStorage(bucket: bucket, child: _screens[_pageIndex].screen),
          bottomNavigationBar: CurvedNavigationBar(
              buttonBackgroundColor: Theme.of(context).primaryColor,
              color: Theme.of(context).scaffoldBackgroundColor,
              // animationCurve: Curves.easeInOut,
              backgroundColor: Colors.transparent,
              animationDuration: const Duration(milliseconds: 400),
              index: _pageIndex,
              items: _getBottomWidget(singleVendor)

              /*
          
                bottomNavigationBar: Container(
          height: 65,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(Dimensions.paddingSizeLarge)),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(1, 1),
                  blurRadius: 2,
                  spreadRadius: 1,
                  color: Theme.of(context).primaryColor.withOpacity(.125))
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _getBottomWidget(singleVendor),
          ),
                ),*/
              ),
        ));
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageIndex = pageIndex;
    });
  }

  List<Widget> _getBottomWidget(bool isSingleVendor) {
    List<Widget> list = [];
    for (int index = 0; index < _screens.length; index++) {
      list.add(CustomMenuItem(
        isSelected: _pageIndex == index,
        name: _screens[index].name,
        icon: _screens[index].icon,
        onTap: () => _setPage(index),
      ));
    }
    return list;
  }
}

class CustomMenuItem extends StatelessWidget {
  final bool isSelected;
  final String name;
  final String icon;
  final VoidCallback onTap;

  const CustomMenuItem({
    Key? key,
    required this.isSelected,
    required this.name,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Theme.of(context).primaryColor,
      hoverColor: Theme.of(context).primaryColor,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: SizedBox(
            width: isSelected ? 90 : 50,
            child: Center(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      icon,
                      color: (isSelected)
                          ? Theme.of(context).scaffoldBackgroundColor
                          : Theme.of(context).primaryColor,
                      width: (isSelected)
                          ? Dimensions.menuIconSize + 7
                          : Dimensions.menuIconSize,
                      height: (isSelected)
                          ? Dimensions.menuIconSize + 7
                          : Dimensions.menuIconSize,
                    ),
                    if (!isSelected)
                      Text(getTranslated(name, context)!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textRegular.copyWith(
                            fontSize: 13,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                          )),
                    if (isSelected)
                      Container(
                        width: 5,
                        height: 3,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(
                                Dimensions.paddingSizeDefault)),
                      )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class NavigationModel {
  String name;
  String icon;
  Widget screen;
  NavigationModel(
      {required this.name, required this.icon, required this.screen});
}
