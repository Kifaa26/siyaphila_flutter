import 'package:flutter/material.dart';
import '../patient_store.dart';
import '../design_system.dart';
import '../models.dart';
import 'proof_of_dose_view.dart';

class TodayMedicationPage extends StatelessWidget {
  final PatientStore store;
  const TodayMedicationPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DemoTheme.background,
      appBar: AppBar(title: const Text('Today'), backgroundColor: Colors.transparent, elevation: 0, foregroundColor: DemoTheme.ink),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GradientHeroCard(colors: [DemoTheme.ink, DemoTheme.blue, DemoTheme.violet], child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            StatusChip(title: 'Today\'s medication plan', color: Colors.white, icon: Icons.checklist),
            const SizedBox(height:8),
            const Text('One screen for every\ndose today.', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height:6),
            const Text('Log medication, snooze reminders, skip missed doses, and launch proof-of-dose without jumping between screens.', style: TextStyle(color: Colors.white70))
          ])),

          const SizedBox(height:16),
          SurfaceCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Daily progress', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height:8),
            Row(children: [Expanded(child: SummaryMetric(title: 'Completed', value: '${store.takenTaskCount}', tint: DemoTheme.mint)), const SizedBox(width:8), Expanded(child: SummaryMetric(title: 'Due now', value: '${store.dueTaskCount}', tint: DemoTheme.amber)), const SizedBox(width:8), Expanded(child: SummaryMetric(title: 'Missed', value: '${store.missedTaskCount}', tint: DemoTheme.coral))]),
            const SizedBox(height:12),
            if (store.nextPriorityTask != null) Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height:8),
              Text('Next dose', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),
              Text('${store.nextPriorityTask!.medicationName} • ${store.nextPriorityTask!.time}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height:8),
              Row(children: [Expanded(child: ElevatedButton(onPressed: () { store.setStatus(store.nextPriorityTask!, TaskStatus.taken); }, child: const Text('Log now'))), const SizedBox(width:8), Expanded(child: OutlinedButton(onPressed: () { store.openProofCameraFor(store.nextPriorityTask!); Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProofOfDosePage(store: store))); }, child: const Text('Use proof')))])
            ])
          ])),

          const SizedBox(height:16),
          Column(children: store.patient.todayTasks.map((task) => Padding(padding: const EdgeInsets.symmetric(vertical:8.0), child: TodayTaskCard(task: task, store: store))).toList())
        ]),
      ),
    );
  }
}

class SummaryMetric extends StatelessWidget {
  final String title; final String value; final Color tint;
  const SummaryMetric({Key? key, required this.title, required this.value, required this.tint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.black54)), const SizedBox(height:6), Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: tint.withOpacity(0.12), borderRadius: BorderRadius.circular(12)), child: Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: tint))) ]);
  }
}

class TodayTaskCard extends StatelessWidget {
  final MedicationTask task; final PatientStore store;
  const TodayTaskCard({Key? key, required this.task, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = store.statusFor(task);
    return SurfaceCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [CircleAvatar(backgroundColor: status == TaskStatus.taken ? DemoTheme.mint.withOpacity(0.2) : status == TaskStatus.missed ? DemoTheme.coral.withOpacity(0.2) : DemoTheme.amber.withOpacity(0.2), child: Icon(status == TaskStatus.taken ? Icons.check_circle : status == TaskStatus.missed ? Icons.error : Icons.notifications)), const SizedBox(width:12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(task.medicationName, style: const TextStyle(fontWeight: FontWeight.bold)), Text('${task.time} • ${task.context}', style: const TextStyle(color: Colors.black54)), Text(store.noteFor(task), style: TextStyle(color: status == TaskStatus.taken ? DemoTheme.mint : status == TaskStatus.missed ? DemoTheme.coral : DemoTheme.amber))])), StatusChip(title: status.name.toUpperCase(), color: status == TaskStatus.taken ? DemoTheme.mint : status == TaskStatus.missed ? DemoTheme.coral : DemoTheme.amber, icon: Icons.access_time)]),
      const SizedBox(height:8),
      Row(children: [Expanded(child: TextButton(onPressed: () => store.setStatus(task, TaskStatus.taken), child: const Text('Taken'))), const SizedBox(width:8), Expanded(child: TextButton(onPressed: () => store.setStatus(task, TaskStatus.due), child: const Text('Snooze'))), const SizedBox(width:8), Expanded(child: TextButton(onPressed: () => store.setStatus(task, TaskStatus.missed), child: const Text('Skip')))]),
      const SizedBox(height:8),
      OutlinedButton.icon(onPressed: () { store.openProofCameraFor(task); Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProofOfDosePage(store: store))); }, icon: const Icon(Icons.camera_alt), label: const Text('Quick proof of dose'))
    ]));
  }
}
