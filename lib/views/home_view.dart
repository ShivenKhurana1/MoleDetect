import 'package:flutter/material.dart';
import 'package:MoleDetect/constants/constants.dart';
import 'package:MoleDetect/views/camera_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(alignment: Alignment.topLeft, child: Images.hipaa),
              Images.homeHero,
              const SizedBox(height: 60),
              Images.largeLogo,
              const SizedBox(height: 20),
              Text(
                'AI-Powered Skin Cancer Detection for a Healthier Tomorrow',
                style: TextStyles.smallHeadlineBlue,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                        onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                settings:
                                    const RouteSettings(name: '/cameraView'),
                                builder: (context) => const CameraView(),
                              ),
                            ),
                        child: const Text('Get Started')),
                  ),
                ],
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
