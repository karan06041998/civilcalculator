import 'package:flutter/material.dart';

import '../widgets/app_text_field.dart';
import '../widgets/result_card.dart';

class CostEstimatorScreen extends StatefulWidget {
  const CostEstimatorScreen({super.key});

  @override
  State<CostEstimatorScreen> createState() => _CostEstimatorScreenState();
}

class _CostEstimatorScreenState extends State<CostEstimatorScreen> {
  final _cementRateController = TextEditingController();
  final _steelRateController = TextEditingController();
  final _sandRateController = TextEditingController();
  final _cementQtyController = TextEditingController();
  final _steelQtyController = TextEditingController();
  final _sandQtyController = TextEditingController();
  final _areaController = TextEditingController();

  Map<String, String>? _results;

  void _calculate() {
    final cementCost =
        (double.tryParse(_cementRateController.text) ?? 0) *
        (double.tryParse(_cementQtyController.text) ?? 0);
    final steelCost =
        (double.tryParse(_steelRateController.text) ?? 0) *
        (double.tryParse(_steelQtyController.text) ?? 0);
    final sandCost =
        (double.tryParse(_sandRateController.text) ?? 0) *
        (double.tryParse(_sandQtyController.text) ?? 0);

    final total = cementCost + steelCost + sandCost;
    final area = double.tryParse(_areaController.text) ?? 0;
    final perSqft = area > 0 ? total / area : 0;

    setState(() {
      _results = {
        'Total Material Cost': '₹ ${total.toStringAsFixed(2)}',
        'Per Sqft Cost': '₹ ${perSqft.toStringAsFixed(2)}',
      };
    });
  }

  @override
  void dispose() {
    _cementRateController.dispose();
    _steelRateController.dispose();
    _sandRateController.dispose();
    _cementQtyController.dispose();
    _steelQtyController.dispose();
    _sandQtyController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cost Estimator')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppTextField(controller: _cementRateController, label: 'Cement Rate', suffix: '/bag'),
          AppTextField(controller: _cementQtyController, label: 'Cement Quantity', suffix: 'bags'),
          AppTextField(controller: _steelRateController, label: 'Steel Rate', suffix: '/kg'),
          AppTextField(controller: _steelQtyController, label: 'Steel Quantity', suffix: 'kg'),
          AppTextField(controller: _sandRateController, label: 'Sand Rate', suffix: '/m³'),
          AppTextField(controller: _sandQtyController, label: 'Sand Quantity', suffix: 'm³'),
          AppTextField(controller: _areaController, label: 'Total Area', suffix: 'sqft'),
          const SizedBox(height: 18),
          FilledButton(
            onPressed: _calculate,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text('Estimate Cost'),
            ),
          ),
          if (_results != null) ResultCard(title: 'Cost Estimate', results: _results!),
        ],
      ),
    );
  }
}
