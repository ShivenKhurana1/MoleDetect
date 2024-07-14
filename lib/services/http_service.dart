import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:claude_dart_flutter/claude_dart_flutter.dart' as claude;

class HttpService {
  // Posts the image to the server and awaits the prediction
  static Future<http.Response> postImage(XFile image) async {
    try {
      var uri =
          Uri.parse('https://oneskin-ai.ue.r.appspot.com/analyze/picture');
      http.MultipartRequest request = http.MultipartRequest('POST', uri)
        ..files.add(http.MultipartFile.fromBytes(
            "file", await image.readAsBytes(),
            filename: image.path, contentType: MediaType("image", "jpg")));
      http.StreamedResponse streamedResponse = await request.send();
      http.Response response = await http.Response.fromStream(streamedResponse);
      return response;
//       await Future.delayed(Duration(seconds: 2));
//       return http.Response('''
// {"confidence":0.9,"risk":"Low Risk","riskTitle":"Not Concerning","description":"Based on the results from our AI, your lesion has traits that are consistent with a benign (non-cancerous) lesion.","recommendationTitle":"Continue to Monitor","recommendationDescription":"We recommend to continue to monitor for changes in size, texture, color and bleeding. Consult your healthcare provider if any of these changes occur. Repeat scan monthly."}
// ''', 200);
    } catch (e) {
      return http.Response('', 500);
    }
  }

  // Posts a message to the server and awaits a response from the LLM
  static Future<claude.Response> postClaude(claude.Request request) async {
    claude.ClaudeService claudeService = claude.ClaudeService("API_KEY");
    claude.Response response =
        await claudeService.sendRequest(request: request);

    return response;
  }
}
