import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motorvelox/mobile/widgets/toast.dart';
import 'package:motorvelox/service/constant.dart';
import 'package:provider/provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_video_preview/cached_video_preview.dart';

import '../../../state/ui_manager.dart';

class VideoHolder extends StatefulWidget {
  final String file;
  const VideoHolder({super.key, required this.file});

  @override
  State<VideoHolder> createState() => _VideoHolderState();
}

class _VideoHolderState extends State<VideoHolder> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

    String? thumbnail = "";

  // getThumbnail() async {
  //   try {
  //     final fileName = await VideoThumbnail.thumbnailFile(
  //       video: widget.file,
  //       thumbnailPath: (await getTemporaryDirectory()).path,
  //       imageFormat: ImageFormat.JPEG,
  //       maxHeight:
  //           64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
  //       quality: 75,
  //     ).whenComplete(() => log(" thumbnail generated"));

  //     log(fileName.toString());
  //     setState(() {
  //       thumbnail = fileName;
  //     });
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }


  @override
  void initState() {
    super.initState();
    // getThumbnail();

    _controller = VideoPlayerController.network(
      widget.file,
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize().whenComplete(() {
      _controller.play();
      setState(() {});
    });

    // Use the controller to loop the video.
    _controller.setLooping(false);
  }

  bool isPaused = false;

  Future<void> innit() async {}

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }
  
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
        var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    UiProvider tabs = context.watch<UiProvider>();
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
            bool isPaused = false;
        // If the VideoPlayerController has finished initialization, use
        // the data it provides to limit the aspect ratio of the video.
         try {
          if (isTapped == false) {
            if (tabs.index != 0 && _controller.value.isInitialized) {
              // _controller.pause();

              // isPaused = true;
            } else if (tabs.index == 0 && _controller.value.isInitialized) {
              _controller.play();

              isPaused = false;
            }
          }
        } catch (e) {
          log(e.toString());
        }

        return Stack(
          alignment: Alignment.center,
          children: [
           Container(
                    height: height,
                    width: width,
             
                  ),
                
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            ),
            InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                if (_controller.value.isInitialized == false) {
                  return;
                }
                if (isTapped) {
                  setState(() {
                    isTapped = false;
                  });
                } else {
                  setState(() {
                    isTapped = true;
                  });
                }
                if (_controller.value.isPlaying) {
                  _controller.pause();

                  isPaused = true;
                } else {
                  _controller.play();

                  isPaused = false;
                }
              },
              child: Container(
                //  color: Colors.amber,
                width: 300,
                height: MediaQuery.of(context).size.height * 0.7,
                child: isTapped
                    ? Icon(
                        Icons.play_arrow,
                        size: 30,
                        color: Colors.white.withOpacity(0.6),
                      )
                    : const SizedBox.shrink(),
              ),
            )
          ],
        );
      },
    );
  }

   @override
  void didChangeDependencies() {
  
    _controller.pause();
    super.didChangeDependencies();
  }


}
