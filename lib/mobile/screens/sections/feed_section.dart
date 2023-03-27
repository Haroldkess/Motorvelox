import 'package:flutter/material.dart';
import 'package:motorvelox/designParams/params.dart';
import 'package:motorvelox/mobile/screens/sections/video_holder.dart';
import 'package:motorvelox/mobile/screens/servicemodel/feed_model.dart';
import 'package:motorvelox/responsive/responsive_config.dart';
import 'package:motorvelox/state/ui_manager.dart';
import 'package:provider/provider.dart';

import '../../widgets/clock.dart';

class FeedSection extends StatefulWidget {
  const FeedSection({super.key});

  @override
  State<FeedSection> createState() => _FeedSectionState();
}

class _FeedSectionState extends State<FeedSection> {
  PageController pageController = PageController();
  int indexer = 0;
  @override
  Widget build(BuildContext context) {
    UiProvider stream = context.watch<UiProvider>();
    UiProvider feedPost = Provider.of<UiProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () async {
                if (indexer > 0) {
                  setState(() {
                    indexer--;
                  });
                  pageController.animateToPage(
                    indexer,
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeIn,
                  );
                }
              },
              icon: const Icon(
                Icons.arrow_upward_outlined,
                color: Colors.white,
              )),
          SizedBox(
            // width: 350,
            height: MediaQuery.of(context).size.height * 0.7,
            child: PageView.builder(
              onPageChanged: (value) => setState(() {
                indexer = value;
              }),
              itemCount: stream.feedModel.length,
              controller: pageController,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                FeedModel feed = feedPost.feedModel[index];
                return Responsive.isMobile(context)
                    ? VideoHolder(
                        file: feed.link!,
                      )
                    : Row(
                        children: [
                          SizedBox(
                            width: 300,
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: VideoHolder(
                              file: feed.link!,
                            ),
                          ),
                          Expanded(
                            //  height: MediaQuery.of(context).size.height * 0.6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    feed.caption!,
                                    style: const TextStyle(
                                        fontFamily: 'Raleway',
                                        color: Colors.grey,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                          AssetImage("images/car2.png"),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      feed.title!,
                                      style: const TextStyle(
                                          fontFamily: 'Raleway',
                                          color: Colors.white,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Icon(
                                      Icons.verified,
                                      color: Colors.blue,
                                      size: 15,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      );
              },
            ),
          ),
          IconButton(
              onPressed: () {
                if (indexer < feedPost.feedModel.length) {
                  setState(() {
                    indexer++;
                  });
                  pageController.animateToPage(
                    indexer,
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeIn,
                  );
                }
              },
              icon: const Icon(
                Icons.arrow_downward_outlined,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}

class MobileFeed extends StatefulWidget {
  const MobileFeed({super.key});

  @override
  State<MobileFeed> createState() => _MobileFeedState();
}

class _MobileFeedState extends State<MobileFeed> {
  PageController pageController = PageController();
  int indexer = 0;
  @override
  Widget build(BuildContext context) {
      UiProvider stream = context.watch<UiProvider>();
    UiProvider feedPost = Provider.of<UiProvider>(context, listen: false);
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
      body: PageView.builder(
        onPageChanged: (value) => setState(() {
          indexer = value;
        }),
        itemCount: stream.feedModel.length,
        controller: pageController,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          FeedModel feed = feedPost.feedModel[index];
          return Stack(
            //alignment: Alignment.center,
            children: [
               VideoHolder(
              file: feed.link!,
            ),
            Positioned(
              bottom: 15.0,
              left: 7,
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                                      children: [
                                        const CircleAvatar(
                                          radius: 20,
                                          backgroundImage:
                                              AssetImage("images/car2.png"),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          feed.title!,
                                          style: const TextStyle(
                                              fontFamily: 'Raleway',
                                              color: Colors.white,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        const Icon(
                                          Icons.verified,
                                          color: Colors.blue,
                                          size: 15,
                                        )
                                      ],
                                    ),
                
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 30),
                      child: Text(
                                      feed.caption!,
                                      style: const TextStyle(
                                          fontFamily: 'Raleway',
                                          color: Colors.grey,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                    ),
                  ),
                ],
              ))

            ],
          );
        },
      ),
    );
  }
}
