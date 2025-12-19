# OxyZen - Healthcare App

## 🏥 Interactive Home Page with Medical Specialties

Your complete healthcare solution with an intuitive and interactive interface.

## ✨ New Features

### 🎯 Interactive Home Screen
- **Modern Design**: Clean, professional UI inspired by leading healthcare apps
- **Search Functionality**: Quickly find specialists and services
- **18 Medical Specialties**: Comprehensive coverage of medical fields
- **Quick Access Services**: Video consultation, find doctors, lab tests, and surgeries

### 🔍 Smart Search
- Real-time search across all specialties
- Search by specialty name or condition
- Instant results as you type

### 📋 Medical Specialties Covered

1. **General Physician (MBBS)** - Fever, cold, cough, headache, weakness, first diagnosis & referrals
2. **Pediatrician** - Child & infant health, vaccination advice, growth & nutrition
3. **Gynecologist** - Women's health, pregnancy & PCOS, menstrual problems
4. **Dermatologist** - Skin problems, hair fall, acne, allergies & infections
5. **Orthopedic** - Bone & joint pain, back pain, arthritis, sports injuries
6. **ENT Specialist** - Ear pain, hearing issues, throat infection, sinus & voice problems
7. **Cardiologist** - Heart problems, blood pressure, chest pain
8. **Diabetologist** - Diabetes management, thyroid issues, hormonal disorders
9. **Psychiatrist** - Depression, anxiety, stress & sleep issues, medication support
10. **Psychologist** - Mental health therapy, relationship & career stress, addiction counseling
11. **Nutritionist** - Weight loss/gain, diabetes diet, lifestyle management
12. **Neurologist** - Migraine, epilepsy, nerve disorders
13. **Pulmonologist** - Asthma, breathing issues, post-COVID care
14. **Gastroenterologist** - Acidity, ulcers, liver problems, digestion issues
15. **Urologist** - Urine infection, kidney stones, male health
16. **Oncologist** - Cancer second opinion, treatment guidance
17. **Ophthalmologist** - Eye infection, vision problems
18. **Dentist** - Tooth pain, gum issues

## 🎨 UI/UX Features

### Home Screen
- **Gradient Header**: Beautiful gradient background with branding
- **Search Bar**: Prominent search with clear functionality
- **Quick Services**: Four main service buttons for instant access
- **Specialty Grid**: Color-coded cards for each medical specialty
- **Visual Icons**: Emoji icons for easy recognition
- **Service Preview**: Each card shows top services offered

### Specialty Detail Screen
- **Expandable Header**: Large specialty icon with gradient background
- **Detailed Information**: Comprehensive description of each specialty
- **Service List**: All conditions and services covered
- **Action Buttons**: 
  - Video Consultation
  - Book Appointment
  - Find Doctors Near You
- **Health Tips**: Helpful information for patients
- **Interactive Dialogs**: Smooth booking flow

## 🚀 Getting Started

### Prerequisites
```bash
flutter --version
# Flutter 3.0.0 or higher
```

### Installation
```bash
# Clone the repository
git clone https://github.com/Monoartiam99/OxyZen-KGEC.git

# Navigate to project
cd Oxygen-app

# Get dependencies
flutter pub get

# Run the app
flutter run
```

## 📱 Navigation Flow

```
App Launch
    ↓
Onboarding Screen
    ↓
Login / Sign Up
    ↓
Home Screen (Medical Specialties)
    ↓
Specialty Detail Screen
    ↓
Book Appointment / Video Consult
```

## 🎯 Key Components

### Models
- **MedicalSpecialty**: Data model for specialty information
  - ID, Name, Icon, Services, Color
  - Pre-configured with 18 specialties

### Screens
- **HomeScreen**: Main dashboard with search and specialty grid
- **SpecialtyDetailScreen**: Detailed view of each specialty
- **LoginScreen**: User authentication (updated to navigate to home)
- **SignUpScreen**: User registration (updated to navigate to home)

### Features
- **Real-time Search**: Filter specialties as you type
- **Color-coded Cards**: Each specialty has a unique color theme
- **Responsive Design**: Adapts to different screen sizes
- **Smooth Animations**: Material Design transitions
- **Interactive Elements**: Tap feedback and hover states

## 🔧 Technical Details

### Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^5.0.0
  flutter_svg: ^1.1.6
```

### File Structure
```
lib/
├── main.dart
├── models/
│   └── specialty.dart
└── screens/
    ├── home_screen.dart
    ├── specialty_detail_screen.dart
    ├── login_screen.dart
    ├── sign_up_screen.dart
    └── app_onboarding_screen.dart
```

## 🎨 Design Principles

1. **User-Centric**: Easy navigation and clear information hierarchy
2. **Visual Clarity**: Color coding and icons for quick recognition
3. **Accessibility**: High contrast, readable fonts, clear CTAs
4. **Consistency**: Unified design language across all screens
5. **Performance**: Smooth animations and fast load times

## 🔮 Future Enhancements

- [ ] Doctor profiles and ratings
- [ ] Real-time video consultation
- [ ] Appointment booking system
- [ ] Medical records management
- [ ] Prescription tracking
- [ ] Medicine reminders
- [ ] Health tips and articles
- [ ] Emergency services
- [ ] Insurance integration
- [ ] Multi-language support

## 📸 Screenshots

*Coming soon - The new home screen features:*
- Interactive specialty cards with color themes
- Smart search functionality
- Quick access service buttons
- Detailed specialty information pages

## 👨‍💻 Development

### To add a new specialty:
1. Open `lib/models/specialty.dart`
2. Add a new `MedicalSpecialty` object to the list
3. Specify: id, name, icon, color, and services
4. The UI will automatically update!

### To customize colors:
Each specialty card uses a hex color code. Modify the `color` property in the specialty model.

## 📄 License

This project is part of the OxyZen-KGEC healthcare initiative.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📧 Contact

For any queries or suggestions, please reach out to the development team.

---

**Made with ❤️ for better healthcare access**
