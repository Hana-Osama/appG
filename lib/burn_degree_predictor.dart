import 'dart:io';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tflite/tflite.dart';

class BurnDegreePredictor {
  Future<void> loadModel() async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      await Tflite.loadModel(
        model: "assets/burn_degree_model.tflite",
        labels: "assets/labels.txt",
      );
    } else {
      print("TFLite is not supported on this platform.");
    }
  }

  Future<String> predictBurnDegree(File image) async {
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) {
      return "Prediction not supported on this platform.";
    }

    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 1,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    if (recognitions != null && recognitions.isNotEmpty) {
      return recognitions[0]['label'];
    } else {
      return "Unknown";
    }
  }

  void dispose() {
    Tflite.close();
  }
}

Future<String> predictBurnDegree(File image) async {
  try {
    final results = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 4,
      threshold: 0.4,
      asynch: true,
    );

    if (results != null && results.isNotEmpty) {
      final label = results.first['label'];
      return label ?? "Unknown";
    } else {
      return "No result";
    }
  } catch (e) {
    print("Error running model: $e");
    return "Error";
  }
}

void dispose() {
  Tflite.close();
}



/*import 'dart:io';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';

class BurnDegreePredictor {
  Interpreter? _interpreter;
  List<String> labels = [
    'Normal Skin',
    'First-Degree Burn',
    'Second-Degree Burn',
    'Third-Degree Burn'
  ];

  Future<void> loadModel() async {
    try {
      _interpreter =
          await Interpreter.fromAsset('assets/burn_degree_model.tflite');
      print('Model loaded successfully');
    } catch (e) {
      print('Failed to load model: $e');
      throw Exception('Failed to load model: $e');
    }
  }

  Float32List _preprocessImage(File imageFile) {
    // Decode image
    img.Image? image = img.decodeImage(imageFile.readAsBytesSync());
    if (image == null) {
      throw Exception('Failed to decode image');
    }

    // Resize to 224x224 (adjust if your model requires a different size)
    image = img.copyResize(image, width: 224, height: 224);

    // Convert to Float32List with shape [1, 224, 224, 3]
    var input = Float32List(1 * 224 * 224 * 3);
    int pixelIndex = 0;
    for (var y = 0; y < 224; y++) {
      for (var x = 0; x < 224; x++) {
        var pixel = image.getPixel(x, y);
        input[pixelIndex++] = pixel.r / 255.0; // Red
        input[pixelIndex++] = pixel.g / 255.0; // Green
        input[pixelIndex++] = pixel.b / 255.0; // Blue
      }
    }
    return input; // No reshape needed; input is flat and matches [1, 224, 224, 3]
  }

  Future<String> predictBurnDegree(File image) async {
    if (_interpreter == null) {
      throw Exception('Model not loaded');
    }
    try {
      var input = _preprocessImage(image);
      var output = List.filled(1 * 4, 0.0); // Flat output for [1, 4]
      _interpreter!.run(input, output);
      var predictedIndex =
          output.indexOf(output.reduce((a, b) => a > b ? a : b));
      print('Model output: $output'); // Debugging
      return labels[predictedIndex];
    } catch (e) {
      print('Prediction error: $e');
      throw Exception('Prediction error: $e');
    }
  }

  void dispose() {
    _interpreter?.close();
    _interpreter = null;
  }
}


/*import 'dart:io';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';

class BurnDegreePredictor {
  Interpreter? _interpreter;
  List<String> labels = [
    'Normal Skin',
    'First-Degree Burn',
    'Second-Degree Burn',
    'Third-Degree Burn'
  ];

  Future<void> loadModel() async {
    try {
      _interpreter =
          await Interpreter.fromAsset('assets/burn_degree_model.tflite');
      print('Model loaded successfully');
    } catch (e) {
      print('Failed to load model: $e');
      throw Exception('Failed to load model: $e');
    }
  }

  Float32List _preprocessImage(File imageFile) {
    // Decode image
    img.Image? image = img.decodeImage(imageFile.readAsBytesSync());
    if (image == null) {
      throw Exception('Failed to decode image');
    }

    // Resize to 224x224 (adjust if your model requires a different size)
    image = img.copyResize(image, width: 224, height: 224);

    // Convert to Float32List and normalize to [0, 1]
    var input = Float32List(1 * 224 * 224 * 3);
    int pixelIndex = 0;
    for (var y = 0; y < 224; y++) {
      for (var x = 0; x < 224; x++) {
        var pixel = image.getPixel(x, y);
        input[pixelIndex++] = pixel.r / 255.0; // Red
        input[pixelIndex++] = pixel.g / 255.0; // Green
        input[pixelIndex++] = pixel.b / 255.0; // Blue
      }
    }
    return input.resize([224, 224]);
  }

  Future<String> predictBurnDegree(File image) async {
    if (_interpreter == null) {
      throw Exception('Model not loaded');
    }
    try {
      var input = _preprocessImage(image);
      var output = List.filled(1 * 4, 0.0).reshape([1, 4]); // 4 classes
      _interpreter!.run(input, output);
      var predictedIndex =
          output[0].indexOf(output[0].reduce((a, b) => a > b ? a : b));
      print('Model output: $output'); // Debugging
      return labels[predictedIndex];
    } catch (e) {
      print('Prediction error: $e');
      throw Exception('Prediction error: $e');
    }
  }

  void dispose() {
    _interpreter?.close();
    _interpreter = null;
  }
}*/*/
