import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:MoleDetect/components/results_widget.dart';
import 'package:MoleDetect/constants/constants.dart';
import 'package:MoleDetect/models/diagnosis_model.dart';
import 'package:MoleDetect/services/http_service.dart';

class ResultsView extends StatefulWidget {
  final XFile image;
  const ResultsView({super.key, required this.image});

  @override
  State<ResultsView> createState() => _ResultsViewState();
}

class _ResultsViewState extends State<ResultsView> {
  bool _loading = true;
  Diagnosis? diagnosis;

  @override
  void initState() {
    processImage();
    super.initState();
  }

  // Processes the image by calling the API endpoint to handle the prediction
  Future<void> processImage() async {
    setState(() {
      _loading = true;
    });

    Response response = await HttpService.postImage(widget.image);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      setState(() {
        diagnosis = Diagnosis.fromJson(body);
      });
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Images.logo,
      ),
      body: _loading ? _buildLoading() : _buildResults(),
    );
  }

  // Builds the loading indicator
  Widget _buildLoading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.width * 0.5,
            child: const CircularProgressIndicator(),
          ),
        ),
        Text('Analyzing image...',
            textAlign: TextAlign.center, style: TextStyles.smallHeadlineBlue)
      ],
    );
  }

  // Builds the results view, displaying the photo and guidance
  Widget _buildResults() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
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
          const SizedBox(height: 10),
          OutlinedButton(
              onPressed: () => Navigator.of(context)
                  .popUntil(ModalRoute.withName('/cameraView')),
              child: const Text('Retake')),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ResultsWidget(diagnosis: diagnosis),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
