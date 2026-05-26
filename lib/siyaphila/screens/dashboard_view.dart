import 'package:flutter/material.dart';
import '../models.dart';
import '../design_system.dart';
import '../patient_store.dart';
import 'today_medication_view.dart';
import 'conditions_medications_view.dart';

class PatientRootPage extends StatefulWidget {
  final PatientProfile patient;
  const PatientRootPage({Key? key, required this.patient}) : super(key: key);

  @override
  State<PatientRootPage> createState() => _PatientRootPageState();
}

class _PatientRootPageState extends State<PatientRootPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final store = PatientStore(widget.patient);
    final pages = [DashboardPage(patient: widget.patient), TodayMedicationPage(store: store), ConditionsMedicationsPage(store: store)];
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(selectedIndex: _selectedIndex, onDestinationSelected: (i) => setState(() => _selectedIndex = i), destinations: const [NavigationDestination(icon: Icon(Icons.home), label: 'Home'), NavigationDestination(icon: Icon(Icons.checklist), label: 'Today'), NavigationDestination(icon: Icon(Icons.medical_services), label: 'Meds')]),
    );
  }
}

class DashboardPage extends StatelessWidget {
  final PatientProfile patient;
  const DashboardPage({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DemoTheme.background,
      appBar: AppBar(title: const Text('Patient App'), backgroundColor: Colors.transparent, elevation: 0, foregroundColor: DemoTheme.ink),
      body: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GradientHeroCard(colors: [DemoTheme.coral, DemoTheme.amber, DemoTheme.coral.withOpacity(0.8)], child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [StatusChip(title: patient.riskBanner, color: Colors.white, icon: Icons.warning), const Spacer(), CircleAvatar(child: const Icon(Icons.person))]),
          const SizedBox(height:8),
          Text(patient.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height:8),
          Text(patient.heroSubtitle, style: const TextStyle(color: Colors.white70)),
        ])),

        const SizedBox(height:16),
        SurfaceCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Today', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height:8),
          Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Next action', style: TextStyle(fontWeight: FontWeight.bold)), Text('Open today to log doses', style: TextStyle(color: Colors.grey))])), Column(children: [Text('${patient.todayTasks.where((t) => t.status == TaskStatus.due).length}', style: const TextStyle(fontSize:24, fontWeight: FontWeight.bold, color: DemoTheme.amber)), const Text('still due')])]),
          const SizedBox(height:12),
          Row(children: [Expanded(child: ElevatedButton(onPressed: () {}, child: const Text('Log now'))), const SizedBox(width:8), Expanded(child: OutlinedButton(onPressed: () {}, child: const Text('Remind in 15')))])
        ])),

        const SizedBox(height:16),
        Row(children: const [Expanded(child: ProgressRing(title: 'Adherence', value: 46, tint: DemoTheme.mint)), SizedBox(width:12), Expanded(child: ProgressRing(title: 'Care', value: 54, tint: DemoTheme.violet)), SizedBox(width:12), Expanded(child: ProgressRing(title: 'Engage', value: 49, tint: DemoTheme.blue))]),

        const SizedBox(height:16),
        SurfaceCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Meds due today', style: TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height:8), ...patient.todayTasks.map((task) => Padding(padding: const EdgeInsets.symmetric(vertical:8.0), child: Row(children: [CircleAvatar(backgroundColor: task.status == TaskStatus.taken ? DemoTheme.mint.withOpacity(0.2) : task.status == TaskStatus.missed ? DemoTheme.coral.withOpacity(0.2) : DemoTheme.amber.withOpacity(0.2), child: Icon(task.status == TaskStatus.taken ? Icons.check_circle : task.status == TaskStatus.missed ? Icons.error : Icons.notifications)), const SizedBox(width:12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(task.medicationName, style: const TextStyle(fontWeight: FontWeight.bold)), Text('${task.time} • ${task.context}', style: TextStyle(color: Colors.grey)),])), StatusChip(title: task.status.name.toUpperCase(), color: task.status == TaskStatus.taken ? DemoTheme.mint : task.status == TaskStatus.missed ? DemoTheme.coral : DemoTheme.amber, icon: Icons.access_time)])))]))
      ])),
    );
  }
}
