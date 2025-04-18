import 'package:tflite_flutter/tflite_flutter.dart';

class TFLiteService {
  late Interpreter _interpreter;

  // Load the model
  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('burn_degree_model.tflite');
      print('✅ Model loaded successfully!');
    } catch (e) {
      print('❌ Failed to load model: $e');
    }
  }

  // Run the model
  List runModel(List<double> inputData) {
    // Adjust shape based on your model's expected input/output
    var input = [inputData]; // [1, input_size]
    var output = List.filled(3, 0).reshape([1, 3]); // [1, output_size]

    _interpreter.run(input, output);
    print('🔍 Model output: $output');

    return output[0]; // Return the first (and only) result
  }
}
