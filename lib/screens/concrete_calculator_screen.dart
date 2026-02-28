import 'package:flutter/material.dart';

import '../utils/calculation_utils.dart';
import '../widgets/app_text_field.dart';
import '../widgets/result_card.dart';

class ConcreteCalculatorScreen extends StatefulWidget {
  const ConcreteCalculatorScreen({super.key});

  @override
  State<ConcreteCalculatorScreen> createState() => _ConcreteCalculatorScreenState();
}

class _ConcreteCalculatorScreenState extends State<ConcreteCalculatorScreen> {
  final _lengthController = TextEditingController();
  final _widthController = TextEditingController();
  final _depthController = TextEditingController();

  String _unit = 'm';
  String _grade = 'M20';
  Map<String, String>? _results;

  double _toMeter(double value) => _unit == 'ft' ? value * 0.3048 : value;

  void _calculate() {
    final length = double.tryParse(_lengthController.text) ?? 0;
    final width = double.tryParse(_widthController.text) ?? 0;
    final depth = double.tryParse(_depthController.text) ?? 0;

    final volume = _toMeter(length) * _toMeter(width) * _toMeter(depth);
    final materials = CalculationUtils.concreteMaterials(volumeM3: volume, grade: _grade);

    setState(() {
      _results = {
        'Volume': '${volume.toStringAsFixed(3)} m³',
        'Cement Bags': materials['cementBags']!.toStringAsFixed(2),
        'Sand': '${materials['sandM3']!.toStringAsFixed(3)} m³',
        'Aggregate': '${materials['aggregateM3']!.toStringAsFixed(3)} m³',
      };
    });
  }

  @override
  void dispose() {
    _lengthController.dispose();
    _widthController.dispose();
    _depthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Concrete Calculator')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppTextField(controller: _lengthController, label: 'Length', suffix: _unit),
          AppTextField(controller: _widthController, label: 'Width', suffix: _unit),
          AppTextField(controller: _depthController, label: 'Depth', suffix: _unit),
          DropdownButtonFormField<String>(
            value: _unit,
            decoration: const InputDecoration(labelText: 'Unit'),
            items: const [
              DropdownMenuItem(value: 'm', child: Text('Meter (m)')),
              DropdownMenuItem(value: 'ft', child: Text('Feet (ft)')),
            ],
            onChanged: (value) => setState(() => _unit = value ?? 'm'),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _grade,
            decoration: const InputDecoration(labelText: 'Concrete Grade'),
            items: const [
              DropdownMenuItem(value: 'M15', child: Text('M15')),
              DropdownMenuItem(value: 'M20', child: Text('M20')),
              DropdownMenuItem(value: 'M25', child: Text('M25')),
            ],
            onChanged: (value) => setState(() => _grade = value ?? 'M20'),
          ),
          const SizedBox(height: 18),
          FilledButton(
            onPressed: _calculate,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text('Calculate'),
            ),
          ),
          if (_results != null)
            ResultCard(title: 'Concrete Estimate', results: _results!),
        ],
      ),
    );
  }
}
