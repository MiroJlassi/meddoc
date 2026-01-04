# MedDoc - Application de Gestion Médicale

Application Flutter pour la gestion des rendez-vous médicaux entre patients et médecins.

## Besoins Fonctionnels

### Authentification
- Connexion patient/médecin avec email et mot de passe
- Inscription avec choix du type d'utilisateur
- Gestion de session utilisateur

### Fonctionnalités Patient
- Recherche de médecins par nom et spécialité
- Consultation du profil complet d'un médecin
- Prise de rendez-vous (en cabinet ou en vidéo)
- Visualisation des rendez-vous à venir
- Consultation de l'historique des rendez-vous
- Annulation de rendez-vous

### Fonctionnalités Médecin
- Visualisation du tableau de bord avec statistiques
- Gestion des rendez-vous (confirmés, en attente)
- Consultation de l'agenda journalier
- Gestion du profil médical

## Besoins Non-Fonctionnels

### Performance
- Chargement des données en moins de 2 secondes
- Interface réactive et fluide
- Gestion efficace de l'état avec Provider

### Sécurité
- Authentification sécurisée
- Validation des données côté client
- Séparation des rôles patient/médecin

### Utilisabilité
- Interface intuitive et moderne
- Navigation simple et claire
- Messages d'erreur explicites
- Feedback visuel pour les actions utilisateur

### Maintenabilité
- Code structuré et modulaire
- Architecture propre (Clean Architecture)
- Séparation des responsabilités
- Documentation du code

## Modèles de Données

### UserModel (Abstract)
```dart
- id: String
- email: String
- firstName: String
- lastName: String
- phoneNumber: String?
- userType: UserType (patient/doctor)
- createdAt: DateTime
- updatedAt: DateTime
```

### PatientModel (extends UserModel)
```dart
- dateOfBirth: DateTime?
- gender: String?
- address: String?
- bloodType: String?
- allergies: List<String>
- chronicDiseases: List<String>
- emergencyContactName: String?
- emergencyContactPhone: String?
- insuranceProvider: String?
- insuranceNumber: String?
```

### DoctorModel (extends UserModel)
```dart
- specialty: String
- qualification: String
- licenseNumber: String
- yearsOfExperience: int
- clinicName: String
- clinicAddress: String
- latitude: double?
- longitude: double?
- bio: String?
- consultationFee: double
- rating: double
- totalReviews: int
- workingHours: List<WorkingHours>
- languages: List<String>
```

### AppointmentModel
```dart
- id: String
- patientId: String
- doctorId: String
- scheduledDate: DateTime
- startTime: String
- endTime: String
- status: AppointmentStatus (pending/confirmed/completed/cancelled)
- type: AppointmentType (inPerson/video)
- reason: String?
- notes: String?
- fee: double?
- isPaid: bool
- createdAt: DateTime
- updatedAt: DateTime
- patientName: String?
- doctorName: String?
- doctorSpecialty: String?
```

## Architecture

### Structure des Dossiers
```
lib/
├── core/
│   ├── constants/         # Constantes (routes, couleurs)
│   ├── router/           # Configuration GoRouter
│   └── theme/            # Thème de l'application
├── models/               # Modèles de données
├── providers/            # Gestion d'état (Provider)
├── screens/             # Écrans de l'application
│   ├── auth/           # Authentification
│   ├── patient/        # Fonctionnalités patient
│   └── doctor/         # Fonctionnalités médecin
└── services/           # Services (mock data)
```

### Patterns Utilisés
- **Provider Pattern**: Gestion d'état réactive
- **Repository Pattern**: Abstraction de la source de données
- **Factory Pattern**: Création d'instances de modèles
- **Observer Pattern**: Notification des changements d'état

### Flux de Données
1. **UI Layer** (Screens) → Affiche les données et capture les interactions
2. **Provider Layer** → Gère l'état et la logique métier
3. **Service Layer** → Gère l'accès aux données (actuellement mock, prêt pour API)
4. **Model Layer** → Définit la structure des données

### Gestion d'État
- **AuthProvider**: Authentification et utilisateur courant
- **DoctorsProvider**: Liste et recherche de médecins
- **AppointmentsProvider**: Gestion des rendez-vous
- Utilisation de `notifyListeners()` pour mettre à jour l'UI

### Navigation
- **GoRouter**: Routing déclaratif avec redirections
- Routes organisées par rôle (patient/doctor)
- Protection des routes selon l'authentification
- Passage de paramètres via `extra`

## Comptes de Test

### Patient
- Email: `patient@test.com`
- Mot de passe: `patient123`
- Nom: Marie Dubois

### Médecins
1. **Médecin Généraliste**
   - Email: `doctor@test.com`
   - Mot de passe: `doctor123`
   - Nom: Dr. Pierre Martin

2. **Cardiologue**
   - Email: `cardiologue@test.com`
   - Mot de passe: `doctor456`
   - Nom: Dr. Sophie Lefebvre

## Démarrage

```bash
# Installer les dépendances
flutter pub get

# Lancer l'application
flutter run

# Choisir la plateforme
# [1]: Windows
# [2]: Chrome
# [3]: Edge
```

## Technologies

- **Flutter** 3.x
- **Dart** 3.x
- **Provider** - Gestion d'état
- **GoRouter** - Navigation
- **Intl** - Internationalisation et dates

## État Actuel

✅ Authentification patient/médecin
✅ Recherche de médecins
✅ Consultation de profils médecins
✅ Prise de rendez-vous
✅ Visualisation des rendez-vous
✅ Annulation de rendez-vous
✅ Données en mémoire (mock)
✅ Interface responsive

🚧 À venir:
- Reprogrammation de rendez-vous
- Intégration API backend
- Consultation vidéo
- Notifications
- Gestion des documents médicaux
