part of 'model.dart';

abstract interface class ReferralsDocumentFiled {
  static const id = 'id';
  static const createdAt = 'created_at';
  static const referTo = 'refer_to';
  static const referBy = 'refer_by';
  static const referralStatus = 'referral_status';
}

class ReferralsDocument extends Equatable {
  final String? id;
  final DateTime? createdAt;
  final String? referTo;
  final String? referBy;

  const ReferralsDocument({this.id, this.createdAt, this.referTo, this.referBy});

  @override
  List<Object?> get props => [id, createdAt, referTo, referBy];

  Map<String, dynamic> toJson() {
    return {
      'created_at': (createdAt ?? DateTime.now()).toUtc().toIso8601String(),
      'refer_to': referTo,
      'refer_by': referBy,
    };
  }

  factory ReferralsDocument.fromJson(Map<String, dynamic> map) {
    return ReferralsDocument(
      id: map['id'],
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']).toLocal() : null,
      referTo: map['refer_to'],
      referBy: map['refer_by'],
    );
  }

  ReferralsDocument copyWith({String? id, DateTime? createdAt, String? referTo, String? referBy}) {
    return ReferralsDocument(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      referTo: referTo ?? this.referTo,
      referBy: referBy ?? this.referBy,
    );
  }
}
