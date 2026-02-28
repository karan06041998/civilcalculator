import 'package:flutter/material.dart';

import '../utils/calculation_utils.dart';
import '../widgets/app_text_field.dart';
import '../widgets/result_card.dart';

class SteelCalculatorScreen extends StatefulWidget {
  const SteelCalculatorScreen({super.key});

  @override
  State<SteelCalculatorScreen> createState() => _SteelCalculatorScreenState();
}

class _SteelCalculatorScreenState extends State<SteelCalculatorScreen> {
  final _diameterController = TextEditingController();
  final _lengthController = TextEditingController();
  final _barsController = TextEditingController();

  Map<String, String>? _results;

  void _calculate() {
    final kg = CalculationUtils.steelWeightKg(
      diameterMm: double.tryParse(_diameterController.text) ?? 0,
      lengthM: double.tryParse(_lengthController.text) ?? 0,
      bars: int.tryParse(_barsController.text) ?? 0,
    );

    setState(() {
      _results = {
        'Steel Weight': '${kg.toStringAsFixed(2)} kg',
        'Steel Weight (Ton)': '${(kg / 1000).toStringAsFixed(4)} ton',
      };
    });
  }

  @override
  void dispose() {
    _diameterController.dispose();
    _lengthController.dispose();
    _barsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Steel Calculator')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppTextField(controller: _diameterController, label: 'Diameter', suffix: 'mm'),
          AppTextField(controller: _lengthController, label: 'Length', suffix: 'm'),
          AppTextField(controller: _barsController, label: 'Number of Bars'),
          const SizedBox(height: 18),
          FilledButton(
            onPressed: _calculate,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text('Calculate'),
            ),
          ),
          if (_results != null) ResultCard(title: 'Steel Estimate', results: _results!),
        ],
      ),
    );
  }
}
