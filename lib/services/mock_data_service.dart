import 'package:meddoc/models/user_model.dart';
import 'package:meddoc/models/patient_model.dart';
import 'package:meddoc/models/doctor_model.dart';
import 'package:meddoc/models/appointment_model.dart';

/// Service pour les données mockées (démonstration)
class MockDataService {
  // Utilisateurs de test
  static final Map<String, Map<String, dynamic>> _mockUsers = {
    'patient@test.com': {
      'password': 'patient123',
      'user': PatientModel(
        id: 'patient_001',
        email: 'patient@test.com',
        firstName: 'Marie',
        lastName: 'Dubois',
        phoneNumber: '+33612345678',
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now(),
        dateOfBirth: DateTime(1990, 5, 15),
        gender: 'Féminin',
        address: '123 Rue de la Santé, 75014 Paris',
        bloodType: 'O+',
        allergies: const ['Pénicilline', 'Pollen'],
        chronicDiseases: const [],
        emergencyContactName: 'Jean Dubois',
        emergencyContactPhone: '+33698765432',
        insuranceProvider: 'Mutuelle Santé Plus',
        insuranceNumber: 'MSP123456789',
      ),
    },
    'doctor@test.com': {
      'password': 'doctor123',
      'user': DoctorModel(
        id: 'doctor_001',
        email: 'doctor@test.com',
        firstName: 'Dr. Pierre',
        lastName: 'Martin',
        phoneNumber: '+33687654321',
        createdAt: DateTime.now().subtract(const Duration(days: 365)),
        updatedAt: DateTime.now(),
        specialty: 'Médecin Généraliste',
        qualification: 'Doctorat en Médecine, Université Paris Descartes',
        licenseNumber: 'MED-FR-2015-12345',
        yearsOfExperience: 8,
        clinicName: 'Cabinet Médical Saint-Michel',
        clinicAddress: '45 Avenue des Champs-Élysées, 75008 Paris',
        latitude: 48.8698,
        longitude: 2.3077,
        bio: 'Médecin généraliste passionné avec 8 ans d\'expérience.',
        consultationFee: 50.0,
        rating: 4.8,
        totalReviews: 156,
        workingHours: [
          WorkingHours(dayOfWeek: 'Lundi', startTime: '09:00', endTime: '18:00'),
          WorkingHours(dayOfWeek: 'Mardi', startTime: '09:00', endTime: '18:00'),
          WorkingHours(dayOfWeek: 'Mercredi', startTime: '09:00', endTime: '12:00'),
          WorkingHours(dayOfWeek: 'Jeudi', startTime: '09:00', endTime: '18:00'),
          WorkingHours(dayOfWeek: 'Vendredi', startTime: '09:00', endTime: '17:00'),
        ],
        languages: const ['Français', 'Anglais', 'Espagnol'],
      ),
    },
    'cardiologue@test.com': {
      'password': 'doctor456',
      'user': DoctorModel(
        id: 'doctor_002',
        email: 'cardiologue@test.com',
        firstName: 'Dr. Sophie',
        lastName: 'Lefebvre',
        phoneNumber: '+33698765432',
        createdAt: DateTime.now().subtract(const Duration(days: 730)),
        updatedAt: DateTime.now(),
        specialty: 'Cardiologue',
        qualification: 'Doctorat en Cardiologie, Université Lyon 1',
        licenseNumber: 'MED-FR-2012-67890',
        yearsOfExperience: 12,
        clinicName: 'Centre Cardiologique de Paris',
        clinicAddress: '78 Rue de Rivoli, 75001 Paris',
        latitude: 48.8566,
        longitude: 2.3522,
        bio: 'Cardiologue expérimentée spécialisée dans les maladies cardiovasculaires.',
        consultationFee: 80.0,
        rating: 4.9,
        totalReviews: 243,
        workingHours: [
          WorkingHours(dayOfWeek: 'Lundi', startTime: '08:00', endTime: '17:00'),
          WorkingHours(dayOfWeek: 'Mardi', startTime: '08:00', endTime: '17:00'),
          WorkingHours(dayOfWeek: 'Mercredi', startTime: '08:00', endTime: '17:00'),
          WorkingHours(dayOfWeek: 'Jeudi', startTime: '08:00', endTime: '17:00'),
          WorkingHours(dayOfWeek: 'Vendredi', startTime: '08:00', endTime: '15:00'),
        ],
        languages: const ['Français', 'Anglais'],
      ),
    },
  };

  // Liste de médecins mockés
  static final List<DoctorModel> _mockDoctors = [
    DoctorModel(
      id: 'doctor_001',
      email: 'doctor@test.com',
      firstName: 'Dr. Pierre',
      lastName: 'Martin',
      phoneNumber: '+33687654321',
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
      updatedAt: DateTime.now(),
      specialty: 'Médecin Généraliste',
      qualification: 'Doctorat en Médecine, Université Paris Descartes',
      licenseNumber: 'MED-FR-2015-12345',
      yearsOfExperience: 8,
      clinicName: 'Cabinet Médical Saint-Michel',
      clinicAddress: '45 Avenue des Champs-Élysées, 75008 Paris',
      latitude: 48.8698,
      longitude: 2.3077,
      bio: 'Médecin généraliste passionné avec 8 ans d\'expérience.',
      consultationFee: 50.0,
      rating: 4.8,
      totalReviews: 156,
      workingHours: [
        WorkingHours(dayOfWeek: 'Lundi', startTime: '09:00', endTime: '18:00'),
        WorkingHours(dayOfWeek: 'Mardi', startTime: '09:00', endTime: '18:00'),
        WorkingHours(dayOfWeek: 'Mercredi', startTime: '09:00', endTime: '12:00'),
        WorkingHours(dayOfWeek: 'Jeudi', startTime: '09:00', endTime: '18:00'),
        WorkingHours(dayOfWeek: 'Vendredi', startTime: '09:00', endTime: '17:00'),
      ],
      languages: const ['Français', 'Anglais', 'Espagnol'],
    ),
    DoctorModel(
      id: 'doctor_002',
      email: 'cardiologue@test.com',
      firstName: 'Dr. Sophie',
      lastName: 'Lefebvre',
      phoneNumber: '+33698765432',
      createdAt: DateTime.now().subtract(const Duration(days: 730)),
      updatedAt: DateTime.now(),
      specialty: 'Cardiologue',
      qualification: 'Doctorat en Cardiologie, Université Lyon 1',
      licenseNumber: 'MED-FR-2012-67890',
      yearsOfExperience: 12,
      clinicName: 'Centre Cardiologique de Paris',
      clinicAddress: '78 Rue de Rivoli, 75001 Paris',
      latitude: 48.8566,
      longitude: 2.3522,
      bio: 'Cardiologue expérimentée spécialisée dans les maladies cardiovasculaires.',
      consultationFee: 80.0,
      rating: 4.9,
      totalReviews: 243,
      workingHours: [
        WorkingHours(dayOfWeek: 'Lundi', startTime: '08:00', endTime: '17:00'),
        WorkingHours(dayOfWeek: 'Mardi', startTime: '08:00', endTime: '17:00'),
        WorkingHours(dayOfWeek: 'Mercredi', startTime: '08:00', endTime: '17:00'),
        WorkingHours(dayOfWeek: 'Jeudi', startTime: '08:00', endTime: '17:00'),
        WorkingHours(dayOfWeek: 'Vendredi', startTime: '08:00', endTime: '15:00'),
      ],
      languages: const ['Français', 'Anglais'],
    ),
  ];

  // Rendez-vous mockés
  static final List<AppointmentModel> _mockAppointments = [
    // Rendez-vous pour patient_001 (Marie Dubois)
    AppointmentModel(
      id: 'apt_001',
      patientId: 'patient_001',
      doctorId: 'doctor_001',
      patientName: 'Marie Dubois',
      doctorName: 'Dr. Pierre Martin',
      doctorSpecialty: 'Médecin Généraliste',
      scheduledDate: DateTime.now().add(const Duration(days: 2)),
      startTime: '10:00',
      endTime: '10:30',
      status: AppointmentStatus.confirmed,
      type: AppointmentType.inPerson,
      reason: 'Consultation de contrôle',
      notes: 'Suivi annuel',
      fee: 50.0,
      isPaid: true,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    AppointmentModel(
      id: 'apt_002',
      patientId: 'patient_001',
      doctorId: 'doctor_002',
      patientName: 'Marie Dubois',
      doctorName: 'Dr. Sophie Lefebvre',
      doctorSpecialty: 'Cardiologue',
      scheduledDate: DateTime.now().add(const Duration(days: 7)),
      startTime: '14:00',
      endTime: '14:45',
      status: AppointmentStatus.pending,
      type: AppointmentType.inPerson,
      reason: 'Consultation cardiologique',
      notes: 'Première consultation',
      fee: 80.0,
      isPaid: false,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    AppointmentModel(
      id: 'apt_003',
      patientId: 'patient_001',
      doctorId: 'doctor_001',
      patientName: 'Marie Dubois',
      doctorName: 'Dr. Pierre Martin',
      doctorSpecialty: 'Médecin Généraliste',
      scheduledDate: DateTime.now().subtract(const Duration(days: 30)),
      startTime: '11:00',
      endTime: '11:30',
      status: AppointmentStatus.completed,
      type: AppointmentType.inPerson,
      reason: 'Consultation générale',
      notes: 'Résultats d\'analyses normaux',
      fee: 50.0,
      isPaid: true,
      createdAt: DateTime.now().subtract(const Duration(days: 35)),
      updatedAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
  ];

  // Méthodes d'authentification mockées
  static Future<UserModel?> mockLogin(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    final userData = _mockUsers[email];
    if (userData != null && userData['password'] == password) {
      return userData['user'] as UserModel;
    }
    return null;
  }

  static Future<UserModel?> mockRegister({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required UserType userType,
    String? phoneNumber,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    if (_mockUsers.containsKey(email)) {
      return null;
    }

    final newUser = userType == UserType.patient
        ? PatientModel(
            id: 'patient_${DateTime.now().millisecondsSinceEpoch}',
            email: email,
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          )
        : DoctorModel(
            id: 'doctor_${DateTime.now().millisecondsSinceEpoch}',
            email: email,
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            specialty: 'Non spécifié',
            qualification: 'À compléter',
            licenseNumber: 'TEMP-${DateTime.now().millisecondsSinceEpoch}',
            yearsOfExperience: 0,
            clinicName: 'Cabinet non renseigné',
            clinicAddress: 'Adresse non renseignée',
            latitude: 48.8566,
            longitude: 2.3522,
            consultationFee: 50.0,
            workingHours: const [],
            languages: const ['Français'],
          );

    _mockUsers[email] = {'password': password, 'user': newUser};
    return newUser;
  }

  static Future<List<DoctorModel>> getAllDoctors() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_mockDoctors);
  }

  static Future<List<DoctorModel>> searchDoctors({
    String? specialty,
    String? name,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    var results = List<DoctorModel>.from(_mockDoctors);

    if (specialty != null && specialty.isNotEmpty) {
      results = results
          .where(
              (doc) => doc.specialty.toLowerCase().contains(specialty.toLowerCase()))
          .toList();
    }

    if (name != null && name.isNotEmpty) {
      results = results
          .where((doc) => doc.fullName.toLowerCase().contains(name.toLowerCase()))
          .toList();
    }

    return results;
  }

  static Future<List<AppointmentModel>> getPatientAppointments(
      String patientId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockAppointments.where((apt) => apt.patientId == patientId).toList();
  }

  static Future<List<AppointmentModel>> getDoctorAppointments(
      String doctorId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockAppointments.where((apt) => apt.doctorId == doctorId).toList();
  }

  static Future<AppointmentModel> createAppointment(
      AppointmentModel appointment) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mockAppointments.add(appointment);
    return appointment;
  }

  static Future<AppointmentModel> updateAppointment(
      AppointmentModel appointment) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index =
        _mockAppointments.indexWhere((apt) => apt.id == appointment.id);
    if (index != -1) {
      _mockAppointments[index] = appointment;
    }
    return appointment;
  }

  static Future<bool> cancelAppointment(String appointmentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockAppointments.indexWhere((apt) => apt.id == appointmentId);
    if (index != -1) {
      _mockAppointments[index] = _mockAppointments[index].copyWith(
        status: AppointmentStatus.cancelled,
        updatedAt: DateTime.now(),
      );
      return true;
    }
    return false;
  }

  static Future<DoctorModel?> getDoctorById(String doctorId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _mockDoctors.firstWhere((doc) => doc.id == doctorId);
    } catch (e) {
      return null;
    }
  }

  static List<String> getSpecialties() {
    return _mockDoctors.map((doc) => doc.specialty).toSet().toList()..sort();
  }
}
