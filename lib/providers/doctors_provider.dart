import 'package:flutter/material.dart';
import 'package:meddoc/models/doctor_model.dart';
import 'package:meddoc/services/mock_data_service.dart';

/// Provider pour la gestion des médecins avec données mockées
class DoctorsProvider with ChangeNotifier {
  List<DoctorModel> _doctors = [];
  List<DoctorModel> _filteredDoctors = [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _selectedSpecialty;
  String? _searchQuery;

  List<DoctorModel> get doctors => _filteredDoctors;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get selectedSpecialty => _selectedSpecialty;
  String? get searchQuery => _searchQuery;

  DoctorsProvider() {
    loadDoctors();
  }

  /// Charger tous les médecins
  Future<void> loadDoctors() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _doctors = await MockDataService.getAllDoctors();
      _applyFilters();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Erreur lors du chargement des médecins: $e';
      notifyListeners();
    }
  }

  /// Rechercher des médecins
  Future<void> searchDoctors({String? specialty, String? name}) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _doctors = await MockDataService.searchDoctors(
        specialty: specialty,
        name: name,
      );
      _filteredDoctors = _doctors;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Erreur lors de la recherche: $e';
      notifyListeners();
    }
  }

  /// Filtrer par spécialité
  void filterBySpecialty(String? specialty) {
    _selectedSpecialty = specialty;
    _applyFilters();
    notifyListeners();
  }

  /// Rechercher par nom
  void searchByName(String? query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }

  /// Appliquer tous les filtres
  void _applyFilters() {
    _filteredDoctors = _doctors;

    if (_selectedSpecialty != null && _selectedSpecialty!.isNotEmpty) {
      _filteredDoctors = _filteredDoctors.where((doc) =>
        doc.specialty.toLowerCase().contains(_selectedSpecialty!.toLowerCase())
      ).toList();
    }

    if (_searchQuery != null && _searchQuery!.isNotEmpty) {
      _filteredDoctors = _filteredDoctors.where((doc) =>
        doc.fullName.toLowerCase().contains(_searchQuery!.toLowerCase()) ||
        doc.specialty.toLowerCase().contains(_searchQuery!.toLowerCase())
      ).toList();
    }
  }

  /// Réinitialiser les filtres
  void clearFilters() {
    _selectedSpecialty = null;
    _searchQuery = null;
    _applyFilters();
    notifyListeners();
  }

  /// Obtenir un médecin par ID
  Future<DoctorModel?> getDoctorById(String doctorId) async {
    try {
      return await MockDataService.getDoctorById(doctorId);
    } catch (e) {
      _errorMessage = 'Erreur lors de la récupération du médecin: $e';
      notifyListeners();
      return null;
    }
  }

  /// Obtenir la liste des spécialités
  List<String> getSpecialties() {
    return MockDataService.getSpecialties();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
