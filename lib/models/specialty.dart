class MedicalSpecialty {
  final String id;
  final String name;
  final String icon;
  final List<String> services;
  final String color;

  MedicalSpecialty({
    required this.id,
    required this.name,
    required this.icon,
    required this.services,
    required this.color,
  });
}

final List<MedicalSpecialty> medicalSpecialties = [
  MedicalSpecialty(
    id: '1',
    name: 'General Physician',
    icon: '🩺',
    color: '#E3F2FD',
    services: [
      'Fever, cold, cough',
      'Headache, weakness',
      'First diagnosis & referrals'
    ],
  ),
  MedicalSpecialty(
    id: '2',
    name: 'Pediatrician',
    icon: '👶',
    color: '#FCE4EC',
    services: [
      'Child & infant health',
      'Vaccination advice',
      'Growth & nutrition'
    ],
  ),
  MedicalSpecialty(
    id: '3',
    name: 'Gynecologist',
    icon: '👩‍⚕️',
    color: '#F3E5F5',
    services: ['Women\'s health', 'Pregnancy & PCOS', 'Menstrual problems'],
  ),
  MedicalSpecialty(
    id: '4',
    name: 'Dermatologist',
    icon: '💆',
    color: '#E0F2F1',
    services: ['Skin problems', 'Hair fall, acne', 'Allergies & infections'],
  ),
  MedicalSpecialty(
    id: '5',
    name: 'Orthopedic',
    icon: '🦴',
    color: '#FFF9C4',
    services: ['Bone & joint pain', 'Back pain, arthritis', 'Sports injuries'],
  ),
  MedicalSpecialty(
    id: '6',
    name: 'ENT Specialist',
    icon: '👂',
    color: '#E1F5FE',
    services: [
      'Ear pain, hearing issues',
      'Throat infection',
      'Sinus & voice problems'
    ],
  ),
  MedicalSpecialty(
    id: '7',
    name: 'Cardiologist',
    icon: '❤️',
    color: '#FFEBEE',
    services: ['Heart problems', 'Blood pressure', 'Chest pain'],
  ),
  MedicalSpecialty(
    id: '8',
    name: 'Diabetologist',
    icon: '💉',
    color: '#F1F8E9',
    services: ['Diabetes management', 'Thyroid issues', 'Hormonal disorders'],
  ),
  MedicalSpecialty(
    id: '9',
    name: 'Psychiatrist',
    icon: '🧠',
    color: '#E8EAF6',
    services: [
      'Depression, anxiety',
      'Stress & sleep issues',
      'Medication support'
    ],
  ),
  MedicalSpecialty(
    id: '10',
    name: 'Psychologist',
    icon: '🗣️',
    color: '#FFF3E0',
    services: [
      'Mental health therapy',
      'Relationship & career stress',
      'Addiction counseling'
    ],
  ),
  MedicalSpecialty(
    id: '11',
    name: 'Nutritionist',
    icon: '🥗',
    color: '#E8F5E9',
    services: ['Weight loss/gain', 'Diabetes diet', 'Lifestyle management'],
  ),
  MedicalSpecialty(
    id: '12',
    name: 'Neurologist',
    icon: '🧬',
    color: '#F3E5F5',
    services: ['Migraine', 'Epilepsy', 'Nerve disorders'],
  ),
  MedicalSpecialty(
    id: '13',
    name: 'Pulmonologist',
    icon: '🫁',
    color: '#E0F7FA',
    services: ['Asthma', 'Breathing issues', 'Post-COVID care'],
  ),
  MedicalSpecialty(
    id: '14',
    name: 'Gastroenterologist',
    icon: '🔬',
    color: '#FFF8E1',
    services: ['Acidity, ulcers', 'Liver problems', 'Digestion issues'],
  ),
  MedicalSpecialty(
    id: '15',
    name: 'Urologist',
    icon: '🩹',
    color: '#E1F5FE',
    services: ['Urine infection', 'Kidney stones', 'Male health'],
  ),
  MedicalSpecialty(
    id: '16',
    name: 'Oncologist',
    icon: '🎗️',
    color: '#FCE4EC',
    services: ['Cancer second opinion', 'Treatment guidance'],
  ),
  MedicalSpecialty(
    id: '17',
    name: 'Ophthalmologist',
    icon: '👁️',
    color: '#E8EAF6',
    services: ['Eye infection', 'Vision problems'],
  ),
  MedicalSpecialty(
    id: '18',
    name: 'Dentist',
    icon: '🦷',
    color: '#F1F8E9',
    services: ['Tooth pain', 'Gum issues'],
  ),
];
