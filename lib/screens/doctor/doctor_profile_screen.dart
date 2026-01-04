import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meddoc/core/constants/app_colors.dart';
import 'package:meddoc/providers/auth_provider.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon profil professionnel'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit profile
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.primary,
                    child: Text(
                      user?.firstName[0].toUpperCase() ?? 'D',
                      style: const TextStyle(
                        fontSize: 40,
                        color: AppColors.textWhite,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: AppColors.textWhite,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Dr. ${user?.fullName ?? 'Docteur'}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Cardiologue',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                const Text(
                  '4.8',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '(245 avis)',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Professional Information
            _buildSectionTitle('Informations professionnelles'),
            _buildInfoCard([
              _buildInfoRow(Icons.medical_services, 'Spécialité', 'Cardiologie'),
              _buildInfoRow(Icons.school, 'Qualification', 'MD, PhD en Cardiologie'),
              _buildInfoRow(Icons.work, 'Expérience', '15 ans'),
              _buildInfoRow(Icons.badge, 'N° de licence', 'FR-12345-2010'),
            ]),

            const SizedBox(height: 24),

            // Clinic Information
            _buildSectionTitle('Cabinet médical'),
            _buildInfoCard([
              _buildInfoRow(Icons.business, 'Nom', 'Centre Cardiologique Paris'),
              _buildInfoRow(Icons.location_on, 'Adresse', '123 Rue de la Santé, Paris'),
              _buildInfoRow(Icons.phone, 'Téléphone', user?.phoneNumber ?? '+33 1 23 45 67 89'),
              _buildInfoRow(Icons.email, 'E-mail', user?.email ?? ''),
            ]),

            const SizedBox(height: 24),

            // Services & Fees
            _buildSectionTitle('Services et tarifs'),
            _buildInfoCard([
              _buildInfoRow(Icons.euro, 'Consultation en cabinet', '60€'),
              _buildInfoRow(Icons.video_call, 'Consultation vidéo', '50€'),
              _buildInfoRow(Icons.language, 'Langues parlées', 'Français, Anglais'),
            ]),

            const SizedBox(height: 24),

            // Bio
            _buildSectionTitle('Présentation'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'Cardiologue expérimenté avec plus de 15 ans de pratique. '
                  'Spécialisé dans le traitement des maladies cardiovasculaires et '
                  'la prévention. Diplômé de l\'Université Paris Descartes.',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 24,
            color: AppColors.primary,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
