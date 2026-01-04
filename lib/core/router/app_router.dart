import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meddoc/core/constants/app_routes.dart';
import 'package:meddoc/models/user_model.dart';
import 'package:meddoc/providers/auth_provider.dart';

// Import screens (to be created)
import 'package:meddoc/screens/auth/splash_screen.dart';
import 'package:meddoc/screens/auth/welcome_screen.dart';
import 'package:meddoc/screens/auth/login_screen.dart';
import 'package:meddoc/screens/auth/register_screen.dart';

// Patient screens
import 'package:meddoc/screens/patient/patient_home_screen.dart';
import 'package:meddoc/screens/patient/search_doctors_screen.dart';
import 'package:meddoc/screens/patient/patient_appointments_screen.dart';
import 'package:meddoc/screens/patient/patient_profile_screen.dart';
import 'package:meddoc/screens/patient/doctor_details_screen.dart';
import 'package:meddoc/screens/patient/book_appointment_screen.dart';
import 'package:meddoc/models/doctor_model.dart';

// Doctor screens
import 'package:meddoc/screens/doctor/doctor_home_screen.dart';
import 'package:meddoc/screens/doctor/doctor_schedule_screen.dart';
import 'package:meddoc/screens/doctor/doctor_appointments_screen.dart';
import 'package:meddoc/screens/doctor/doctor_profile_screen.dart';
import 'package:meddoc/screens/doctor/doctor_statistics_screen.dart';

class AppRouter {
  final AuthProvider authProvider;

  AppRouter(this.authProvider);

  late final GoRouter router = GoRouter(
    refreshListenable: authProvider,
    initialLocation: AppRoutes.splash,
    routes: [
      // Authentication Routes
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),

      // Patient Routes
      GoRoute(
        path: AppRoutes.patientHome,
        builder: (context, state) => const PatientHomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.searchDoctors,
        builder: (context, state) => const SearchDoctorsScreen(),
      ),
      GoRoute(
        path: AppRoutes.patientAppointments,
        builder: (context, state) => const PatientAppointmentsScreen(),
      ),
      GoRoute(
        path: AppRoutes.patientProfile,
        builder: (context, state) => const PatientProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.doctorDetails,
        builder: (context, state) {
          final doctor = state.extra as DoctorModel;
          return DoctorDetailsScreen(doctor: doctor);
        },
      ),
      GoRoute(
        path: AppRoutes.bookAppointment,
        builder: (context, state) {
          final doctor = state.extra as DoctorModel;
          return BookAppointmentScreen(doctor: doctor);
        },
      ),

      // Doctor Routes
      GoRoute(
        path: AppRoutes.doctorHome,
        builder: (context, state) => const DoctorHomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.doctorSchedule,
        builder: (context, state) => const DoctorScheduleScreen(),
      ),
      GoRoute(
        path: AppRoutes.doctorAppointments,
        builder: (context, state) => const DoctorAppointmentsScreen(),
      ),
      GoRoute(
        path: AppRoutes.doctorProfile,
        builder: (context, state) => const DoctorProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.doctorStatistics,
        builder: (context, state) => const DoctorStatisticsScreen(),
      ),
    ],
    redirect: (context, state) {
      final isAuthenticated = authProvider.isAuthenticated;
      final isOnAuthPage = state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.register ||
          state.matchedLocation == AppRoutes.welcome ||
          state.matchedLocation == AppRoutes.splash;

      if (!isAuthenticated && !isOnAuthPage) {
        return AppRoutes.welcome;
      }

      if (isAuthenticated && isOnAuthPage) {
        final userType = authProvider.currentUser?.userType;
        if (userType == UserType.doctor) {
          return AppRoutes.doctorHome;
        } else {
          return AppRoutes.patientHome;
        }
      }

      return null;
    },
  );
}
