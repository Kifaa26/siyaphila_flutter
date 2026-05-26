import 'package:flutter/material.dart';

enum DemoRole { patient, clinician, medicalAid }

class PatientProfile {
  final String id;
  final String name;
  final int age;
  final String avatar;
  final String heroTitle;
  final String heroSubtitle;
  final int adherenceScore;
  final int careScore;
  final int engagementScore;
  final int streak;
  final RiskLevel riskLevel;
  final String followUpDate;
  final String scriptRenewalDate;
  final String coachInsight;
  final String riskBanner;
  final List<Condition> conditions;
  final List<Medication> medications;
  final List<MedicationTask> todayTasks;
  final List<DailyAdherence> adherenceDays;
  final List<CoachNudge> nudges;
  final List<TimelineEvent> timeline;
  final List<TrendPoint> trend;
  final List<BarrierNote> barrierNotes;

  PatientProfile({required this.id, required this.name, required this.age, required this.avatar, required this.heroTitle, required this.heroSubtitle, required this.adherenceScore, required this.careScore, required this.engagementScore, required this.streak, required this.riskLevel, required this.followUpDate, required this.scriptRenewalDate, required this.coachInsight, required this.riskBanner, required this.conditions, required this.medications, required this.todayTasks, required this.adherenceDays, required this.nudges, required this.timeline, required this.trend, required this.barrierNotes});
}

class Condition {
  final String name;
  final String subtitle;
  final String icon;
  final String summary;
  final String careNote;
  Condition({required this.name, required this.subtitle, required this.icon, required this.summary, required this.careNote});
}

class Medication {
  final String id;
  final String name;
  final String dose;
  final String schedule;
  final String timing;
  final String purpose;
  final String howToTake;
  final String whyItMatters;
  final String patientExplanation;
  final Color color;
  Medication({required this.id, required this.name, required this.dose, required this.schedule, required this.timing, required this.purpose, this.howToTake = '', this.whyItMatters = '', this.patientExplanation = '', required this.color});
}

enum TaskStatus { taken, due, missed }

class MedicationTask {
  final String id;
  final String medicationName;
  final String time;
  final String context;
  TaskStatus status;
  MedicationTask({required this.id, required this.medicationName, required this.time, required this.context, required this.status});
}

class DailyAdherence {
  final String id;
  final int day;
  final AdherenceStatus status;
  DailyAdherence({required this.id, required this.day, required this.status});
}

enum AdherenceStatus { complete, partial, missed }

extension AdherenceStatusExt on AdherenceStatus {
  Color color() {
    switch (this) {
      case AdherenceStatus.complete:
        return const Color(0xFF31D27C);
      case AdherenceStatus.partial:
        return const Color(0xFFFFB648);
      case AdherenceStatus.missed:
        return const Color(0xFFFF6B63);
    }
  }

  String icon() {
    switch (this) {
      case AdherenceStatus.complete:
        return 'checkmark';
      case AdherenceStatus.partial:
        return 'minus';
      case AdherenceStatus.missed:
        return 'xmark';
    }
  }
}

class CoachNudge {
  final String id;
  final String title;
  final String body;
  final NudgeTone tone;
  CoachNudge({required this.id, required this.title, required this.body, required this.tone});
}

enum NudgeTone { alert, support, coach }

extension NudgeToneExt on NudgeTone {
  Color color() {
    switch (this) {
      case NudgeTone.alert:
        return const Color(0xFFFF7A59);
      case NudgeTone.support:
        return const Color(0xFF2F6BFF);
      case NudgeTone.coach:
        return const Color(0xFF7A63FF);
    }
  }

  String icon() {
    switch (this) {
      case NudgeTone.alert:
        return 'exclamationmark.triangle.fill';
      case NudgeTone.support:
        return 'heart.text.square.fill';
      case NudgeTone.coach:
        return 'sparkles';
    }
  }
}

class TimelineEvent {
  final String id;
  final String title;
  final String subtitle;
  final String dateLabel;
  final TimelineStatus status;
  TimelineEvent({required this.id, required this.title, required this.subtitle, required this.dateLabel, required this.status});
}

enum TimelineStatus { complete, current, upcoming, warning }

extension TimelineStatusExt on TimelineStatus {
  Color color() {
    switch (this) {
      case TimelineStatus.complete:
        return const Color(0xFF31D27C);
      case TimelineStatus.current:
        return const Color(0xFF2F6BFF);
      case TimelineStatus.upcoming:
        return const Color(0xFF7A63FF);
      case TimelineStatus.warning:
        return const Color(0xFFFF7A59);
    }
  }
}

class TrendPoint {
  final String id;
  final String label;
  final int value;
  TrendPoint({required this.id, required this.label, required this.value});
}

class BarrierNote {
  final String id;
  final String title;
  final String body;
  final RiskLevel severity;
  BarrierNote({required this.id, required this.title, required this.body, required this.severity});
}

enum RiskLevel { stable, rising, high, critical }

extension RiskLevelExt on RiskLevel {
  Color color() {
    switch (this) {
      case RiskLevel.stable:
        return const Color(0xFF31D27C);
      case RiskLevel.rising:
        return const Color(0xFFFFB648);
      case RiskLevel.high:
        return const Color(0xFFFF7A59);
      case RiskLevel.critical:
        return const Color(0xFFFF4D5E);
    }
  }

  String label() {
    return toString().split('.').last.toUpperCase();
  }
}

class ClinicianSnapshot {
  final String clinicianName;
  final String specialty;
  final String patientSummary;
  final List<DiagnosisRecord> diagnoses;
  final List<PrescriptionDraft> prescriptions;
  final List<ReviewSignal> reviewSignals;
  final String assessment;
  final String recommendation;
  ClinicianSnapshot({required this.clinicianName, required this.specialty, required this.patientSummary, required this.diagnoses, required this.prescriptions, required this.reviewSignals, required this.assessment, required this.recommendation});
}

class ClinicianCase {
  final String id;
  final PatientProfile patient;
  final ClinicianSnapshot snapshot;
  final String queueLabel;
  ClinicianCase({required this.id, required this.patient, required this.snapshot, required this.queueLabel});
}

class DiagnosisRecord { final String id; final String name; final String note; DiagnosisRecord({required this.id, required this.name, required this.note}); }
class PrescriptionDraft { final String id; final String medicationName; final String dosage; final String frequency; final String scriptDuration; final String followUpDate; PrescriptionDraft({required this.id, required this.medicationName, required this.dosage, required this.frequency, required this.scriptDuration, required this.followUpDate}); }
class ReviewSignal { final String id; final String title; final String detail; final RiskLevel severity; ReviewSignal({required this.id, required this.title, required this.detail, required this.severity}); }

class DistributionPoint { final String id; final String label; final int value; final Color color; DistributionPoint({required this.id, required this.label, required this.value, required this.color}); }
class OutreachMember { final String id; final String name; final String condition; final RiskLevel riskLevel; final int adherenceScore; final String refillRisk; final String opportunity; OutreachMember({required this.id, required this.name, required this.condition, required this.riskLevel, required this.adherenceScore, required this.refillRisk, required this.opportunity}); }
class PopulationInsight { final String id; final String title; final String detail; final String icon; PopulationInsight({required this.id, required this.title, required this.detail, required this.icon}); }
class PredictiveNode { final String id; final String title; final String subtitle; final Color color; PredictiveNode({required this.id, required this.title, required this.subtitle, required this.color}); }

class AnalyticsSnapshot {
  final int coveredLives;
  final int outreachQueueCount;
  final int renewalRiskCount;
  final List<DistributionPoint> distribution;
  final List<TrendPoint> trends;
  final List<OutreachMember> outreachQueue;
  final List<PopulationInsight> insights;
  final List<PredictiveNode> predictiveInputs;
  final List<PredictiveNode> predictiveOutputs;
  final String projectedSavings;
  final String avoidableSpend;

  AnalyticsSnapshot({required this.coveredLives, required this.outreachQueueCount, required this.renewalRiskCount, required this.distribution, required this.trends, required this.outreachQueue, required this.insights, required this.predictiveInputs, required this.predictiveOutputs, required this.projectedSavings, required this.avoidableSpend});
}
