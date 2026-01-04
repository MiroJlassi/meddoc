import 'package:meddoc/models/user_model.dart';

class DoctorModel extends UserModel {
  String specialty;
  String qualification;
  int yearsOfExperience;
  String licenseNumber;
  String clinicName;
  String clinicAddress;
  double latitude;
  double longitude;
  String? bio;
  double rating;
  int totalReviews;
  double consultationFee;
  List<String> languages;
  List<WorkingHours> workingHours;
  bool isAvailableForVideoCall;

  DoctorModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    super.phoneNumber,
    super.profileImageUrl,
    required super.createdAt,
    required super.updatedAt,
    required this.specialty,
    required this.qualification,
    required this.yearsOfExperience,
    required this.licenseNumber,
    required this.clinicName,
    required this.clinicAddress,
    required this.latitude,
    required this.longitude,
    this.bio,
    this.rating = 0.0,
    this.totalReviews = 0,
    required this.consultationFee,
    required this.languages,
    required this.workingHours,
    this.isAvailableForVideoCall = false,
  }) : super(userType: UserType.doctor);

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      specialty: json['specialty'] as String,
      qualification: json['qualification'] as String,
      yearsOfExperience: json['yearsOfExperience'] as int,
      licenseNumber: json['licenseNumber'] as String,
      clinicName: json['clinicName'] as String,
      clinicAddress: json['clinicAddress'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      bio: json['bio'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalReviews: json['totalReviews'] as int? ?? 0,
      consultationFee: (json['consultationFee'] as num).toDouble(),
      languages: (json['languages'] as List<dynamic>).cast<String>(),
      workingHours: (json['workingHours'] as List<dynamic>)
          .map((e) => WorkingHours.fromJson(e as Map<String, dynamic>))
          .toList(),
      isAvailableForVideoCall: json['isAvailableForVideoCall'] as bool? ?? false,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'specialty': specialty,
      'qualification': qualification,
      'yearsOfExperience': yearsOfExperience,
      'licenseNumber': licenseNumber,
      'clinicName': clinicName,
      'clinicAddress': clinicAddress,
      'latitude': latitude,
      'longitude': longitude,
      'bio': bio,
      'rating': rating,
      'totalReviews': totalReviews,
      'consultationFee': consultationFee,
      'languages': languages,
      'workingHours': workingHours.map((e) => e.toJson()).toList(),
      'isAvailableForVideoCall': isAvailableForVideoCall,
    });
    return json;
  }
}

class WorkingHours {
  String dayOfWeek;
  String startTime;
  String endTime;
  bool isAvailable;

  WorkingHours({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.isAvailable = true,
  });

  // Helper constructor avec dayName (deprecated, utilisez dayOfWeek)
  factory WorkingHours.withDayName({
    required int dayOfWeek,
    required String dayName,
    required String startTime,
    required String endTime,
    bool isAvailable = true,
  }) {
    return WorkingHours(
      dayOfWeek: dayName,
      startTime: startTime,
      endTime: endTime,
      isAvailable: isAvailable,
    );
  }

  factory WorkingHours.fromJson(Map<String, dynamic> json) {
    return WorkingHours(
      dayOfWeek: json['dayOfWeek'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      isAvailable: json['isAvailable'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayOfWeek': dayOfWeek,
      'startTime': startTime,
      'endTime': endTime,
      'isAvailable': isAvailable,
    };
  }
}
