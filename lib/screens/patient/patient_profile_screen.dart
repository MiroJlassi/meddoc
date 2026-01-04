import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meddoc/core/constants/app_colors.dart';
import 'package:meddoc/providers/auth_provider.dart';

class PatientProfileScreen extends StatelessWidget {
  const PatientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon profil'),
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
                      user?.firstName[0].toUpperCase() ?? 'P',
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
            const SizedBox(height: 24),

            // Personal Information
            _buildSectionTitle('Informations personnelles'),
            _buildInfoCard([
              _buildInfoRow(Icons.person, 'Nom complet', user?.fullName ?? ''),
              _buildInfoRow(Icons.email, 'E-mail', user?.email ?? ''),
              _buildInfoRow(Icons.phone, 'Téléphone', user?.phoneNumber ?? 'Non renseigné'),
              _buildInfoRow(Icons.cake, 'Date de naissance', 'Non renseigné'),
              _buildInfoRow(Icons.wc, 'Genre', 'Non renseigné'),
            ]),

            const SizedBox(height: 24),

            // Medical Information
            _buildSectionTitle('Informations médicales'),
            _buildInfoCard([
              _buildInfoRow(Icons.bloodtype, 'Groupe sanguin', 'Non renseigné'),
              _buildInfoRow(Icons.favorite, 'Allergies', 'Aucune'),
              _buildInfoRow(Icons.medical_information, 'Maladies chroniques', 'Aucune'),
            ]),

            const SizedBox(height: 24),

            // Emergency Contact
            _buildSectionTitle('Contact d\'urgence'),
            _buildInfoCard([
              _buildInfoRow(Icons.person_outline, 'Nom', 'Non renseigné'),
              _buildInfoRow(Icons.phone_outlined, 'Téléphone', 'Non renseigné'),
            ]),

            const SizedBox(height: 24),

            // Insurance
            _buildSectionTitle('Assurance'),
            _buildInfoCard([
              _buildInfoRow(Icons.account_balance, 'Assureur', 'Non renseigné'),
              _buildInfoRow(Icons.credit_card, 'Numéro de police', 'Non renseigné'),
            ]),

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
