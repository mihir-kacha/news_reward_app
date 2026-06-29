part of 'model.dart';

abstract interface class ReferFriendDocumentFields {
  static const id = 'id';
  static const createdAt = 'created_at';
  static const updatedAt = 'updated_at';
  static const title = 'title';
  static const desc = 'desc';
  static const coins = 'coins';
  static const total = 'total';
  static const status = 'status';
}

class ReferFriendModel extends Equatable {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? title;
  final String? desc;
  final int? coins;
  final int? total;

  const ReferFriendModel({this.id, this.createdAt, this.updatedAt, this.title, this.desc, this.coins, this.total});

  @override
  List<Object?> get props => [id, createdAt, updatedAt, title, desc, coins, total];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt != null ? Timestamp.fromDate(createdAt!.toUtc()) : FieldValue.serverTimestamp(),
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!.toUtc()) : FieldValue.serverTimestamp(),
      'title': title,
      'desc': desc,
      'coins': coins ?? 0,
      'total': total ?? 0,
    };
  }

  factory ReferFriendModel.fromJson(Map<String, dynamic> map) {
    return ReferFriendModel(
      id: map['id'],
      createdAt: map['created_at'] != null ? (map['created_at'] as Timestamp).toDate().toLocal() : null,
      updatedAt: map['updated_at'] != null ? (map['updated_at'] as Timestamp).toDate().toLocal() : null,
      title: map['title'],
      desc: map['desc'],
      coins: map['coins'],
      total: map['total'],
    );
  }

  ReferFriendModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? title,
    String? desc,
    int? coins,
    int? total,
  }) {
    return ReferFriendModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      coins: coins ?? this.coins,
      total: total ?? this.total,
    );
  }
}
