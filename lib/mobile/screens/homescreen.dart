import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:motorvelox/mobile/screens/layouts/tablet_layout.dart';
import 'package:motorvelox/mobile/screens/sections/feed_section.dart';
import 'package:motorvelox/mobile/screens/sections/service_section.dart';
import 'package:motorvelox/mobile/widgets/clock.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack_client/flutter_paystack_client.dart';
import 'package:motorvelox/designParams/params.dart';
import 'package:motorvelox/mobile/screens/layouts/desktop_layout.dart';
import 'package:motorvelox/responsive/responsive_config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:motorvelox/mobile/screens/profile.dart';
import 'package:motorvelox/mobile/screens/searchscreen.dart';
import 'package:motorvelox/models/user_model.dart';
import 'package:motorvelox/service/constant.dart';
import 'package:motorvelox/service/database_service.dart';
import 'package:motorvelox/state/ui_manager.dart';

import '../../service/controller.dart';
import '../widgets/drawer.dart';
import 'cart.dart';
import 'iniciopage.dart';
import 'layouts/mobile_layout.dart';
import 'no_favorites.dart';
import 'no_history.dart';

class Home extends StatefulWidget {
  @override
  State createState() {
    return _HomeState();
  }
}

class _HomeState extends State {
  String? userName = '';

  bool? showMesssage = true;
  @override
  void initState() {
    super.initState();
    showMessage();
    // Controls.getHomeProduct(context);
    // Controls.getHomeProduct(context);
    // Controls.getQuickPicksProduct(context);
    // Controls.getSliderProduct(context);
    // Controls.getPopularProduct(context);
    // Controls.getJustForYouProduct(context);
    // Controls.getCategory(context);
    // Controls.cartCollectionControl(context);

    // saveInfo(context);
  }

  showMessage() async {
    await Future.delayed(Duration(seconds: 5)).whenComplete(() {
      setState(() {
        showMesssage = false;
      });
    });
  }

  Future<void> saveInfo(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    UserModel user = await DatabaseService.getUserWithId();

    await pref.setStringList(notificationKey, ['Welcome to shop you']);

    await pref.setString(userIdKey, user.id!);
    await pref.setString(nameKey, user.name!);

    await pref.setString(emailKey, user.email!);

    await pref.setString(
        dpKey,
        user.profileImageUrl == null || user.profileImageUrl!.isEmpty
            ? "null"
            : user.profileImageUrl!);
    await pref.setString(
        addressKey,
        user.userLocation == null || user.userLocation!.isEmpty
            ? "null"
            : user.userLocation!);
    await pref.setBool(
        hasShopKey, user.hasShop == null ? false : user.hasShop!);
    await pref.setString(countryKey,
        user.country == null || user.country!.isEmpty ? "null" : user.country!);
    await pref.setString(stateKey,
        user.state == null || user.state!.isEmpty ? "null" : user.state!);
    await pref.setString(
        phoneKey,
        user.phoneNumber == null || user.phoneNumber!.isEmpty
            ? "null"
            : user.phoneNumber!);
    await Provider.of<UiProvider>(context, listen: false)
        .addUserName(pref.getString(nameKey)!);
    await Provider.of<UiProvider>(context, listen: false)
        .addAdress(pref.getString(addressKey)!);
    await Provider.of<UiProvider>(context, listen: false)
        .addPhone(pref.getString(phoneKey)!);
    print('done getting some user info');
  }



  List _children = [
    ServiceSection(),
    ServiceSection(),
    ServiceSection(),
    ServiceSection(),
  ];

  String? url;
  _launchInWebViewOrVC(String urlLink) async {
    url = urlLink;

    if (await canLaunch(url!)) {
      await launch(
        url!,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    UiProvider provide = Provider.of<UiProvider>(context, listen: false);
    UiProvider stream = context.watch<UiProvider>();
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        alignment: Alignment.center,
        children: [
          _children[stream.index],
          (Responsive.isMobile(context) || Responsive.isMobileLarge(context)) &&
                  showMesssage!
              ? Positioned(
                  bottom: 40,
                  child: FadeInUp(
                    animate: true,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(1000, 300),
                          bottomRight: Radius.elliptical(1000, 300),
                        ),
                      ),
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Chat with experts here !",
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  color: background,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Icon(Icons.arrow_downward_outlined)
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        onTap: onTabTapped,
        currentIndex: stream.index,
        selectedItemColor: Color.fromRGBO(89, 86, 233, 1),
        iconSize: 30,
        elevation: 0.9,
        backgroundColor: background,
        
        items: [
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.grey,
              ),
              label: 'Home',
              activeIcon: Icon(
                Icons.home,
                color: Color(0xff5956E9),
              )),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.handyman_outlined,
                color: Colors.grey,
              ),
              backgroundColor: Color(0xfff2f2f2),
              label: 'Feed',
              activeIcon: Icon(
                Icons.favorite,
                color: Color(0xff5956E9),
              )),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                color: Colors.grey,
              ),
              backgroundColor: Color(0xfff2f2f2),
              label: 'Profile',
              activeIcon: Icon(
                Icons.person,
                color: Color(0xff5956E9),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
                color: context.watch<UiProvider>().doneDeals.isNotEmpty
                    ? Colors.red
                    : Colors.grey,
              ),
              backgroundColor: const Color(0xff5956E9),
              label:
                  'Deals ${context.watch<UiProvider>().doneDeals.length.toString()}',
              activeIcon: Icon(
                Icons.history,
                color: context.watch<UiProvider>().doneDeals.isNotEmpty
                    ? Colors.red
                    : Colors.grey,
              )),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        isExtended: true,
        onPressed: () {
          _launchInWebViewOrVC(
              "https://wa.me/+2348104544917/?text=Hello there. i want to make some enquiry from motorvelox");
        },
        child: Image.asset(
          'assets/images/avatar.png',
          height: 50,
          width: 50,
          fit: BoxFit.contain,
          //color: Colors.white,
        ),
      ),
    );
  }

  void onTabTapped(int index) {
      UiProvider provide = Provider.of<UiProvider>(context, listen: false);
     provide.changeIndex(index);
    Widget page = Home();
    switch (index) {
      case 1:
        page = MobileFeed();
        break;
      case 2:
        page = MobileProfile();
        break;
      case 3:
        page = DoneDeals();
        break;
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
    // setState(() {
    //   _currentIndex = index;
    //   print(index);
    // });
  }
}

class TabHome extends StatefulWidget {
  const TabHome({super.key});

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  String key = '';

  String? url;
  @override
  void initState() {
    super.initState();
    getKey();
    getServices();
  }

  Future<void> getServices() async {
    await DatabaseService.getServices(context);
    // ignore: use_build_context_synchronously
    await DatabaseService.getFeed(context);
  }

  Future<void> getKey() async {
    await FirebaseFirestore.instance
        .collection("controls")
        .doc('oneGod1997')
        .get()
        .then((value) {
      String _key = value.data()!["key"];
      setState(() {
        key = _key;
      });
    });

    await PaystackClient.initialize(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0.1,
        title: Responsive.isMobile(context) || Responsive.isMobileLarge(context)
            ? const Text(
                "MotorVelox",
                style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700),
              )
            : Image.asset(
                'assets/images/velox.png',
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
        // leading: IconButton(
        //     onPressed: () {
        //       AppDrawer.of(context)?.toggle();
        //     },
        //     icon: const Icon(Icons.segment, color: Colors.white, size: 30)),
        actions: [Clock()],
      ),
      body: const Responsive(
        mobile: MobileLayout(),
        desktop: DesktopLayout(),
        tablet: TabletLayout(),
      ),
      floatingActionButton:
          Responsive.isMobile(context) || Responsive.isMobileLarge(context)
              ? null
              : FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    _launchInWebViewOrVC(
                        "https://wa.me/+2348104544917/?text=Hello there. i want to make some enquiry from motorvelox");
                  },
                  child: Image.asset(
                    'assets/images/su3.png',
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                  ),
                ),
    );
  }

  _launchInWebViewOrVC(String urlLink) async {
    url = urlLink;

    if (await canLaunch(url!)) {
      await launch(
        url!,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
