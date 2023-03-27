import 'package:flutter/material.dart';
import 'package:motorvelox/mobile/screens/sections/feed_section.dart';
import 'package:motorvelox/mobile/screens/sections/service_section.dart';
import 'package:motorvelox/state/ui_manager.dart';

import '../profile.dart';

class TabletLayout extends StatefulWidget {
  const TabletLayout({super.key});

  @override
  State<TabletLayout> createState() => _TabletLayoutState();
}

class _TabletLayoutState extends State<TabletLayout> {
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
            flex: 3,
            child: ServiceSection(),
          ),
           Expanded(
            flex: 4,
            child: FeedSection(),
          ),
       
        ],
      ),
    );
  }
}
