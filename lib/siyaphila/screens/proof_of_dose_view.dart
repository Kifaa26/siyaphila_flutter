import 'package:flutter/material.dart';
import '../patient_store.dart';
import '../design_system.dart';

class ProofOfDosePage extends StatelessWidget {
  final PatientStore store;
  const ProofOfDosePage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DemoTheme.background,
      appBar: AppBar(title: const Text('Proof of Dose'), backgroundColor: Colors.transparent, elevation: 0, foregroundColor: DemoTheme.ink),
      body: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(height: 300, decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), gradient: LinearGradient(colors: [Colors.black, Colors.blueGrey, Colors.indigo])), child: Center(child: Icon(store.proofStage == ProofStage.verified ? Icons.check_circle : Icons.medication, size: 80, color: Colors.white))),

        const SizedBox(height:16),
        SurfaceCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Proof controls', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height:8),
          DropdownButtonFormField<String>(value: store.proofMedicationName, items: store.patient.medications.map((m) => DropdownMenuItem(value: m.name, child: Text(m.name))).toList(), onChanged: (v) { if (v != null) { store.setProofMedicationName(v); } }),
          const SizedBox(height:8),
          Row(children: [ElevatedButton(onPressed: () { store.openProofCamera(); }, child: const Text('Open camera')), const SizedBox(width:8), ElevatedButton(onPressed: () { store.captureProof(); }, child: const Text('Capture')), const SizedBox(width:8), ElevatedButton(onPressed: () { store.verifyProof(); }, child: const Text('Verify'))])
        ])),

        const SizedBox(height:16),
        Row(children: [Expanded(child: MetricTile(title: 'Dose window', value: '20:00', subtitle: store.proofMedicationName, tint: DemoTheme.violet, icon: Icons.access_time)), const SizedBox(width:8), Expanded(child: MetricTile(title: 'Proof status', value: _proofStatusTitle(store), subtitle: 'Interactive demo flow', tint: DemoTheme.mint, icon: Icons.verified))])
      ])),
    );
  }

  static String _proofStatusTitle(PatientStore store) {
    switch (store.proofStage) {
      case ProofStage.ready:
        return 'Ready';
      case ProofStage.framing:
        return 'Framing';
      case ProofStage.captured:
        return 'Captured';
      case ProofStage.verified:
        return 'Verified';
    }
  }
}
