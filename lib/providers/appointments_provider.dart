import 'package:flutter/material.dart';
import 'package:meddoc/models/appointment_model.dart';
import 'package:meddoc/services/mock_data_service.dart';

/// Provider pour la gestion des rendez-vous avec données mockées
class AppointmentsProvider with ChangeNotifier {
  List<AppointmentModel> _appointments = [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _userId;
  bool _isDoctor = false;

  List<AppointmentModel> get appointments => _appointments;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Rendez-vous à venir
  List<AppointmentModel> get upcomingAppointments {
    return _appointments
        .where((apt) => apt.isUpcoming && apt.status != AppointmentStatus.cancelled)
        .toList()
      ..sort((a, b) => a.scheduledDate.compareTo(b.scheduledDate));
  }

  /// Rendez-vous passés
  List<AppointmentModel> get pastAppointments {
    return _appointments
        .where((apt) => apt.isPast || apt.status == AppointmentStatus.completed)
        .toList()
      ..sort((a, b) => b.scheduledDate.compareTo(a.scheduledDate));
  }

  /// Rendez-vous en attente (pour médecins)
  List<AppointmentModel> get pendingAppointments {
    return _appointments
        .where((apt) => apt.status == AppointmentStatus.pending)
        .toList()
      ..sort((a, b) => a.scheduledDate.compareTo(b.scheduledDate));
  }

  /// Rendez-vous confirmés (pour médecins)
  List<AppointmentModel> get confirmedAppointments {
    return _appointments
        .where((apt) => apt.status == AppointmentStatus.confirmed)
        .toList()
      ..sort((a, b) => a.scheduledDate.compareTo(b.scheduledDate));
  }

  /// Rendez-vous du jour (pour médecins)
  List<AppointmentModel> get todayAppointments {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return _appointments
        .where((apt) {
          final aptDate = DateTime(
            apt.scheduledDate.year,
            apt.scheduledDate.month,
            apt.scheduledDate.day,
          );
          return aptDate == today && 
                 apt.status != AppointmentStatus.cancelled;
        })
        .toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  /// Charger les rendez-vous
  Future<void> loadAppointments({
    required String userId,
    required bool isDoctor,
  }) async {
    try {
      _userId = userId;
      _isDoctor = isDoctor;
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      if (isDoctor) {
        _appointments = await MockDataService.getDoctorAppointments(userId);
      } else {
        _appointments = await MockDataService.getPatientAppointments(userId);
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Erreur lors du chargement des rendez-vous: $e';
      notifyListeners();
    }
  }

  /// Créer un rendez-vous
  Future<bool> createAppointment(AppointmentModel appointment) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final newAppointment = await MockDataService.createAppointment(appointment);
      _appointments.add(newAppointment);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Erreur lors de la création du rendez-vous: $e';
      notifyListeners();
      return false;
    }
  }

  /// Confirmer un rendez-vous (pour médecins)
  Future<bool> confirmAppointment(String appointmentId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final index = _appointments.indexWhere((apt) => apt.id == appointmentId);
      if (index != -1) {
        final updatedAppointment = _appointments[index].copyWith(
          status: AppointmentStatus.confirmed,
          updatedAt: DateTime.now(),
        );
        await MockDataService.updateAppointment(updatedAppointment);
        _appointments[index] = updatedAppointment;
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Erreur lors de la confirmation: $e';
      notifyListeners();
      return false;
    }
  }

  /// Annuler un rendez-vous
  Future<bool> cancelAppointment(String appointmentId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final success = await MockDataService.cancelAppointment(appointmentId);
      if (success) {
        final index = _appointments.indexWhere((apt) => apt.id == appointmentId);
        if (index != -1) {
          _appointments[index] = _appointments[index].copyWith(
            status: AppointmentStatus.cancelled,
            updatedAt: DateTime.now(),
          );
        }
      }

      _isLoading = false;
      notifyListeners();
      return success;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Erreur lors de l\'annulation: $e';
      notifyListeners();
      return false;
    }
  }

  /// Marquer un rendez-vous comme terminé (pour médecins)
  Future<bool> completeAppointment(String appointmentId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final index = _appointments.indexWhere((apt) => apt.id == appointmentId);
      if (index != -1) {
        final updatedAppointment = _appointments[index].copyWith(
          status: AppointmentStatus.completed,
          updatedAt: DateTime.now(),
        );
        await MockDataService.updateAppointment(updatedAppointment);
        _appointments[index] = updatedAppointment;
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Erreur lors de la complétion: $e';
      notifyListeners();
      return false;
    }
  }

  /// Obtenir les rendez-vous par date (pour calendrier)
  List<AppointmentModel> getAppointmentsByDate(DateTime date) {
    final targetDate = DateTime(date.year, date.month, date.day);
    return _appointments.where((apt) {
      final aptDate = DateTime(
        apt.scheduledDate.year,
        apt.scheduledDate.month,
        apt.scheduledDate.day,
      );
      return aptDate == targetDate;
    }).toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  /// Recharger les rendez-vous
  Future<void> refresh() async {
    if (_userId != null) {
      await loadAppointments(userId: _userId!, isDoctor: _isDoctor);
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
