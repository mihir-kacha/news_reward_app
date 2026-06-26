part of '../network.dart';

base class UnAuthenticated implements Exception {
  const UnAuthenticated();
}

base class TimeoutException implements Exception {
  const TimeoutException();
}

class DefaultException implements Exception {
  const DefaultException({required this.message});

  final String message;
}


