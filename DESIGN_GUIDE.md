# 🎨 OxyZen Home Screen - Design Guide

## Color Palette

Each medical specialty has its own unique color theme for easy visual identification:

| Specialty | Color Code | Theme |
|-----------|------------|-------|
| General Physician | `#E3F2FD` | Light Blue |
| Pediatrician | `#FCE4EC` | Pink |
| Gynecologist | `#F3E5F5` | Purple |
| Dermatologist | `#E0F2F1` | Teal |
| Orthopedic | `#FFF9C4` | Yellow |
| ENT Specialist | `#E1F5FE` | Cyan |
| Cardiologist | `#FFEBEE` | Red |
| Diabetologist | `#F1F8E9` | Light Green |
| Psychiatrist | `#E8EAF6` | Indigo |
| Psychologist | `#FFF3E0` | Orange |
| Nutritionist | `#E8F5E9` | Green |
| Neurologist | `#F3E5F5` | Purple |
| Pulmonologist | `#E0F7FA` | Cyan |
| Gastroenterologist | `#FFF8E1` | Amber |
| Urologist | `#E1F5FE` | Light Blue |
| Oncologist | `#FCE4EC` | Pink |
| Ophthalmologist | `#E8EAF6` | Indigo |
| Dentist | `#F1F8E9` | Light Green |

## Screen Components

### 1. Header Section
```
┌─────────────────────────────────────┐
│ OxyZen                    [Profile] │
│ Your Health, Our Priority           │
│ ┌─────────────────────────────────┐ │
│ │ 🔍 Search doctors, clinics...   │ │
│ └─────────────────────────────────┘ │
└─────────────────────────────────────┘
```

### 2. Quick Services Row
```
┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐
│ 📹   │  │ 🏥   │  │ 🧪   │  │ 💊   │
│Video │  │Find  │  │Lab   │  │Surge-│
│Conslt│  │Doctors│  │Tests │  │ries  │
└──────┘  └──────┘  └──────┘  └──────┘
```

### 3. Specialty Grid (2 columns)
```
┌─────────────────┐  ┌─────────────────┐
│ 🩺              │  │ 👶              │
│ General         │  │ Pediatrician    │
│ Physician       │  │                 │
│ • Fever, cold   │  │ • Child health  │
│ • Headache      │  │ • Vaccination   │
│ +1 more         │  │ +1 more         │
└─────────────────┘  └─────────────────┘
```

## Interactive Elements

### Tap Actions:
1. **Search Bar**: Opens keyboard, filters in real-time
2. **Quick Service Buttons**: Navigate to respective services
3. **Specialty Cards**: Open detailed specialty view
4. **Profile Icon**: User profile/settings
5. **View All Button**: Show all specialties

### Visual Feedback:
- **Hover Effect**: Subtle shadow increase
- **Tap Effect**: Material ripple animation
- **Loading States**: Circular progress indicator
- **Empty States**: "No specialties found" with icon

## Specialty Detail Screen

### Layout:
```
┌─────────────────────────────────────┐
│ ← [Specialty Name]                  │
│                                     │
│         ┌─────────┐                 │
│         │  🩺     │                 │
│         │  Icon   │                 │
│         └─────────┘                 │
├─────────────────────────────────────┤
│ About [Specialty]                   │
│ [Description text...]               │
├─────────────────────────────────────┤
│ Common Conditions & Services        │
│ ✅ Service 1                        │
│ ✅ Service 2                        │
│ ✅ Service 3                        │
├─────────────────────────────────────┤
│ [Video Consult] [Book Appointment]  │
│ [Find Doctors Near You]             │
├─────────────────────────────────────┤
│ 💡 Health Tips                      │
│ [Helpful information...]            │
└─────────────────────────────────────┘
```

## Typography

### Font Family: Inter (Google Fonts)

| Element | Size | Weight | Color |
|---------|------|--------|-------|
| App Title | 28px | Bold | Blue 700 |
| Section Headers | 18-20px | Bold | Grey 800 |
| Specialty Names | 15px | Bold | Grey 800 |
| Body Text | 15px | Regular | Grey 700 |
| Small Text | 11-14px | Regular | Grey 600 |
| Hints | 14px | Regular | Grey 400 |

## Spacing Guidelines

- **Screen Padding**: 20px horizontal
- **Card Spacing**: 16px gap
- **Element Spacing**: 8-12px internal
- **Section Margins**: 24px vertical
- **Button Padding**: 16px vertical

## Responsive Behavior

### Grid Adaptation:
- **Small screens**: 2 columns (default)
- **Tablets**: Can adjust to 3 columns
- **Large screens**: Maximum 4 columns

### Text Overflow:
- **Specialty names**: 2 lines max, ellipsis
- **Services**: 1 line max, ellipsis
- **Descriptions**: Full text on detail screen

## Animation Timings

- **Search filter**: Instant (0ms)
- **Navigation**: 300ms curve
- **Card tap**: 150ms spring
- **Dialog**: 200ms fade in
- **Ripple**: 300ms spread

## Accessibility Features

1. **High Contrast**: All text meets WCAG AA standards
2. **Touch Targets**: Minimum 48x48dp
3. **Clear Labels**: Descriptive text for all buttons
4. **Logical Flow**: Top-to-bottom, left-to-right
5. **Error Messages**: Clear and actionable

## Best Practices

### When Adding New Specialties:
1. Choose a color that isn't too similar to existing ones
2. Use appropriate emoji or icon
3. List 2-4 key services
4. Keep name concise (2-3 words max)
5. Ensure color has good contrast with text

### Search Optimization:
- Include common condition names in services
- Use clear, non-medical terms when possible
- Add abbreviations where relevant (e.g., PCOS, ENT)

### Performance:
- All colors are pre-defined hex codes
- Icons load instantly (emoji-based)
- No external image dependencies
- Smooth scrolling with GridView

## Code Snippets

### Adding a New Specialty:
```dart
MedicalSpecialty(
  id: '19',
  name: 'Your Specialty',
  icon: '⚕️',
  color: '#E8F5E9',
  services: [
    'Service 1',
    'Service 2',
    'Service 3'
  ],
),
```

### Changing App Theme Color:
```dart
// In home_screen.dart
Colors.blue.shade700  // Change to your color
```

### Customizing Card Layout:
```dart
// In GridView.builder
childAspectRatio: 0.85,  // Adjust height/width ratio
crossAxisCount: 2,        // Number of columns
```

## Testing Checklist

- [ ] Search filters all specialties correctly
- [ ] All specialty cards are tappable
- [ ] Detail screen shows all services
- [ ] Back navigation works properly
- [ ] Buttons show appropriate dialogs
- [ ] Colors are visually distinct
- [ ] Text doesn't overflow
- [ ] Smooth scrolling performance
- [ ] Works on different screen sizes

---

**Happy Designing! 🎨**
