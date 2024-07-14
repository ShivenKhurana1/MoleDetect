import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:MoleDetect/components/tutorial_view.dart';
import 'package:MoleDetect/constants/constants.dart';
import 'package:MoleDetect/views/photo_review_view.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  CameraViewState createState() => CameraViewState();
}

class CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  late final List<CameraDescription> _cameras;

  bool _showTutorial = true;
  bool _showDisclosure = true;

  double _currentScale = 1.0;
  final double _maxScale = 10;

  @override
  void initState() {
    initCamera();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _showDialog();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isCameraInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: Images.logo,
          actions: [
            IconButton(
                onPressed: () {
                  _toggleTutorial();
                  _showDialog();
                },
                icon: Icon(Icons.question_mark, color: ThemeColors.blueText))
          ],
        ),
        body: SafeArea(child: _buildView()),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  // Opens the dialog of instructions
  void _showDialog() => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => TutorialView(
          onPressed: _toggleTutorial, showDisclosure: _showDisclosure));

  // Toggles whether to display camera preview
  void _toggleTutorial() => setState(() {
        _showTutorial = !_showTutorial;
        _showDisclosure = false;
      });

  // Builds the main camera view
  Widget _buildView() {
    return Column(children: [
      const SizedBox(
        height: 50,
      ),
      Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.8,
              child: ModalRoute.of(context)?.isCurrent ?? false
                  ? _buildCameraView()
                  : Container())),
      const Spacer(),
      _buildButton(),
      const SizedBox(
        height: 50,
      ),
      Text('Tap camera button when ready', style: TextStyles.largeBody),
      const SizedBox(
        height: 50,
      ),
    ]);
  }

  // Builds the camera preview window with zoom slider
  Widget _buildCameraView() {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1, // Set aspect ratio to 1:1 for a square
          child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                  width: _controller!.value.previewSize?.height,
                  height: _controller!.value.previewSize?.width,
                  child: CameraPreview(
                    _controller!,
                  ))),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RotatedBox(
                  quarterTurns: -1,
                  child: Slider(
                    activeColor: Color(4280960632),
                    min: 1,
                    max: _maxScale,
                    onChanged: _handleSliderUpdate,
                    value: _currentScale,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  // Handles the slider update and adjusts the camera zoom
  Future<void> _handleSliderUpdate(double value) async {
    setState(() {
      _currentScale = value;
    });

    await _controller!.setZoomLevel(_currentScale);
  }

  // Builds the camera shot button
  Widget _buildButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
          height: 80,
          width: 80,
          child: FittedBox(
              child: FloatingActionButton(
            onPressed: _showTutorial ? null : _onTakePhotoPressed,
            child: const Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          ))),
    );
  }

  // Initializes the camera
  Future<void> initCamera() async {
    _cameras = await availableCameras();
    // Initialize the camera with the first camera in the list
    await onNewCameraSelected(_cameras.first);
  }

  // Updates the camera in case of change
  Future<void> onNewCameraSelected(CameraDescription description) async {
    final previousCameraController = _controller;

    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      description,
      ResolutionPreset.ultraHigh,
      imageFormatGroup: ImageFormatGroup.jpeg,
    )..setFocusMode(FocusMode.auto);

    // Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      debugPrint('Error initializing camera: $e');
    }
    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
      setState(() {
        _controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    // Update the Boolean
    if (mounted) {
      setState(() {
        _isCameraInitialized = _controller!.value.isInitialized;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(cameraController.description);
    }
  }

  // Captures the photo and returns the file
  Future<XFile?> capturePhoto() async {
    final CameraController? cameraController = _controller;
    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }
    try {
      //await cameraController.setFlashMode(FlashMode.torch); //optional
      XFile file = await cameraController.takePicture();
      //await cameraController.setFlashMode(FlashMode.off); //optional
      return file;
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  // Handles flow of photo capture and navigation to preview screen
  void _onTakePhotoPressed() async {
    final navigator = Navigator.of(context);
    final image = await capturePhoto();
    if (image != null) {
      navigator.push(
        MaterialPageRoute(
          settings: const RouteSettings(name: 'photoReviewView'),
          builder: (context) => PhotoReviewView(
            image: image,
          ),
        ),
      );
    }
  }
}
