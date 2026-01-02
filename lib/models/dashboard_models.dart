class DashboardStats {
  final int todayAppointments;
  final int upcomingConsultations;
  final int pendingRequests;
  final int totalPatients;

  DashboardStats({
    required this.todayAppointments,
    required this.upcomingConsultations,
    required this.pendingRequests,
    required this.totalPatients,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      todayAppointments: json['todayAppointments'] ?? 0,
      upcomingConsultations: json['upcomingConsultations'] ?? 0,
      pendingRequests: json['pendingRequests'] ?? 0,
      totalPatients: json['totalPatients'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'todayAppointments': todayAppointments,
      'upcomingConsultations': upcomingConsultations,
      'pendingRequests': pendingRequests,
      'totalPatients': totalPatients,
    };
  }
}

class EarningsSummary {
  final double dailyEarnings;
  final double monthlyEarnings;
  final double consultationEarnings;
  final double appointmentEarnings;

  EarningsSummary({
    required this.dailyEarnings,
    required this.monthlyEarnings,
    required this.consultationEarnings,
    required this.appointmentEarnings,
  });

  factory EarningsSummary.fromJson(Map<String, dynamic> json) {
    return EarningsSummary(
      dailyEarnings: (json['dailyEarnings'] ?? 0).toDouble(),
      monthlyEarnings: (json['monthlyEarnings'] ?? 0).toDouble(),
      consultationEarnings: (json['consultationEarnings'] ?? 0).toDouble(),
      appointmentEarnings: (json['appointmentEarnings'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dailyEarnings': dailyEarnings,
      'monthlyEarnings': monthlyEarnings,
      'consultationEarnings': consultationEarnings,
      'appointmentEarnings': appointmentEarnings,
    };
  }
}

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final NotificationType type;
  final bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    this.isRead = false,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      timestamp: DateTime.parse(json['timestamp']),
      type: NotificationType.values.firstWhere(
        (e) => e.toString() == 'NotificationType.${json['type']}',
        orElse: () => NotificationType.general,
      ),
      isRead: json['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'type': type.toString().split('.').last,
      'isRead': isRead,
    };
  }

  NotificationItem copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? timestamp,
    NotificationType? type,
    bool? isRead,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
    );
  }
}

enum NotificationType {
  appointment,
  consultation,
  payment,
  review,
  reminder,
  general,
}

class Appointment {
  final String id;
  final String patientName;
  final String patientId;
  final DateTime scheduledTime;
  final AppointmentType type;
  final AppointmentStatus status;
  final String? notes;

  Appointment({
    required this.id,
    required this.patientName,
    required this.patientId,
    required this.scheduledTime,
    required this.type,
    required this.status,
    this.notes,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] ?? '',
      patientName: json['patientName'] ?? '',
      patientId: json['patientId'] ?? '',
      scheduledTime: DateTime.parse(json['scheduledTime']),
      type: AppointmentType.values.firstWhere(
        (e) => e.toString() == 'AppointmentType.${json['type']}',
        orElse: () => AppointmentType.inPerson,
      ),
      status: AppointmentStatus.values.firstWhere(
        (e) => e.toString() == 'AppointmentStatus.${json['status']}',
        orElse: () => AppointmentStatus.pending,
      ),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientName': patientName,
      'patientId': patientId,
      'scheduledTime': scheduledTime.toIso8601String(),
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
      'notes': notes,
    };
  }
}

enum AppointmentType {
  inPerson,
  videoCall,
  phoneCall,
}

enum AppointmentStatus {
  pending,
  confirmed,
  completed,
  cancelled,
}

class Patient {
  final String id;
  final String name;
  final String email;
  final String phone;
  final DateTime? lastVisit;
  final int totalVisits;

  Patient({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.lastVisit,
    this.totalVisits = 0,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      lastVisit:
          json['lastVisit'] != null ? DateTime.parse(json['lastVisit']) : null,
      totalVisits: json['totalVisits'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'lastVisit': lastVisit?.toIso8601String(),
      'totalVisits': totalVisits,
    };
  }
}
