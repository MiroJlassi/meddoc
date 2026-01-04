class AppointmentModel {
  String id;
  String patientId;
  String doctorId;
  DateTime scheduledDate;
  String startTime;
  String endTime;
  AppointmentStatus status;
  AppointmentType type;
  String? reason;
  String? notes;
  String? prescription;
  String? diagnosis;
  double? fee;
  bool isPaid;
  DateTime createdAt;
  DateTime updatedAt;

  // Related objects (populated from joins)
  String? patientName;
  String? patientEmail;
  String? patientPhone;
  String? patientProfileImage;
  
  String? doctorName;
  String? doctorEmail;
  String? doctorSpecialty;
  String? doctorProfileImage;
  String? clinicName;
  String? clinicAddress;

  AppointmentModel({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.scheduledDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.type,
    this.reason,
    this.notes,
    this.prescription,
    this.diagnosis,
    this.fee,
    this.isPaid = false,
    required this.createdAt,
    required this.updatedAt,
    this.patientName,
    this.patientEmail,
    this.patientPhone,
    this.patientProfileImage,
    this.doctorName,
    this.doctorEmail,
    this.doctorSpecialty,
    this.doctorProfileImage,
    this.clinicName,
    this.clinicAddress,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] as String,
      patientId: json['patientId'] as String,
      doctorId: json['doctorId'] as String,
      scheduledDate: DateTime.parse(json['scheduledDate'] as String),
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      status: AppointmentStatus.values.firstWhere(
        (e) => e.toString() == 'AppointmentStatus.${json['status']}',
        orElse: () => AppointmentStatus.pending,
      ),
      type: AppointmentType.values.firstWhere(
        (e) => e.toString() == 'AppointmentType.${json['type']}',
        orElse: () => AppointmentType.inPerson,
      ),
      reason: json['reason'] as String?,
      notes: json['notes'] as String?,
      prescription: json['prescription'] as String?,
      diagnosis: json['diagnosis'] as String?,
      fee: (json['fee'] as num?)?.toDouble(),
      isPaid: json['isPaid'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      patientName: json['patientName'] as String?,
      patientEmail: json['patientEmail'] as String?,
      patientPhone: json['patientPhone'] as String?,
      patientProfileImage: json['patientProfileImage'] as String?,
      doctorName: json['doctorName'] as String?,
      doctorEmail: json['doctorEmail'] as String?,
      doctorSpecialty: json['doctorSpecialty'] as String?,
      doctorProfileImage: json['doctorProfileImage'] as String?,
      clinicName: json['clinicName'] as String?,
      clinicAddress: json['clinicAddress'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'scheduledDate': scheduledDate.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'status': status.toString().split('.').last,
      'type': type.toString().split('.').last,
      'reason': reason,
      'notes': notes,
      'prescription': prescription,
      'diagnosis': diagnosis,
      'fee': fee,
      'isPaid': isPaid,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  bool get isUpcoming {
    final now = DateTime.now();
    return scheduledDate.isAfter(now) && 
           (status == AppointmentStatus.confirmed || 
            status == AppointmentStatus.pending);
  }

  bool get isPast {
    final now = DateTime.now();
    return scheduledDate.isBefore(now) || 
           status == AppointmentStatus.completed;
  }

  AppointmentModel copyWith({
    String? id,
    String? patientId,
    String? doctorId,
    DateTime? scheduledDate,
    String? startTime,
    String? endTime,
    AppointmentStatus? status,
    AppointmentType? type,
    String? reason,
    String? notes,
    String? prescription,
    String? diagnosis,
    double? fee,
    bool? isPaid,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? patientName,
    String? patientEmail,
    String? patientPhone,
    String? patientProfileImage,
    String? doctorName,
    String? doctorEmail,
    String? doctorSpecialty,
    String? doctorProfileImage,
    String? clinicName,
    String? clinicAddress,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      doctorId: doctorId ?? this.doctorId,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      type: type ?? this.type,
      reason: reason ?? this.reason,
      notes: notes ?? this.notes,
      prescription: prescription ?? this.prescription,
      diagnosis: diagnosis ?? this.diagnosis,
      fee: fee ?? this.fee,
      isPaid: isPaid ?? this.isPaid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      patientName: patientName ?? this.patientName,
      patientEmail: patientEmail ?? this.patientEmail,
      patientPhone: patientPhone ?? this.patientPhone,
      patientProfileImage: patientProfileImage ?? this.patientProfileImage,
      doctorName: doctorName ?? this.doctorName,
      doctorEmail: doctorEmail ?? this.doctorEmail,
      doctorSpecialty: doctorSpecialty ?? this.doctorSpecialty,
      doctorProfileImage: doctorProfileImage ?? this.doctorProfileImage,
      clinicName: clinicName ?? this.clinicName,
      clinicAddress: clinicAddress ?? this.clinicAddress,
    );
  }
}

enum AppointmentStatus {
  pending,
  confirmed,
  cancelled,
  completed,
  noShow,
}

enum AppointmentType {
  inPerson,
  video,
}
