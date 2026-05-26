import 'package:flutter/material.dart';
import '../patient_store.dart';
import '../design_system.dart';

class ConditionsMedicationsPage extends StatelessWidget {
  final PatientStore store;
  const ConditionsMedicationsPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DemoTheme.background,
      appBar: AppBar(title: const Text('Conditions & Meds'), backgroundColor: Colors.transparent, elevation: 0, foregroundColor: DemoTheme.ink),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Conditions', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  for (var c in store.patient.conditions)
                    ListTile(
                      title: Text(c.name),
                      subtitle: Text(c.careNote),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Medications', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  for (var m in store.patient.medications)
                    ListTile(
                      title: Text(m.name),
                      subtitle: Text('${m.dose} • ${m.schedule}'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
