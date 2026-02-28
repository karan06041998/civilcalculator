import 'package:flutter/material.dart';

import '../widgets/app_text_field.dart';

class UnitConverterScreen extends StatefulWidget {
  const UnitConverterScreen({super.key});

  @override
  State<UnitConverterScreen> createState() => _UnitConverterScreenState();
}

class _UnitConverterScreenState extends State<UnitConverterScreen> {
  final _inputController = TextEditingController();
  String _conversion = 'ft_to_m';
  String _result = '0';

  final _conversions = const {
    'ft_to_m': ('Feet → Meter', 0.3048),
    'm_to_ft': ('Meter → Feet', 3.28084),
    'sqft_to_sqm': ('Sqft → Sqm', 0.092903),
    'sqm_to_sqft': ('Sqm → Sqft', 10.7639),
    'cum_to_cft': ('Cum → Cft', 35.3147),
    'cft_to_cum': ('Cft → Cum', 0.0283168),
    'kg_to_ton': ('Kg → Ton', 0.001),
    'ton_to_kg': ('Ton → Kg', 1000),
  };

  void _convert() {
    final value = double.tryParse(_inputController.text) ?? 0;
    final factor = _conversions[_conversion]!.$2;
    setState(() => _result = (value * factor).toStringAsFixed(4));
  }

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_convert);
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Unit Converter')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<String>(
            value: _conversion,
            decoration: const InputDecoration(labelText: 'Conversion Type'),
            items: _conversions.entries
                .map(
                  (entry) => DropdownMenuItem(
                    value: entry.key,
                    child: Text(entry.value.$1),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() => _conversion = value ?? 'ft_to_m');
              _convert();
            },
          ),
          const SizedBox(height: 12),
          AppTextField(controller: _inputController, label: 'Value'),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Converted Value',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _result,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
