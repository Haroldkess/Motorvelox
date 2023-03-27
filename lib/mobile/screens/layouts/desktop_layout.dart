import 'package:flutter/material.dart';
import 'package:motorvelox/mobile/screens/sections/feed_section.dart';
import 'package:motorvelox/mobile/screens/sections/service_section.dart';
import 'package:motorvelox/state/ui_manager.dart';

import '../profile.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      height: height,
      child: Row(
        children: const [
           Expanded(
            flex: 2,
            child: ServiceSection(),
          ),
           Expanded(
            flex: 3,
            child: FeedSection(),
          ),
           Expanded(flex: 2, child: Profile()),
        ],
      ),
    );
  }
}
