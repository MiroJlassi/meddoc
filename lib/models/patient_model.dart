import 'package:meddoc/models/user_model.dart';

class PatientModel extends UserModel {
  DateTime? dateOfBirth;
  String? gender;
  String? bloodType;
  String? address;
  String? emergencyContactName;
  String? emergencyContactPhone;
  List<String> allergies;
  List<String> chronicDiseases;
  List<String> medications;
  String? insuranceProvider;
  String? insuranceNumber;

  PatientModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    super.phoneNumber,
    super.profileImageUrl,
    required super.createdAt,
    required super.updatedAt,
    this.dateOfBirth,
    this.gender,
    this.bloodType,
    this.address,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.allergies = const [],
    this.chronicDiseases = const [],
    this.medications = const [],
    this.insuranceProvider,
    this.insuranceNumber,
  }) : super(userType: UserType.patient);

  int? get age {
    if (dateOfBirth == null) return null;
    final now = DateTime.now();
    int age = now.year - dateOfBirth!.year;
    if (now.month < dateOfBirth!.month ||
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      age--;
    }
    return age;
  }

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'] as String)
          : null,
      gender: json['gender'] as String?,
      bloodType: json['bloodType'] as String?,
      address: json['address'] as String?,
      emergencyContactName: json['emergencyContactName'] as String?,
      emergencyContactPhone: json['emergencyContactPhone'] as String?,
      allergies: (json['allergies'] as List<dynamic>?)?.cast<String>() ?? [],
      chronicDiseases:
          (json['chronicDiseases'] as List<dynamic>?)?.cast<String>() ?? [],
      medications:
          (json['medications'] as List<dynamic>?)?.cast<String>() ?? [],
      insuranceProvider: json['insuranceProvider'] as String?,
      insuranceNumber: json['insuranceNumber'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'bloodType': bloodType,
      'address': address,
      'emergencyContactName': emergencyContactName,
      'emergencyContactPhone': emergencyContactPhone,
      'allergies': allergies,
      'chronicDiseases': chronicDiseases,
      'medications': medications,
      'insuranceProvider': insuranceProvider,
      'insuranceNumber': insuranceNumber,
    });
    return json;
  }
}
