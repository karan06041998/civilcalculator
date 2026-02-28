import 'package:flutter/material.dart';

import '../utils/calculation_utils.dart';
import '../widgets/app_text_field.dart';
import '../widgets/result_card.dart';

class TileCalculatorScreen extends StatefulWidget {
  const TileCalculatorScreen({super.key});

  @override
  State<TileCalculatorScreen> createState() => _TileCalculatorScreenState();
}

class _TileCalculatorScreenState extends State<TileCalculatorScreen> {
  final _floorLengthController = TextEditingController();
  final _floorWidthController = TextEditingController();
  final _tileLengthController = TextEditingController(text: '0.6');
  final _tileWidthController = TextEditingController(text: '0.6');

  Map<String, String>? _results;

  void _calculate() {
    final count = CalculationUtils.tileCount(
      floorLengthM: double.tryParse(_floorLengthController.text) ?? 0,
      floorWidthM: double.tryParse(_floorWidthController.text) ?? 0,
      tileLengthM: double.tryParse(_tileLengthController.text) ?? 0.6,
      tileWidthM: double.tryParse(_tileWidthController.text) ?? 0.6,
    );

    setState(() {
      _results = {
        'Tiles Required': '$count nos',
        'Wastage Included': '10%',
      };
    });
  }

  @override
  void dispose() {
    _floorLengthController.dispose();
    _floorWidthController.dispose();
    _tileLengthController.dispose();
    _tileWidthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tile Calculator')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppTextField(controller: _floorLengthController, label: 'Floor Length', suffix: 'm'),
          AppTextField(controller: _floorWidthController, label: 'Floor Width', suffix: 'm'),
          AppTextField(controller: _tileLengthController, label: 'Tile Length', suffix: 'm'),
          AppTextField(controller: _tileWidthController, label: 'Tile Width', suffix: 'm'),
          const SizedBox(height: 18),
          FilledButton(
            onPressed: _calculate,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text('Calculate'),
            ),
          ),
          if (_results != null) ResultCard(title: 'Tile Estimate', results: _results!),
        ],
      ),
    );
  }
}
