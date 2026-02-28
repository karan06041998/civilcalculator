import 'package:flutter/material.dart';

import '../models/tool_item.dart';
import '../widgets/tool_card.dart';
import 'boq_pro_screen.dart';
import 'brick_calculator_screen.dart';
import 'concrete_calculator_screen.dart';
import 'cost_estimator_screen.dart';
import 'plaster_calculator_screen.dart';
import 'steel_calculator_screen.dart';
import 'tile_calculator_screen.dart';
import 'unit_converter_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tools = <ToolItem>[
      const ToolItem(
        title: 'Concrete\nCalculator',
        icon: Icons.foundation,
        screen: ConcreteCalculatorScreen(),
      ),
      const ToolItem(
        title: 'Brick\nCalculator',
        icon: Icons.grid_view,
        screen: BrickCalculatorScreen(),
      ),
      const ToolItem(
        title: 'Steel\nCalculator',
        icon: Icons.straighten,
        screen: SteelCalculatorScreen(),
      ),
      const ToolItem(
        title: 'Plaster\nCalculator',
        icon: Icons.texture,
        screen: PlasterCalculatorScreen(),
      ),
      const ToolItem(
        title: 'Tile\nCalculator',
        icon: Icons.grid_4x4,
        screen: TileCalculatorScreen(),
      ),
      const ToolItem(
        title: 'Unit\nConverter',
        icon: Icons.swap_horiz,
        screen: UnitConverterScreen(),
      ),
      const ToolItem(
        title: 'Cost\nEstimator',
        icon: Icons.payments,
        screen: CostEstimatorScreen(),
      ),
      const ToolItem(
        title: 'BOQ\nGenerator',
        icon: Icons.lock,
        screen: BoqProScreen(),
        isPro: true,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('SiteCalc Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: tools.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.1,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (_, index) {
            final item = tools[index];
            return ToolCard(
              title: item.title,
              icon: item.icon,
              isPro: item.isPro,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => item.screen),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
