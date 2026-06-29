import 'dart:math';

import 'package:flutter/material.dart';
import 'package:inshorts/core/core.dart';
import 'package:inshorts/data/preference/preference.dart';
import 'package:inshorts/generated/assets.gen.dart';

enum CardPosition { previous, current, next }

enum Category {
  technology(label: "Technology"),
  sports(label: "Sports"),
  business(label: "Business"),
  entertainment(label: "Entertainment"),
  health(label: "Health"),
  science(label: "Science"),
  world(label: "World"),
  politics(label: "Politics");

  final String label;

  const Category({required this.label});

  Color get color {
    switch (this) {
      case Category.technology:
        return const Color(0xFF1d4c91);

      case Category.sports:
        return const Color(0xFF3f126e);

      case Category.business:
        return const Color(0xFF1b5573);

      case Category.entertainment:
        return const Color(0xFF863036);

      case Category.health:
        return const Color(0xFF4a6c58);

      case Category.science:
        return const Color(0xFF29407a);

      case Category.world:
        return const Color(0xFF1b4946);

      case Category.politics:
        return const Color(0xFF4d6489);
    }
  }

  String get img {
    switch (this) {
      case Category.technology:
        return Assets.images.category.imgTech.path;
      case Category.sports:
        return Assets.images.category.imgSports.path;
      case Category.business:
        return Assets.images.category.imgBusiness.path;
      case Category.entertainment:
        return Assets.images.category.imgEntertainment.path;
      case Category.health:
        return Assets.images.category.imgHealth.path;
      case Category.science:
        return Assets.images.category.imgScience.path;
      case Category.world:
        return Assets.images.category.imgWorld.path;
      case Category.politics:
        return Assets.images.category.imgPolitics.path;
    }
  }

  String get info {
    switch (this) {
      case Category.technology:
        return "Latest in tech, gadgets and innovation";
      case Category.sports:
        return "Scores, highlights and sports updates";
      case Category.business:
        return "Business news, startup stories and more";
      case Category.entertainment:
        return "Movies, shows, celebs, and trending buzz";
      case Category.health:
        return "Health tips, medicals news and wellness updates";
      case Category.science:
        return "Discoveries, research and science updates";
      case Category.world:
        return "Top global news and international updates";
      case Category.politics:
        return "Political and policy changes";
    }
  }

  String get icon {
    switch (this) {
      case Category.technology:
        return Assets.icons.category.icTech.path;
      case Category.sports:
        return Assets.icons.category.icSports.path;
      case Category.business:
        return Assets.icons.category.icBusiness.path;
      case Category.entertainment:
        return Assets.icons.category.icEntertainment.path;
      case Category.health:
        return Assets.icons.category.icHealth.path;
      case Category.science:
        return Assets.icons.category.icScience.path;
      case Category.world:
        return Assets.icons.category.icWorld.path;
      case Category.politics:
        return Assets.icons.category.icPolitics.path;
    }
  }
}

enum ChallengeType {
  luck,
  drinkWater,
  walk,
  exercise,
  pray;

  int get coins => switch (this) {
    ChallengeType.luck => Random().nextInt(10000),
    ChallengeType.drinkWater => Preference().coinsConfig.drinkWaterCoins,
    ChallengeType.walk => Preference().coinsConfig.walkCoins,
    ChallengeType.exercise => Preference().coinsConfig.exerciseCoins,
    ChallengeType.pray => Preference().coinsConfig.prayCoins,
  };

  String label(BuildContext context) {
    return switch (this) {
      ChallengeType.luck => "Try You Luck",
      ChallengeType.drinkWater => "Drink Water",
      ChallengeType.walk => "Walk 10 Minutes",
      ChallengeType.exercise => "Exercise 10 Minutes",
      ChallengeType.pray => "Pray 2 Minutes",
    };
  }

  String desc(BuildContext context) {
    return switch (this) {
      ChallengeType.luck => "Open once daily & win 0 - 10,000 Points",
      ChallengeType.drinkWater => 'Stay hydrated & earn 2,000 Points (every 1 hours)',
      ChallengeType.walk => 'Walk daily & earn 2,000 Points (every 1 hours)',
      ChallengeType.exercise => 'Exercise & earn  2,000 Points (every 1 hours)',
      ChallengeType.pray => 'Pray & earn  2,000 Points (every 6 hours)',
    };
  }

  String get emoji => switch (this) {
    ChallengeType.luck => Assets.images.challangeImages.imgLuck.path,
    ChallengeType.drinkWater => Assets.images.challangeImages.imgDrinkWater.path,
    ChallengeType.walk => Assets.images.challangeImages.imgWalk.path,
    ChallengeType.exercise => Assets.images.challangeImages.imgExercise.path,
    ChallengeType.pray => Assets.images.challangeImages.imgPray.path,
  };
}

enum ClaimStatus { locked, claim, claimed }

extension $SurveyStatusColor on ClaimStatus {
  Color backgroundColor(BuildContext context) {
    switch (this) {
      case ClaimStatus.locked:
        return context.colorScheme.primary;
      case ClaimStatus.claim:
        return const Color(0xFF22C55E);
      case ClaimStatus.claimed:
        return Colors.grey.shade200;
    }
  }

  Color textColor(BuildContext context) {
    switch (this) {
      case ClaimStatus.locked:
        return context.colorScheme.onPrimary;
      case ClaimStatus.claim:
        return Colors.white;
      case ClaimStatus.claimed:
        return Colors.grey.shade600;
    }
  }
}
