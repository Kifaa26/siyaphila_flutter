import 'package:flutter/material.dart';
import '../patient_store.dart';
import '../design_system.dart';
import '../models.dart';

class CoachCenterPage extends StatelessWidget {
  final PatientStore store;
  const CoachCenterPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final visibleNudges = store.patient.nudges.where((n) => !store.isAcknowledged(n)).toList();
    return Scaffold(
      backgroundColor: DemoTheme.background,
      appBar: AppBar(title: const Text('AI Coach'), backgroundColor: Colors.transparent, elevation: 0, foregroundColor: DemoTheme.ink),
      body: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GradientHeroCard(colors: [const Color(0xFF1B2250), const Color(0xFF4A49D3), DemoTheme.violet], child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [StatusChip(title: 'AI coach', color: Colors.white, icon: Icons.auto_awesome), const SizedBox(height:8), const Text('Support that feels\npersonal and timely.', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)), const SizedBox(height:6), const Text('Believable nudges, streak recovery, follow-up reminders, and support planning around Ayo’s actual behavior pattern.', style: TextStyle(color: Colors.white70))])),

        const SizedBox(height:12),
        Row(children: [Expanded(child: MetricTile(title: 'Risk level', value: store.patient.riskLevel.toString().split('.').last, subtitle: 'Current support priority', tint: store.patient.riskLevel.color(), icon: Icons.monitor_heart)), const SizedBox(width:8), Expanded(child: MetricTile(title: 'Open nudges', value: '${store.openNudgesCount}', subtitle: 'Needs action', tint: DemoTheme.blue, icon: Icons.health_and_safety))]),

        const SizedBox(height:12),
        Row(children: [TaskFilterButton(title: 'Open', isSelected: true, onTap: () {}), const SizedBox(width:8), TaskFilterButton(title: 'All', isSelected: false, onTap: () {})]),

        const SizedBox(height:12),
        Column(
          children: visibleNudges.map((nudge) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SurfaceCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: nudge.tone.color().withOpacity(0.14),
                          child: Icon(Icons.info, color: nudge.tone.color()),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(nudge.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text(nudge.body, style: const TextStyle(color: Colors.black54)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        TaskFilterButton(
                          title: store.isAcknowledged(nudge) ? 'Acknowledged' : 'Mark done',
                          isSelected: store.isAcknowledged(nudge),
                          onTap: () { store.acknowledge(nudge); },
                        ),
                        const SizedBox(width: 8),
                        if (nudge.title.toLowerCase().contains('follow-up'))
                          TaskFilterButton(
                            title: store.followUpConfirmed ? 'Visit booked' : 'Book follow-up',
                            isSelected: store.followUpConfirmed,
                            onTap: () { store.toggleFollowUpConfirmed(); },
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ])),
    );
  }
}

class TaskFilterButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  const TaskFilterButton({Key? key, required this.title, required this.isSelected, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onTap, style: ElevatedButton.styleFrom(backgroundColor: isSelected ? DemoTheme.blue : DemoTheme.blue.withOpacity(0.12), foregroundColor: isSelected ? Colors.white : DemoTheme.blue), child: Text(title));
  }
}
