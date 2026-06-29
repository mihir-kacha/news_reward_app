part of 'model.dart';

abstract interface class UserModelFields {
  static const String id = 'id';
  static const String email = 'email';
  static const String name = 'name';
  static const String coins = 'coins';
  static const String createdAt = 'createdAt';
  static const String updatedAt = 'updatedAt';
  static const String referCode = 'referCode';
}

class UserModel {
  final String id;
  final String email;
  final String name;
  final int? coins;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? referCode;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.createdAt,
    this.updatedAt,
    this.coins,
    this.referCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'coins': coins,
      'createdAt': Timestamp.fromDate((createdAt ?? DateTime.now()).toUtc()),
      'updatedAt': Timestamp.fromDate((updatedAt ?? DateTime.now()).toUtc()),
      'referCode': referCode,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      coins: json['coins'],
      createdAt: json['createdAt'] != null ? (json['createdAt'] as Timestamp).toDate().toLocal() : null,
      updatedAt: json['updatedAt'] != null ? (json['updatedAt'] as Timestamp).toDate().toLocal() : null,
      referCode: json['referCode'],
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    int? coins,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? referCode,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      coins: coins ?? this.coins,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      referCode: referCode ?? this.referCode,
    );
  }
}
