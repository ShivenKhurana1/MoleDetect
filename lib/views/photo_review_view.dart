import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:MoleDetect/constants/constants.dart';
import 'package:MoleDetect/views/results_view.dart';
import 'package:super_bullet_list/bullet_list.dart';

class PhotoReviewView extends StatefulWidget {
  final XFile image;
  const PhotoReviewView({super.key, required this.image});

  @override
  PhotoReviewViewState createState() => PhotoReviewViewState();
}

class PhotoReviewViewState extends State<PhotoReviewView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Images.logo,
      ),
      body: _buildView(),
    );
  }

  // Builds the main view with the image, buttons etc
  Widget _buildView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20),
          child: AspectRatio(
              aspectRatio: 1, // Set aspect ratio to 1:1 for a square
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                clipBehavior: Clip.hardEdge,
                child: Image.file(
                  File(widget.image.path),
                  fit: BoxFit.cover,
                ),
              )),
        ),
        _buildBottomBlock()
      ],
    );
  }

  Widget _buildBottomBlock() {
    return Expanded(
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30),
          decoration: const BoxDecoration(
              //borderRadius: BorderRadius.circular(10),
              color: Color(0xFF1e1f25)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [_buildTips(), Spacer(), _buildButtons()],
          ),
        ),
      ),
    );
  }

  Widget _buildTips() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Review photo before submission',
                textAlign: TextAlign.left,
                style: TextStyles.smallHeadline,
              )),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Tips for best results:',
                  textAlign: TextAlign.left, style: TextStyles.largeBody),
            )),
        const SizedBox(height: 20),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: SuperBulletList(
              separator: SizedBox(height: 5),
              items: [
                Text('Is taken in a well-lit room',
                    style: TextStyles.largeBody),
                Text('Mole is fully visible in the frame',
                    style: TextStyles.largeBody),
                Text('No objects are obstructing the view (jewelry, hair, etc)',
                    style: TextStyles.largeBody),
              ],
            )),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildButtons() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Retake')),
            FilledButton(
                onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        settings: const RouteSettings(name: 'resultsView'),
                        builder: (context) => ResultsView(
                          image: widget.image,
                        ),
                      ),
                    ),
                child: const Text('Use Photo'))
          ],
        ),
      ),
    );
  }
}
