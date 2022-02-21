import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(
        'https://cdn.videvo.net/videvo_files/video/premium/video0238/large_watermarked/06_day_part_II_729_wide_lednik_preview.mp4')
      ..addListener(() => setState(() {}))
      ..initialize().then((_) {
        controller.play();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: PageView(
      //   onPageChanged: (num) {
      //     print("Número da página atual : " + num.toString());
      //   },
      //   scrollDirection: Axis.vertical,
      //   children: <Widget>[
      //     Image.network('https://picsum.photos/250?image=9'),
      //     Image.network('https://picsum.photos/250?image=1'),
      //   ],
      // ),
      body: controller.value.isInitialized
          ? FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
