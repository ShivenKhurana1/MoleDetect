import 'package:flutter/material.dart';
import 'package:MoleDetect/constants/constants.dart';
import 'package:MoleDetect/models/diagnosis_model.dart';
import 'package:MoleDetect/views/chat_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ResultsWidget extends StatefulWidget {
  final Diagnosis? diagnosis;
  const ResultsWidget({super.key, required this.diagnosis});

  @override
  State<ResultsWidget> createState() => _ResultsWidgetState();
}

class _ResultsWidgetState extends State<ResultsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          direction: Axis.horizontal,
          children: [
            Flexible(
                fit: FlexFit.tight,
                child: _buildContainer('Assessment', _buildDiagnosisResult(),
                    height: 150)),
            SizedBox(width: 10),
            Flexible(
                fit: FlexFit.tight,
                child: _buildContainer('Confidence', _buildConfidenceResult(),
                    height: 150)),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Flex(
          direction: Axis.horizontal,
          children: [
            Flexible(
                fit: FlexFit.tight,
                child: _buildContainer(
                    'Risk Interpretation', _buildDiagnosisDescription())),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Flex(
          direction: Axis.horizontal,
          children: [
            Flexible(
                fit: FlexFit.tight,
                child: _buildContainer(
                    'Recommendation', _buildDiagnosisRecommendation())),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          direction: Axis.horizontal,
          children: [
            Flexible(
                fit: FlexFit.tight,
                child: _buildButton(
                    Icon(Icons.mobile_screen_share_rounded,
                        color: ThemeColors.blueText),
                    Text('Share Results with Healthcare Provider',
                        style: TextStyles.smallLabelBlue),
                    () {})),
            const SizedBox(width: 10),
            Flexible(
                fit: FlexFit.tight,
                child: _buildButton(
                    Icon(Icons.chat_rounded, color: ThemeColors.blueText),
                    Text('Start Chat with our AI Dermatologist',
                        style: TextStyles.smallLabelBlue),
                    navigateToChat)),
          ],
        ),
        SizedBox(height: 80)
      ],
    );
  }

  void navigateToChat() => Navigator.of(context).push(
        MaterialPageRoute(
          settings: const RouteSettings(name: '/chatView'),
          builder: (context) => const ChatView(),
        ),
      );

  // Build the standard container for the buttons at bottom
  Widget _buildButton(Widget icon, Widget text, void Function() onPressed,
      {double? height}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          padding: EdgeInsets.all(20),
          height: height,
          decoration: BoxDecoration(
              border: Border.all(color: ThemeColors.darkOutline, width: 0.5),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              icon,
              const SizedBox(
                height: 10,
              ),
              text
            ],
          )),
    );
  }

  // Build the standard container with padding and correct color for consistency
  Widget _buildContainer(String title, Widget content, {double? height}) {
    return Container(
        padding: EdgeInsets.all(20),
        height: height,
        decoration: BoxDecoration(
            color: Color(4279967779), borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(title, style: TextStyles.smallTitleBlue),
            SizedBox(height: 10),
            content,
          ],
        ));
  }

  // Build the diagnosis result block
  Widget _buildDiagnosisDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            Images.riskImage,
            const SizedBox(width: 5),
            Text(
              widget.diagnosis?.riskTitle ?? 'Retake Photo',
              style: TextStyles.largeHeadlineBlue,
            ),
          ],
        ),
        Text(
          widget.diagnosis?.description ??
              'The image couldn\'t be analyzed appropriately. Please retake the image with better lighting, and make sure the image is focused.',
          style: TextStyles.smallBody,
        )
      ],
    );
  }

  // Build the diagnosis result block
  Widget _buildDiagnosisRecommendation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            Images.recommendationImage,
            const SizedBox(width: 5),
            Text(
              'Continue to Monitor',
              style: TextStyles.largeHeadlineBlue,
            ),
          ],
        ),
        Text(
          'We recommend to continue to monitor for changes in size, texture, color and bleeding. Consult your healthcare provider if any of these changes occur. Repeat scan monthly.',
          style: TextStyles.smallBody,
        )
      ],
    );
  }

  // Build the testing reminder
  Widget _buildDiagnosisResult() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Images.diagnosisImage,
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  widget.diagnosis?.risk ?? 'Uncertain Risk',
                  style: TextStyles.largeHeadlineBlue,
                  softWrap: true,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // Build the confidence result block
  Widget _buildConfidenceResult() {
    return Center(
      child: CircularPercentIndicator(
        arcType: ArcType.FULL,
        arcBackgroundColor: ThemeColors.darkBackground,
        progressColor: Theme.of(context).colorScheme.primary,
        radius: 40,
        lineWidth: 2,
        percent: widget.diagnosis?.confidence ?? 0,
        center: Text(
          '${((widget.diagnosis?.confidence ?? 0) * 100).round()}%',
          style: TextStyles.largeHeadlineBlue,
        ),
      ),
    );
  }
}
