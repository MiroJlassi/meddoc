import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meddoc/models/user_model.dart';
import 'package:meddoc/services/mock_data_service.dart';

/// Provider d'authentification avec données mockées
class AuthProvider with ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  AuthProvider() {
    _initAuth();
  }

  Future<void> _initAuth() async {
    // Vérifier si un utilisateur est déjà connecté
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('userEmail');
    if (email != null) {
      // Charger les données utilisateur depuis SharedPreferences
      await _loadUserFromPreferences();
    }
  }

  Future<void> _loadUserFromPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('userEmail');
      final id = prefs.getString('userId');
      final firstName = prefs.getString('firstName');
      final lastName = prefs.getString('lastName');
      final phoneNumber = prefs.getString('phoneNumber');
      final userTypeStr = prefs.getString('userType');

      if (email != null && id != null && firstName != null && lastName != null && userTypeStr != null) {
        final userType = userTypeStr == 'doctor' ? UserType.doctor : UserType.patient;

        _currentUser = UserModel(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          userType: userType,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Erreur lors du chargement des données utilisateur: $e';
      notifyListeners();
    }
  }

  Future<void> _saveUserToPreferences(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', user.id);
    await prefs.setString('userEmail', user.email);
    await prefs.setString('firstName', user.firstName);
    await prefs.setString('lastName', user.lastName);
    await prefs.setString('userType', user.userType.toString().split('.').last);
    if (user.phoneNumber != null) {
      await prefs.setString('phoneNumber', user.phoneNumber!);
    }
  }

  Future<bool> signInWithEmailPassword(String email, String password) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      // Utiliser le service mocké pour l'authentification
      final user = await MockDataService.mockLogin(email, password);

      if (user != null) {
        _currentUser = user;
        await _saveUserToPreferences(user);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        _errorMessage = 'E-mail ou mot de passe incorrect.';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Une erreur est survenue: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> registerWithEmailPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required UserType userType,
    String? phoneNumber,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      // Utiliser le service mocké pour l'inscription
      final user = await MockDataService.mockRegister(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        userType: userType,
        phoneNumber: phoneNumber,
      );

      if (user != null) {
        _currentUser = user;
        await _saveUserToPreferences(user);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        _errorMessage = 'Cet e-mail est déjà utilisé.';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Une erreur est survenue: $e';
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      _currentUser = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Erreur lors de la déconnexion: $e';
      notifyListeners();
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      // Simuler l'envoi d'un e-mail de réinitialisation
      await Future.delayed(const Duration(seconds: 1));

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Une erreur est survenue: $e';
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
