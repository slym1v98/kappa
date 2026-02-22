import 'package:flutter/material.dart';
import 'package:fkappa/kappa.dart';

class DashboardPage extends StatelessWidget with KappaSpacing {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KappaAppBar(title: Text('Enterprise Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(KappaSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Statistics',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            KappaSpacing.mediumV,
            
            // USING THE NEW KAPPA GRID SYSTEM
            KappaGrid(
              mobileCols: 2,
              tabletCols: 4,
              desktopCols: 6,
              gutter: 12.0,
              children: [
                _buildStatCard('Users', '1.2k', Colors.blue, 0),
                _buildStatCard('Revenue', '\$15k', Colors.green, 1),
                _buildStatCard('Orders', '450', Colors.orange, 2),
                _buildStatCard('Tickets', '12', Colors.red, 3),
                _buildStatCard('Uptime', '99.9%', Colors.teal, 4),
                _buildStatCard('Latency', '45ms', Colors.indigo, 5),
              ],
            ),
            
            KappaSpacing.extraLargeV,
            const Text(
              'Recent Activities',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            KappaSpacing.mediumV,
            
            // Grid for large activity blocks
            KappaGrid(
              mobileCols: 1,
              tabletCols: 2,
              desktopCols: 3,
              children: List.generate(6, (index) => _buildActivityCard(index)),
            ),

            KappaSpacing.largeV,
            Center(
              child: KappaButton(
                label: 'Go Back to Settings',
                onPressed: () => context.go('/settings'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color, int index) {
    return KappaAnimatedView(
      type: KappaAnimationType.slideInUp,
      delay: Duration(milliseconds: index * 100),
      child: KappaCard(
        backgroundColor: color.withOpacity(0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
            KappaSpacing.tinyV,
            const Text('0', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), // Demo placeholder
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(int index) {
    return KappaAnimatedView(
      type: KappaAnimationType.scale,
      delay: Duration(milliseconds: 400 + (index * 100)),
      child: KappaCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(KappaDesignTokens.radiusMedium),
              ),
              child: const Center(child: Icon(Icons.image, color: Colors.grey)),
            ),
            KappaSpacing.smallV,
            Text('Activity #$index', style: const TextStyle(fontWeight: FontWeight.bold)),
            const Text('Some details about this activity...', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
