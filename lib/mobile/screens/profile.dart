import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:motorvelox/designParams/params.dart';
import 'package:motorvelox/mobile/screens/no_history.dart';
import 'package:motorvelox/mobile/widgets/delete_modal.dart';
import 'package:motorvelox/responsive/responsive_config.dart';
import 'package:motorvelox/service/constant.dart';
import 'package:motorvelox/service/controller.dart';
import 'package:motorvelox/state/ui_manager.dart';

import '../../allNavigation.dart';
import '../admin/admin_fuel_orders.dart';
import '../admin/users_that_ordered.dart';
import '../widgets/clock.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        UiProvider provide = Provider.of<UiProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 30),

            // const SizedBox(height: 60),
            Card(
              elevation: 10,
              color: Color(0xFF191923),
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 12),
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: AlignmentDirectional.topCenter,
                        fit: StackFit.loose,
                        children: <Widget>[
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: Color(0xFF191923),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                          ),
                          Positioned(
                            top: -60,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: context
                                      .watch<UiProvider>()
                                      .imageUrl
                                      .isEmpty
                                  ? const AssetImage('assets/images/avatar.png')
                                      as ImageProvider
                                  : CachedNetworkImageProvider(
                                      context.watch<UiProvider>().imageUrl),
                            ),
                          )
                        ],
                      ),
                      context.watch<UiProvider>().isLoading
                          ? const CupertinoActivityIndicator(
                              radius: 30,
                              color: kPrimaryColor,
                            )
                          : InkWell(
                              onTap: () {
                                Utility.pickProfileImage(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  'Tap to change',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Raleway',
                                      color: Color(0xFF5956E9),
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                      Text(
                        context.watch<UiProvider>().name,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // const Icon(Icons.location_on_outlined),
                          // const SizedBox(
                          //   width: 10,
                          // ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: [
                                  const Text(
                                    'Address: ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: Responsive.isDesktop(context)
                                        ? null
                                        : MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      context.watch<UiProvider>().address ==
                                              'null'
                                          ? 'Your address added'
                                          : context.watch<UiProvider>().address,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: Responsive.isDesktop(context)
                                    ? null
                                    : MediaQuery.of(context).size.width / 1.5,
                                child: Text(
                                  context.watch<UiProvider>().phoneNumber ==
                                          'null'
                                      ? 'No Phone'
                                      : context.watch<UiProvider>().phoneNumber,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                width: Responsive.isDesktop(context)
                                    ? null
                                    : MediaQuery.of(context).size.width / 1.5,
                                child: Text(
                                  context.watch<UiProvider>().email == 'null'
                                      ? 'No Email'
                                      : context.watch<UiProvider>().email,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ]),
              ),
            ),
            ProfileOption(
                text: 'Edit Profile',
                onClick: () {
             
     provide.changeIndex(1);
                  Modals.editProfileInfo(context);
                }),
            ProfileOption(
                text: 'Address',
                onClick: () {
                       provide.changeIndex(1);
                  Modals.shipping(context);
                }),
            ProfileOption(
                text: 'history',
                onClick: () {
                       provide.changeIndex(1);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DoneDeals()));
                }),
          provide.hasShop ?   ProfileOption(
                text: 'Admin-Orders',
                onClick: () {
                       provide.changeIndex(1);
                    PageRouting.pushToPage(
                                context, const AdminOrderPage());
                  //  Modals.cards(context);
                }) :  SizedBox.shrink(),
            ProfileOption(
                text: 'Logout',
                onClick: () {
                       provide.changeIndex(1);
                   Modals.logOutOption(context);
                }),
            // ProfileOption(
            //     text: 'Notifications',
            //     onClick: () {
            //       Modals.notification(context);
            //     }),
          ],
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final VoidCallback? onClick;
  final String text;
  ProfileOption({
    Key? key,
    this.onClick,
    this.text = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF191923),
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 13),
      child: ListTile(
        // contentPadding: EdgeInsets.all(10),

        title: Text(
          text,
          style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        onTap: onClick,
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        tileColor: Color(0xFF191923),
      ),
    );
  }
}

class MobileProfile extends StatefulWidget {
  const MobileProfile({super.key});

  @override
  State<MobileProfile> createState() => _MobileProfileState();
}

class _MobileProfileState extends State<MobileProfile> {
  @override
  Widget build(BuildContext context) {
    UiProvider provide = Provider.of<UiProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0.1,
        title: const Text(
          "MotorVelox",
          style: TextStyle(
              fontFamily: 'Raleway',
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.w700),
        ),
        // leading: IconButton(
        //     onPressed: () {
        //       AppDrawer.of(context)?.toggle();
        //     },
        //     icon: const Icon(Icons.segment, color: Colors.white, size: 30)),
        actions: [Clock()],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 50),

              // const SizedBox(height: 60),
              Card(
                elevation: 10,
                color: Color(0xFF191923),
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 12),
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: AlignmentDirectional.topCenter,
                          fit: StackFit.loose,
                          children: <Widget>[
                            Container(
                              height: 60,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Color(0xFF191923),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                            ),
                            Positioned(
                              top: -60,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: context
                                        .watch<UiProvider>()
                                        .imageUrl
                                        .isEmpty
                                    ? const AssetImage(
                                            'assets/images/avatar.png')
                                        as ImageProvider
                                    : CachedNetworkImageProvider(
                                        context.watch<UiProvider>().imageUrl),
                              ),
                            )
                          ],
                        ),
                        context.watch<UiProvider>().isLoading
                            ? const CupertinoActivityIndicator(
                                radius: 30,
                                color: kPrimaryColor,
                              )
                            : InkWell(
                                onTap: () {
                                  Utility.pickProfileImage(context);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    'Tap to change',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: 'Raleway',
                                        color: Color(0xFF5956E9),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                        Text(
                          context.watch<UiProvider>().name,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // const Icon(Icons.location_on_outlined),
                            // const SizedBox(
                            //   width: 10,
                            // ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: Responsive.isDesktop(context)
                                      ? null
                                      : MediaQuery.of(context).size.width / 1.5,
                                  child: Text(
                                    context.watch<UiProvider>().address ==
                                            'null'
                                        ? 'No address added'
                                        : "Address:  ${context.watch<UiProvider>().address}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  width: Responsive.isDesktop(context)
                                      ? null
                                      : MediaQuery.of(context).size.width / 1.5,
                                  child: Text(
                                    context.watch<UiProvider>().phoneNumber ==
                                            'null'
                                        ? 'No Phone'
                                        : context
                                            .watch<UiProvider>()
                                            .phoneNumber,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  width: Responsive.isDesktop(context)
                                      ? null
                                      : MediaQuery.of(context).size.width / 1.5,
                                  child: Text(
                                    context.watch<UiProvider>().email == 'null'
                                        ? 'No Email'
                                        : context.watch<UiProvider>().email,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ]),
                ),
              ),
              ProfileOption(
                  text: 'Edit Profile',
                  onClick: () {
                    Modals.editProfileInfo(context);
                  }),
              ProfileOption(
                  text: 'Address',
                  onClick: () {
                    Modals.shipping(context);
                  }),
              ProfileOption(
                  text: 'history',
                  onClick: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DoneDeals()));
                  }),
            provide.hasShop ?  ProfileOption(
                  text: 'Admin-Orders',
                  onClick: () {
                         PageRouting.pushToPage(
                                context, const AdminOrderPage());
                  }) : SizedBox.shrink(),
              ProfileOption(
                  text: 'Logout',
                  onClick: () {
                     Modals.logOutOption(context);
                  }),
              // ProfileOption(
              //     text: 'Notifications',
              //     onClick: () {
              //       Modals.notification(context);
              //     }),
            ],
          ),
        ),
      ),
    );
  }
}
