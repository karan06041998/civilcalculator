import 'package:flutter/material.dart';

import '../utils/calculation_utils.dart';
import '../widgets/app_text_field.dart';
import '../widgets/result_card.dart';

class PlasterCalculatorScreen extends StatefulWidget {
  const PlasterCalculatorScreen({super.key});

  @override
  State<PlasterCalculatorScreen> createState() => _PlasterCalculatorScreenState();
}

class _PlasterCalculatorScreenState extends State<PlasterCalculatorScreen> {
  final _areaController = TextEditingController();
  final _thicknessController = TextEditingController(text: '12');

  Map<String, String>? _results;

  void _calculate() {
    final materials = CalculationUtils.plasterMaterials(
      areaM2: double.tryParse(_areaController.text) ?? 0,
      thicknessMm: double.tryParse(_thicknessController.text) ?? 12,
    );

    setState(() {
      _results = {
        'Cement Bags': materials['cementBags']!.toStringAsFixed(2),
        'Sand': '${materials['sandM3']!.toStringAsFixed(3)} m³',
      };
    });
  }

  @override
  void dispose() {
    _areaController.dispose();
    _thicknessController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plaster Calculator')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppTextField(controller: _areaController, label: 'Area', suffix: 'm²'),
          AppTextField(controller: _thicknessController, label: 'Thickness', suffix: 'mm'),
          const SizedBox(height: 18),
          FilledButton(
            onPressed: _calculate,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text('Calculate'),
            ),
          ),
          if (_results != null)
            ResultCard(title: 'Plaster Estimate', results: _results!),
        ],
      ),
    );
  }
}
