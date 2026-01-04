class AppRoutes {
  // Authentication
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  
  // Patient Routes
  static const String patientHome = '/patient/home';
  static const String patientProfile = '/patient/profile';
  static const String patientAppointments = '/patient/appointments';
  static const String patientMedicalRecords = '/patient/medical-records';
  static const String searchDoctors = '/patient/search-doctors';
  static const String doctorDetails = '/patient/doctor-details';
  static const String bookAppointment = '/patient/book-appointment';
  static const String patientVideoCall = '/patient/video-call';
  
  // Doctor Routes
  static const String doctorHome = '/doctor/home';
  static const String doctorProfile = '/doctor/profile';
  static const String doctorSchedule = '/doctor/schedule';
  static const String doctorAppointments = '/doctor/appointments';
  static const String patientDetails = '/doctor/patient-details';
  static const String doctorStatistics = '/doctor/statistics';
  static const String doctorVideoCall = '/doctor/video-call';
  
  // Common Routes
  static const String notifications = '/notifications';
  static const String settings = '/settings';
  static const String chat = '/chat';
}
