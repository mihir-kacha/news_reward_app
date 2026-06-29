part of 'model.dart';

class WithDrawConfig {
  final int coins;
  final int minCoins;

  WithDrawConfig({required this.coins, required this.minCoins});

  Map<String, dynamic> toJson() {
    return {'coins': coins, 'min_coins': minCoins};
  }

  factory WithDrawConfig.fromJson(Map<String, dynamic> map) {
    return WithDrawConfig(coins: map['coins'], minCoins: map['min_coins']);
  }
}

class CoinsConfig {
  final int drinkWaterCoins;
  final int walkCoins;
  final int exerciseCoins;
  final int prayCoins;

  CoinsConfig({
    required this.drinkWaterCoins,
    required this.walkCoins,
    required this.exerciseCoins,
    required this.prayCoins,
  });

  const CoinsConfig.empty() : drinkWaterCoins = 0, walkCoins = 0, exerciseCoins = 0, prayCoins = 0;

  Map<String, dynamic> toJson() {
    return {
      'drink_water_coins': drinkWaterCoins,
      'walk_coins': walkCoins,
      'exercise_coins': exerciseCoins,
      'pray_coins': prayCoins,
    };
  }

  factory CoinsConfig.fromJson(Map<String, dynamic> map) {
    return CoinsConfig(
      drinkWaterCoins: map['drink_water_coins'] as int,
      walkCoins: map['walk_coins'] as int,
      exerciseCoins: map['exercise_coins'] as int,
      prayCoins: map['pray_coins'] as int,
    );
  }
}
