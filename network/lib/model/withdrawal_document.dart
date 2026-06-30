part of 'model.dart';

class WithdrawalsFields {
  static const id = 'id';
  static const createdAt = 'created_at';
  static const claimedBy = 'claimed_by';
  static const withdrawCoin = 'withdrawer_coin';
  static const withdrawAmount = 'currency_amount';
  static const paymentId = 'payment_id';
  static const currencyCode = 'currency_code';
}

class WithdrawalsDocument extends Equatable {
  final String? id;
  final DateTime? createdAt;
  final String? claimedBy;
  final int? withdrawCoin;
  final String? withdrawAmount;
  final String? currencyCode;
  final String? paymentId;

  const WithdrawalsDocument({
    this.id,
    this.createdAt,
    this.claimedBy,
    this.withdrawCoin,
    this.withdrawAmount,
    this.paymentId,
    this.currencyCode,
  });

  @override
  List<Object?> get props => [id, createdAt, claimedBy, withdrawCoin, withdrawAmount, paymentId, currencyCode];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt != null ? Timestamp.fromDate(createdAt!.toUtc()) : FieldValue.serverTimestamp(),
      'claimed_by': claimedBy,
      'withdraw_coin': withdrawCoin,
      'currency_amount': withdrawAmount,
      'payment_id': paymentId,
      'currency_code': currencyCode,
    };
  }

  factory WithdrawalsDocument.fromJson(Map<String, dynamic> map) {
    return WithdrawalsDocument(
      id: map['id'],
      createdAt: map['created_at'] != null ? (map['created_at'] as Timestamp).toDate().toLocal() : null,
      claimedBy: map['claimed_by'],
      withdrawCoin: map['withdraw_coin'],
      withdrawAmount: map['currency_amount'],
      paymentId: map['payment_id'],
      currencyCode: map['currency_code'],
    );
  }

  WithdrawalsDocument copyWith({
    String? id,
    DateTime? createdAt,
    String? claimedBy,
    int? withdrawCoin,
    String? withdrawAmount,
    String? paymentId,
    String? currencyCode,
  }) {
    return WithdrawalsDocument(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      claimedBy: claimedBy ?? this.claimedBy,
      withdrawCoin: withdrawCoin ?? this.withdrawCoin,
      withdrawAmount: withdrawAmount ?? this.withdrawAmount,
      paymentId: paymentId ?? this.paymentId,
      currencyCode: currencyCode ?? this.currencyCode,
    );
  }
}
