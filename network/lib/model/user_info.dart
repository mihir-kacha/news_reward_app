part of 'model.dart';

class UserInfo extends Equatable {
  final String name;
  final String email;
  final int coins;

  const UserInfo({
    required this.name,
    required this.email,
    required this.coins,
  });

  const UserInfo.unknown()
    : name = "unknown",
      email = 'unknown',
      coins = 0;

  @override
  List<Object?> get props => [name, email, coins];

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'coins': coins};
  }

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      name: json['name'],
      email: json['email'],
      coins: json['coins'],
    );
  }

  UserInfo copyWith({String? name, String? email, int? coins, String? language, String? currency}) {
    return UserInfo(
      name: name ?? this.name,
      email: email ?? this.email,
      coins: coins ?? this.coins,
    );
  }
}

extension $UserDocumentExt on UserModel {
  UserInfo toGeneralInfo() {
    return UserInfo(name: name, email: email, coins: coins ?? 0);
  }
}
