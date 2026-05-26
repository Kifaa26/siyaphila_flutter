import 'package:flutter/material.dart';
import 'models.dart';

enum ProofStage { ready, framing, captured, verified }

class PatientStore extends ChangeNotifier {
  final PatientProfile patient;

  final Map<String, TaskStatus> _taskStatuses = {};
  final Map<String, int> _loggedDoseCounts = {};
  ProofStage proofStage = ProofStage.ready;
  String proofMedicationName = '';
  bool proofUsingFrontCamera = false;
  final Set<String> _acknowledgedNudgeIDs = {};
  bool renewalReminderEnabled = true;
  bool followUpConfirmed = false;
  int selectedAdherenceDay = 1;

  PatientStore(this.patient) {
    for (var t in patient.todayTasks) {
      _taskStatuses[t.id] = t.status;
    }
    for (var m in patient.medications) {
      _loggedDoseCounts[m.id] = patient.todayTasks.where((t) => t.medicationName == m.name && _taskStatuses[t.id] == TaskStatus.taken).length;
    }
    proofMedicationName = patient.medications.isNotEmpty ? patient.medications.first.name : '';
    selectedAdherenceDay = patient.adherenceDays.isNotEmpty ? patient.adherenceDays.last.day : 1;
  }

  TaskStatus statusFor(MedicationTask task) => _taskStatuses[task.id] ?? task.status;

  void setStatus(MedicationTask task, TaskStatus newStatus) {
    final previous = statusFor(task);
    _taskStatuses[task.id] = newStatus;
    final medication = patient.medications.firstWhere((m) => m.name == task.medicationName, orElse: () => patient.medications.first);
    final currentCount = _loggedDoseCounts[medication.id] ?? 0;
    if (previous != TaskStatus.taken && newStatus == TaskStatus.taken) {
      _loggedDoseCounts[medication.id] = (currentCount + 1);
    } else if (previous == TaskStatus.taken && newStatus != TaskStatus.taken) {
      _loggedDoseCounts[medication.id] = (currentCount - 1).clamp(0, 999);
    }
    notifyListeners();
  }

  String noteFor(MedicationTask task) {
    final s = statusFor(task);
    switch (s) {
      case TaskStatus.taken:
        return proofStage == ProofStage.verified && task.medicationName == proofMedicationName ? 'Dose verified' : 'Dose logged';
      case TaskStatus.due:
        return 'Reminder queued';
      case TaskStatus.missed:
        return 'Needs attention';
    }
  }

  int dosesLoggedFor(Medication med) => _loggedDoseCounts[med.id] ?? 0;

  int doseTargetFor(Medication med) => max(1, patient.todayTasks.where((t) => t.medicationName == med.name).length);

  Medication? medicationForTask(MedicationTask task) {
    if (patient.medications.isEmpty) return null;
    return patient.medications.firstWhere((m) => m.name == task.medicationName, orElse: () => patient.medications.first);
  }

  MedicationTask? get nextPriorityTask {
    if (patient.todayTasks.isEmpty) return null;
    return patient.todayTasks.firstWhere((t) => statusFor(t) != TaskStatus.taken, orElse: () => patient.todayTasks.first);
  }

  int get takenTaskCount => patient.todayTasks.where((t) => statusFor(t) == TaskStatus.taken).length;
  int get dueTaskCount => patient.todayTasks.where((t) => statusFor(t) == TaskStatus.due).length;
  int get missedTaskCount => patient.todayTasks.where((t) => statusFor(t) == TaskStatus.missed).length;

  String get todayProgressText => '${takenTaskCount} of ${patient.todayTasks.length} completed';

  // Nudge helpers
  bool isAcknowledged(CoachNudge nudge) => _acknowledgedNudgeIDs.contains(nudge.id);

  void acknowledge(CoachNudge nudge) {
    _acknowledgedNudgeIDs.add(nudge.id);
    notifyListeners();
  }

  int get openNudgesCount => patient.nudges.where((n) => !_acknowledgedNudgeIDs.contains(n.id)).length;

  DailyAdherence? get selectedAdherenceEntry {
    if (patient.adherenceDays.isEmpty) return null;
    return patient.adherenceDays.firstWhere((d) => d.day == selectedAdherenceDay, orElse: () => patient.adherenceDays.first);
  }

  void selectAdherenceDay(int day) {
    selectedAdherenceDay = day;
    notifyListeners();
  }

  // Proof flow
  void openProofCameraFor(MedicationTask task) {
    proofMedicationName = task.medicationName;
    proofStage = ProofStage.framing;
    notifyListeners();
  }

  void openProofCamera() {
    proofStage = ProofStage.framing;
    notifyListeners();
  }

  void captureProof() {
    proofStage = ProofStage.captured;
    notifyListeners();
  }

  void verifyProof() {
    proofStage = ProofStage.verified;
    // mark as taken for matching medication task(s)
    for (var t in patient.todayTasks.where((t) => t.medicationName == proofMedicationName)) {
      _taskStatuses[t.id] = TaskStatus.taken;
    }
    notifyListeners();
  }

  void resetProof() {
    proofStage = ProofStage.ready;
    notifyListeners();
  }

  void setProofMedicationName(String name) {
    proofMedicationName = name;
    notifyListeners();
  }

  void toggleFollowUpConfirmed() {
    followUpConfirmed = !followUpConfirmed;
    notifyListeners();
  }
}

int max(int a, int b) => a > b ? a : b;
