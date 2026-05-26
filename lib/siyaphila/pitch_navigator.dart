import 'package:flutter/material.dart';
import 'screens/dashboard_view.dart';
import 'screens/clinician_views.dart';
import 'screens/medical_aid_views.dart';
import 'demo_data.dart';

class PitchDemoController extends StatefulWidget {
  const PitchDemoController({Key? key}) : super(key: key);

  @override
  State<PitchDemoController> createState() => _PitchDemoControllerState();
}

class _PitchDemoControllerState extends State<PitchDemoController> {
  int current = 0;

  final steps = [
    {'title': 'Ayo: patient risk', 'role': 'patient'},
    {'title': 'Medication literacy', 'role': 'patient'},
    {'title': 'Adherence slipping', 'role': 'patient'},
    {'title': 'Clinician decision support', 'role': 'clinician'},
    {'title': 'Medical-aid intelligence', 'role': 'medical'},
  ];

  void applyStep(BuildContext ctx, Map step) {
    final role = step['role'];
    if (role == 'patient') {
      Navigator.of(ctx).push(MaterialPageRoute(builder: (_) => PatientRootPage(patient: DemoData.ayo)));
    } else if (role == 'clinician') {
      Navigator.of(ctx).push(MaterialPageRoute(builder: (_) => ClinicianRootPage()));
    } else {
      Navigator.of(ctx).push(MaterialPageRoute(builder: (_) => MedicalAidRootPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 88,
      right: 14,
      child: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (ctx) {
              return ListView.builder(
                itemCount: steps.length,
                itemBuilder: (c, i) {
                  return ListTile(
                    title: Text(steps[i]['title']!),
                    onTap: () {
                      Navigator.of(context).pop();
                      setState(() {
                        current = i;
                      });
                      applyStep(context, steps[i]);
                    },
                  );
                },
              );
            },
          );
        },
        label: Text('Pitch ${current + 1}/${steps.length}'),
      ),
    );
  }
}
