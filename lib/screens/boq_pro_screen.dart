import 'package:flutter/material.dart';

class BoqProScreen extends StatelessWidget {
  const BoqProScreen({super.key});

  void _showUpgradeDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Upgrade to Pro'),
        content: const Text(
          'BOQ Generator is available in SiteCalc Pro. Unlock advanced tools, exports, and reports.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Later'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Upgrade'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BOQ Generator')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.workspace_premium,
                    size: 70,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'PRO Feature Locked',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Generate complete BOQ with item-wise quantities and costing in the Pro plan.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () => _showUpgradeDialog(context),
                    icon: const Icon(Icons.lock_open),
                    label: const Text('Upgrade to Pro'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
