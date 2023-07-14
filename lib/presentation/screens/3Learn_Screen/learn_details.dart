import 'package:course_app/models/3Learn/3LearnModel.dart';
import 'package:course_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Learn_Details extends StatelessWidget {
  Learn_Details({super.key, required this.learnModel});
  final LearnModel learnModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(learnModel.LearnName.toString()),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: learnModel.LearnType == "Video"
                ? Container(
                    alignment: Alignment.center,
                    color: const Color.fromARGB(255, 51, 50, 43),
                    // width: MediaQuery.of(context).size.width,
                    width: 200,
                    height: 200,
                    child: YoutubePlayer(
                      controller: YoutubePlayerController(
                        initialVideoId: 'YPOiNF0riyA',
                        flags: YoutubePlayerFlags(
                          mute: false,
                          autoPlay: true,
                          disableDragSeek: false,
                          loop: false,
                          isLive: false,
                          forceHD: false,
                          enableCaption: true,
                        ),
                      ),
                      showVideoProgressIndicator: true,
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.red,
                    child: SfPdfViewer.network(
                      "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf",
                    ),
                  ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              height: 100,
              child: Container(
                width: 150,
                margin: EdgeInsets.only(top: 6, bottom: 6, left: 28, right: 28),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(52),
                ),
                child: MaterialButton(
                  // minWidth: 150,
                  height: 60,
                  onPressed: () {},
                  child: Text(
                    "Start Quiz ".toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// https://youtu.be/YPOiNF0riyA