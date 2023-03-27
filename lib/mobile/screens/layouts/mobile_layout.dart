import 'package:flutter/material.dart';
import 'package:motorvelox/mobile/screens/homescreen.dart';
import 'package:motorvelox/mobile/screens/sections/feed_section.dart';
import 'package:motorvelox/mobile/screens/sections/service_section.dart';
import 'package:motorvelox/state/ui_manager.dart';

import '../profile.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Home();
  }
}
