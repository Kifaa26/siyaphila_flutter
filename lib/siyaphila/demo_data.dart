import 'package:flutter/material.dart';
import 'models.dart';
import 'design_system.dart';

class DemoData {
  static final ayo = PatientProfile(
    id: 'ayo',
    name: 'Ayo Naidoo',
    age: 54,
    avatar: 'person',
    heroTitle: 'Risk is rising, but still reversible.',
    heroSubtitle: 'Ayo is one month into use with poor adherence, broken streaks, and visible evening-dose drift.',
    adherenceScore: 46,
    careScore: 54,
    engagementScore: 49,
    streak: 2,
    riskLevel: RiskLevel.high,
    followUpDate: '27 Apr',
    scriptRenewalDate: '24 Apr',
    coachInsight: 'Evening doses and weekends are the main drop-off points. Early refill prompts and earlier nudges could recover adherence fastest.',
    riskBanner: 'Risk rising • follow-up due soon',
    conditions: [
      Condition(name: 'Type 2 Diabetes', subtitle: 'HbA1c above target', icon: 'drop.fill', summary: 'Daily diabetes medication helps reduce long-term complications like kidney disease, vision loss, nerve damage, heart attack, and stroke.', careNote: 'Poor control may reflect missed medication rather than treatment failure.'),
      Condition(name: 'Hypertension', subtitle: 'Needs tighter control', icon: 'heart.fill', summary: 'Blood pressure medication works quietly in the background and lowers long-term risk even when the patient feels fine.', careNote: 'Repeated missed morning doses reduce day-to-day protection.'),
      Condition(name: 'Dyslipidaemia', subtitle: 'Cardiovascular risk reduction', icon: 'waveform.path.ecg', summary: 'Cholesterol treatment lowers future cardiovascular risk, especially alongside diabetes and hypertension treatment.', careNote: 'Evening dose behavior is currently the weakest adherence pattern.'),
    ],
    medications: [
      Medication(id: 'met', name: 'Metformin', dose: '1 g', schedule: 'Twice daily with meals', timing: '08:00 and 18:00', purpose: 'Glucose control', color: DemoTheme.blue),
      Medication(id: 'aml', name: 'Amlodipine', dose: '5 mg', schedule: 'Every morning', timing: '08:00', purpose: 'Blood pressure control', color: DemoTheme.coral),
      Medication(id: 'ato', name: 'Atorvastatin', dose: '20 mg', schedule: 'Every evening', timing: '20:00', purpose: 'Cholesterol lowering', color: const Color(0xFFF5B43C)),
    ],
    todayTasks: [
      MedicationTask(id: 't1', medicationName: 'Metformin', time: '08:00', context: 'With breakfast', status: TaskStatus.taken),
      MedicationTask(id: 't2', medicationName: 'Amlodipine', time: '08:00', context: 'Morning routine', status: TaskStatus.missed),
      MedicationTask(id: 't3', medicationName: 'Metformin', time: '18:00', context: 'With dinner', status: TaskStatus.due),
      MedicationTask(id: 't4', medicationName: 'Atorvastatin', time: '20:00', context: 'Evening routine', status: TaskStatus.due),
    ],
    adherenceDays: List.generate(30, (i) => DailyAdherence(id: 'd$i', day: i + 1, status: AdherenceStatus.values[i % AdherenceStatus.values.length])),
    nudges: [
      CoachNudge(id: 'n1', title: 'You missed 2 evening doses this week.', body: 'Take tonight’s medication to restart your streak and protect your heart risk plan.', tone: NudgeTone.alert),
      CoachNudge(id: 'n2', title: 'Your adherence has dropped this month.', body: 'The biggest pattern is on weekends and evenings. Linking doses to dinner may help.', tone: NudgeTone.coach),
      CoachNudge(id: 'n3', title: 'Your follow-up may be due soon.', body: 'Your clinician review is coming up. Logging this week consistently helps make that visit more useful.', tone: NudgeTone.support),
      CoachNudge(id: 'n4', title: 'Script renewal is almost due.', body: 'Renew now to avoid another gap in blood pressure and cholesterol treatment.', tone: NudgeTone.alert),
    ],
    timeline: [
      TimelineEvent(id: 'e1', title: 'Month 1 started', subtitle: 'Care plan and reminders activated', dateLabel: '24 Mar', status: TimelineStatus.complete),
      TimelineEvent(id: 'e2', title: 'Adherence drift detected', subtitle: 'Weekend and evening misses increased', dateLabel: '08 Apr', status: TimelineStatus.warning),
      TimelineEvent(id: 'e3', title: 'Script renewal due', subtitle: 'Atorvastatin and Amlodipine renewal approaching', dateLabel: '24 Apr', status: TimelineStatus.current),
      TimelineEvent(id: 'e4', title: 'Doctor follow-up', subtitle: 'Review disease control versus non-adherence', dateLabel: '27 Apr', status: TimelineStatus.upcoming),
    ],
    trend: [TrendPoint(id: 'w1', label: 'Week 1', value: 56), TrendPoint(id: 'w2', label: 'Week 2', value: 38), TrendPoint(id: 'w3', label: 'Week 3', value: 44), TrendPoint(id: 'w4', label: 'Week 4', value: 50)],
    barrierNotes: [BarrierNote(id: 'b1', title: 'Evening-dose drift', body: 'Repeated misses happen after work and on weekends.', severity: RiskLevel.high), BarrierNote(id: 'b2', title: 'Regimen burden', body: 'Three medications across morning and evening windows increases complexity.', severity: RiskLevel.rising)],
  );

  static final clinician = ClinicianSnapshot(
    clinicianName: 'Dr N. Govender',
    specialty: 'Chronic disease clinic',
    patientSummary: 'Ayo Naidoo presents with Type 2 Diabetes, Hypertension, and Dyslipidaemia. One month of app data suggests disease control may be compromised by non-adherence rather than medication failure.',
    diagnoses: [DiagnosisRecord(id: 'd1', name: 'Type 2 Diabetes', note: 'HbA1c above target'), DiagnosisRecord(id: 'd2', name: 'Hypertension', note: 'Blood pressure not yet controlled'), DiagnosisRecord(id: 'd3', name: 'Dyslipidaemia', note: 'Statin remains indicated')],
    prescriptions: [PrescriptionDraft(id: 'p1', medicationName: 'Metformin', dosage: '1 g', frequency: 'Twice daily with meals', scriptDuration: '30 days', followUpDate: '27 Apr'), PrescriptionDraft(id: 'p2', medicationName: 'Amlodipine', dosage: '5 mg', frequency: 'Every morning', scriptDuration: '30 days', followUpDate: '27 Apr'), PrescriptionDraft(id: 'p3', medicationName: 'Atorvastatin', dosage: '20 mg', frequency: 'Every evening', scriptDuration: '30 days', followUpDate: '27 Apr')],
    reviewSignals: [ReviewSignal(id: 'r1', title: 'Missed-dose pattern', detail: 'Misses cluster on weekends and evening doses.', severity: RiskLevel.high), ReviewSignal(id: 'r2', title: 'Renewal risk', detail: 'Script renewal is due within days and may worsen gaps if delayed.', severity: RiskLevel.rising)],
    assessment: 'Current app signals suggest that poor control may be at least partly driven by inconsistent medication behavior across all three conditions.',
    recommendation: 'Review barriers, reinforce regimen purpose, renew scripts, and reassess control after adherence recovery before labeling the regimen ineffective.'
  );

  static final lerato = PatientProfile(
    id: 'lerato',
    name: 'Lerato Mthembu',
    age: 61,
    avatar: 'person',
    heroTitle: 'Blood pressure is drifting upward.',
    heroSubtitle: 'Moderate adherence with script renewal friction and recent morning misses.',
    adherenceScore: 68,
    careScore: 63,
    engagementScore: 57,
    streak: 4,
    riskLevel: RiskLevel.rising,
    followUpDate: '29 Apr',
    scriptRenewalDate: '26 Apr',
    coachInsight: 'Most missed doses happen around early morning travel and refill timing.',
    riskBanner: 'Rising risk • renewal support needed',
    conditions: [Condition(name: 'Hypertension', subtitle: 'Above target', icon: 'heart.fill', summary: 'Blood pressure control still needs better daily consistency.', careNote: 'Morning misses appear to be the main driver.'), Condition(name: 'Type 2 Diabetes', subtitle: 'Borderline control', icon: 'drop.fill', summary: 'Glucose control is acceptable but vulnerable to further drift.', careNote: 'Do not intensify before checking adherence pattern.')],
    medications: [Medication(id: 'aml2', name: 'Amlodipine', dose: '10 mg', schedule: 'Every morning', timing: '07:00', purpose: 'Blood pressure control', color: DemoTheme.coral), Medication(id: 'met2', name: 'Metformin', dose: '500 mg', schedule: 'Twice daily with meals', timing: '07:00 and 18:00', purpose: 'Glucose control', color: DemoTheme.blue)],
    todayTasks: [MedicationTask(id: 'lt1', medicationName: 'Amlodipine', time: '07:00', context: 'Morning routine', status: TaskStatus.missed), MedicationTask(id: 'lt2', medicationName: 'Metformin', time: '18:00', context: 'With supper', status: TaskStatus.due)],
    adherenceDays: List.generate(30, (i) => DailyAdherence(id: 'l$i', day: i + 1, status: AdherenceStatus.values[i % AdherenceStatus.values.length])),
    nudges: [CoachNudge(id: 'ln1', title: 'Renew before Friday', body: 'Renewing before the weekend avoids another blood pressure treatment gap.', tone: NudgeTone.alert)],
    timeline: [TimelineEvent(id: 'lt_e1', title: 'Renewal support triggered', subtitle: 'Medication renewal reminder sent', dateLabel: '22 Apr', status: TimelineStatus.current)],
    trend: [TrendPoint(id: 'lt_w1', label: 'Week 1', value: 74), TrendPoint(id: 'lt_w2', label: 'Week 2', value: 70)],
    barrierNotes: [BarrierNote(id: 'lb1', title: 'Travel routine disruption', body: 'Morning commute appears to interrupt medication behavior.', severity: RiskLevel.rising)],
  );

  static final sibusiso = ayo; // simplified alias for demo

  static final naledi = ayo; // simplified alias for demo

  static final clinicianCases = [
    ClinicianCase(id: ayo.id, patient: ayo, snapshot: clinician, queueLabel: 'High priority'),
    ClinicianCase(id: lerato.id, patient: lerato, snapshot: clinician, queueLabel: 'Renewal watch')
  ];

  static final analytics = AnalyticsSnapshot(
    coveredLives: 1240,
    outreachQueueCount: 126,
    renewalRiskCount: 74,
    distribution: [DistributionPoint(id: 'd1', label: 'Stable', value: 702, color: RiskLevel.stable.color()), DistributionPoint(id: 'd2', label: 'Rising', value: 274, color: RiskLevel.rising.color()), DistributionPoint(id: 'd3', label: 'High', value: 181, color: RiskLevel.high.color()), DistributionPoint(id: 'd4', label: 'Critical', value: 83, color: RiskLevel.critical.color())],
    trends: [TrendPoint(id: 't1', label: 'Jan', value: 61), TrendPoint(id: 't2', label: 'Feb', value: 58), TrendPoint(id: 't3', label: 'Mar', value: 54), TrendPoint(id: 't4', label: 'Apr', value: 49)],
    outreachQueue: [OutreachMember(id: 'o1', name: 'Ayo Naidoo', condition: 'Diabetes • Hypertension • Dyslipidaemia', riskLevel: RiskLevel.high, adherenceScore: 46, refillRisk: 'Renewal due in 3 days', opportunity: 'R 18 400')],
    insights: [PopulationInsight(id: 'i1', title: 'Evening-dose behavior is the biggest drag on adherence.', detail: 'Across the population, evening statin and second-daily diabetes doses show the highest miss rate.', icon: 'moon.stars.fill')],
    predictiveInputs: [PredictiveNode(id: 'pn1', title: 'Diagnosis', subtitle: 'Diabetes, hypertension, dyslipidaemia', color: DemoTheme.blue)],
    predictiveOutputs: [PredictiveNode(id: 'po1', title: 'Risk of defaulting', subtitle: 'Who may stop treatment soon', color: const Color(0xFFFF7A59))],
    projectedSavings: 'R 1.84M',
    avoidableSpend: 'R 4.92M',
  );
}
