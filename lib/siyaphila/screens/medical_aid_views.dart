import 'package:flutter/material.dart';
import '../demo_data.dart';
import '../design_system.dart';

class MedicalAidRootPage extends StatefulWidget {
  final String patientId;
  const MedicalAidRootPage({Key? key, this.patientId = ''}) : super(key: key);

  @override
  State<MedicalAidRootPage> createState() => _MedicalAidRootPageState();
}

class _MedicalAidRootPageState extends State<MedicalAidRootPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [MedicalAidAnalyticsPage(), PredictiveCarePage()];
    return Scaffold(body: pages[_selectedIndex], bottomNavigationBar: NavigationBar(selectedIndex: _selectedIndex, onDestinationSelected: (i) => setState(() => _selectedIndex = i), destinations: const [NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Analytics'), NavigationDestination(icon: Icon(Icons.auto_awesome), label: 'Predictive AI')]));
  }
}

class MedicalAidAnalyticsPage extends StatelessWidget {
  final analytics = DemoData.analytics;
  MedicalAidAnalyticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: DemoTheme.background, appBar: AppBar(title: const Text('Medical Aid'), backgroundColor: Colors.transparent, elevation: 0, foregroundColor: DemoTheme.ink), body: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GradientHeroCard(colors: [const Color(0xFF0F2940), const Color(0xFF1A506A), DemoTheme.mint], child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [StatusChip(title: 'Medical aid analytics', color: Colors.white, icon: Icons.analytics), const SizedBox(height:8), const Text('Adherence becomes population intelligence.', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)), const SizedBox(height:6), const Text('Track stable, rising, high, and critical members, quantify avoidable spend, and prioritize earlier outreach across the covered population.', style: TextStyle(color: Colors.white70))])),

      const SizedBox(height:12),
      Row(children: [Expanded(child: MetricTile(title: 'Projected savings', value: analytics.projectedSavings, subtitle: 'Early intervention opportunity', tint: DemoTheme.mint, icon: Icons.savings)), const SizedBox(width:8), Expanded(child: MetricTile(title: 'Avoidable spend', value: analytics.avoidableSpend, subtitle: 'If risk is missed', tint: DemoTheme.coral, icon: Icons.warning))]),

      const SizedBox(height:12),
      Column(children: analytics.distribution.map((d) => Padding(padding: const EdgeInsets.symmetric(vertical:8.0), child: SurfaceCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Text(d.label, style: const TextStyle(fontWeight: FontWeight.bold)), const Spacer(), Text('${d.value}', style: TextStyle(color: d.color))]), const SizedBox(height:8), LinearProgressIndicator(value: d.value / analytics.coveredLives, color: d.color)])))).toList())
    ])));
  }
}

class PredictiveCarePage extends StatelessWidget {
  final analytics = DemoData.analytics;
  PredictiveCarePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: DemoTheme.background, appBar: AppBar(title: const Text('Predictive AI'), backgroundColor: Colors.transparent, elevation: 0, foregroundColor: DemoTheme.ink), body: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GradientHeroCard(colors: [const Color(0xFF121D3B), const Color(0xFF3E4FBE), DemoTheme.violet], child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [StatusChip(title: 'Predictive care', color: Colors.white, icon: Icons.psychology), const SizedBox(height:8), const Text('From adherence data\nto personalized medicine.', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)), const SizedBox(height:6), const Text('Diagnosis, medications, adherence, side effects, renewal behavior, and outcomes can become training data for future predictive models.', style: TextStyle(color: Colors.white70))])),

      const SizedBox(height:12),
      Column(children: analytics.predictiveInputs.map((n) => Padding(padding: const EdgeInsets.symmetric(vertical:8.0), child: PredictiveNodeCard(nodeTitle: n.title, subtitle: n.subtitle))).toList())
    ])));
  }
}

class PredictiveNodeCard extends StatelessWidget {
  final String nodeTitle; final String subtitle;
  const PredictiveNodeCard({Key? key, required this.nodeTitle, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(child: Row(children: [Container(width:58, height:58, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: DemoTheme.mint.withOpacity(0.14)), child: const Center(child: CircleAvatar(radius:6, backgroundColor: DemoTheme.mint))), const SizedBox(width:12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(nodeTitle, style: const TextStyle(fontWeight: FontWeight.bold)), Text(subtitle, style: const TextStyle(color: Colors.black54))]))]));
  }
}
