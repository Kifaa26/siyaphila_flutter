import 'package:flutter/material.dart';
import '../design_system.dart';
import '../demo_data.dart';
import 'dashboard_view.dart';
import 'clinician_views.dart';
import 'medical_aid_views.dart';
import '../pitch_navigator.dart';

class ContentView extends StatelessWidget {
  const ContentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DemoTheme.background,
      body: Stack(children: [
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              GradientHeroCard(colors: [DemoTheme.ink, DemoTheme.blue, DemoTheme.violet], child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(height:8),
                StatusChip(title: 'Chronic medication management', color: Colors.white, icon: Icons.health_and_safety),
                const SizedBox(height:12),
                const Text('One ecosystem.\nThree connected views.', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height:8),
                const Text('Show how clinician prescribing, patient adherence, and medical-aid analytics connect into one AI-powered chronic disease platform.', style: TextStyle(color: Colors.white70))
              ])),

              const SizedBox(height:20),
              const Text('Select a role', style: TextStyle(fontSize:18, fontWeight: FontWeight.bold)),
              const SizedBox(height:8),
              RoleCard(title: 'Patient App', subtitle: 'Conditions, medications, adherence, AI coach, and follow-up plan.', color: DemoTheme.coral, icon: Icons.favorite, onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => PatientRootPage(patient: DemoData.ayo)));
              }),
              const SizedBox(height:12),
              RoleCard(title: 'Clinician Dashboard', subtitle: 'Diagnosis, prescribing, adherence review, and non-adherence insight.', color: DemoTheme.blue, icon: Icons.medical_services, onTap: () { Navigator.of(context).push(MaterialPageRoute(builder: (_) => ClinicianRootPage())); }),
              const SizedBox(height:12),
              RoleCard(title: 'Medical Aid Analytics', subtitle: 'Population risk, avoidable spend, outreach, and predictive care signals.', color: DemoTheme.mint, icon: Icons.pie_chart, onTap: () { Navigator.of(context).push(MaterialPageRoute(builder: (_) => MedicalAidRootPage())); }),
            ]),
          ),
        ),
        const PitchDemoController()
      ]),
    );
  }
}

class GradientHeroCard extends StatelessWidget {
  final List<Color> colors;
  final Widget child;
  const GradientHeroCard({Key? key, required this.colors, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      decoration: BoxDecoration(gradient: LinearGradient(colors: colors), borderRadius: BorderRadius.circular(34), boxShadow: [BoxShadow(color: colors.first.withOpacity(0.24), blurRadius: 24, offset: const Offset(0,16))]),
      child: child,
    );
  }
}

class RoleCard extends StatelessWidget {
  final String title; final String subtitle; final Color color; final IconData icon; final VoidCallback onTap;
  const RoleCard({Key? key, required this.title, required this.subtitle, required this.color, required this.icon, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(gradient: LinearGradient(colors: [color.withOpacity(0.9), color]), borderRadius: BorderRadius.circular(32)),
        child: Row(children: [
          CircleAvatar(backgroundColor: Colors.white24, child: Icon(icon, color: Colors.white)),
          const SizedBox(width:12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), Text(subtitle, style: const TextStyle(color: Colors.white70))])),
          const Icon(Icons.arrow_forward_ios, color: Colors.white)
        ]),
      ),
    );
  }
}
