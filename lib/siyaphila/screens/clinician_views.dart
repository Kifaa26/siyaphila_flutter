import 'package:flutter/material.dart';
import '../demo_data.dart';
import '../design_system.dart';

class ClinicianRootPage extends StatefulWidget {
  final String patientId;
  const ClinicianRootPage({Key? key, this.patientId = ''}) : super(key: key);

  @override
  State<ClinicianRootPage> createState() => _ClinicianRootPageState();
}

class _ClinicianRootPageState extends State<ClinicianRootPage> {
  int _selectedIndex = 0;
  final selectedCaseID = DemoData.clinicianCases.first.id;

  @override
  Widget build(BuildContext context) {
    final pages = [
      ClinicianOverview(selectedCaseID: selectedCaseID),
      PrescribingManagement(selectedCaseID: selectedCaseID),
      AdherenceReview(selectedCaseID: selectedCaseID),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.person), label: 'Overview'),
          NavigationDestination(icon: Icon(Icons.medication), label: 'Prescribe'),
          NavigationDestination(icon: Icon(Icons.show_chart), label: 'Review'),
        ],
      ),
    );
  }
}

class ClinicianOverview extends StatelessWidget {
  final String selectedCaseID;
  const ClinicianOverview({Key? key, required this.selectedCaseID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedCase = DemoData.clinicianCases.firstWhere(
      (c) => c.id == selectedCaseID,
      orElse: () => DemoData.clinicianCases.first,
    );

    return Scaffold(
      backgroundColor: DemoTheme.background,
      appBar: AppBar(
        title: const Text('Clinician'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: DemoTheme.ink,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientHeroCard(
              colors: const [
                Color(0xFF10203B),
                Color(0xFF244FC8),
                Color(0xFF2F8CFF),
              ],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StatusChip(
                    title: 'Clinician dashboard',
                    color: Colors.white,
                    icon: Icons.medical_services,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${selectedCase.patient.name} • clinician view',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    selectedCase.snapshot.patientSummary,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Column(
              children: selectedCase.patient.medications.map((med) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SurfaceCard(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(med.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                                '${med.dose} • ${med.schedule}',
                                style: const TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        StatusChip(
                          title: med.timing,
                          color: med.color,
                          icon: Icons.access_time,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class PrescribingManagement extends StatelessWidget {
  final String selectedCaseID;
  const PrescribingManagement({Key? key, required this.selectedCaseID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DemoTheme.background,
      appBar: AppBar(
        title: const Text('Prescribing'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: DemoTheme.ink,
      ),
      body: const Center(child: Text('Prescribing UI (converted)')),
    );
  }
}

class AdherenceReview extends StatelessWidget {
  final String selectedCaseID;
  const AdherenceReview({Key? key, required this.selectedCaseID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedCase = DemoData.clinicianCases.firstWhere(
      (c) => c.id == selectedCaseID,
      orElse: () => DemoData.clinicianCases.first,
    );

    return Scaffold(
      backgroundColor: DemoTheme.background,
      appBar: AppBar(
        title: const Text('Adherence Review'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: DemoTheme.ink,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientHeroCard(
              colors: const [
                Color(0xFF13203B),
                Color(0xFF3255B8),
                Color(0xFF6B63FF),
              ],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  StatusChip(
                    title: 'Adherence review',
                    color: Colors.white,
                    icon: Icons.show_chart,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Poor control may be\nbehavior, not failure.',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Use adherence trends, missed-dose patterns, and barrier notes to decide whether medication escalation is truly needed.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Column(
              children: selectedCase.patient.trend.map((point) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: point.value.toDouble(),
                              width: 20,
                              color: DemoTheme.blue,
                            ),
                            const SizedBox(height: 6),
                            Text(point.label, style: const TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
