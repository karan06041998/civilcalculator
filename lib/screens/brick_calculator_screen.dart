import 'package:flutter/material.dart';

import '../utils/calculation_utils.dart';
import '../widgets/app_text_field.dart';
import '../widgets/result_card.dart';

class BrickCalculatorScreen extends StatefulWidget {
  const BrickCalculatorScreen({super.key});

  @override
  State<BrickCalculatorScreen> createState() => _BrickCalculatorScreenState();
}

class _BrickCalculatorScreenState extends State<BrickCalculatorScreen> {
  final _lengthController = TextEditingController();
  final _heightController = TextEditingController();
  final _thicknessController = TextEditingController(text: '0.23');
  final _brickLengthController = TextEditingController(text: '0.19');
  final _brickWidthController = TextEditingController(text: '0.09');
  final _brickHeightController = TextEditingController(text: '0.09');

  String _ratio = '1:6';
  Map<String, String>? _results;

  void _calculate() {
    final materials = CalculationUtils.brickMaterials(
      wallLengthM: double.tryParse(_lengthController.text) ?? 0,
      wallHeightM: double.tryParse(_heightController.text) ?? 0,
      wallThicknessM: double.tryParse(_thicknessController.text) ?? 0.23,
      brickLengthM: double.tryParse(_brickLengthController.text) ?? 0.19,
      brickWidthM: double.tryParse(_brickWidthController.text) ?? 0.09,
      brickHeightM: double.tryParse(_brickHeightController.text) ?? 0.09,
      mortarRatio: _ratio,
    );

    setState(() {
      _results = {
        'Bricks Required': materials['bricks']!.ceil().toString(),
        'Cement Bags': materials['cementBags']!.toStringAsFixed(2),
        'Sand': '${materials['sandM3']!.toStringAsFixed(3)} m³',
      };
    });
  }

  @override
  void dispose() {
    _lengthController.dispose();
    _heightController.dispose();
    _thicknessController.dispose();
    _brickLengthController.dispose();
    _brickWidthController.dispose();
    _brickHeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Brick Calculator')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppTextField(controller: _lengthController, label: 'Wall Length', suffix: 'm'),
          AppTextField(controller: _heightController, label: 'Wall Height', suffix: 'm'),
          AppTextField(
            controller: _thicknessController,
            label: 'Wall Thickness',
            suffix: 'm',
          ),
          AppTextField(
            controller: _brickLengthController,
            label: 'Brick Length',
            suffix: 'm',
          ),
          AppTextField(controller: _brickWidthController, label: 'Brick Width', suffix: 'm'),
          AppTextField(
            controller: _brickHeightController,
            label: 'Brick Height',
            suffix: 'm',
          ),
          DropdownButtonFormField<String>(
            value: _ratio,
            decoration: const InputDecoration(labelText: 'Mortar Ratio'),
            items: const [
              DropdownMenuItem(value: '1:4', child: Text('1:4')),
              DropdownMenuItem(value: '1:5', child: Text('1:5')),
              DropdownMenuItem(value: '1:6', child: Text('1:6')),
            ],
            onChanged: (value) => setState(() => _ratio = value ?? '1:6'),
          ),
          const SizedBox(height: 18),
          FilledButton(
            onPressed: _calculate,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text('Calculate'),
            ),
          ),
          if (_results != null) ResultCard(title: 'Brick Estimate', results: _results!),
        ],
      ),
    );
  }
}
