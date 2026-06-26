import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inshorts/core/core.dart';

enum _ClickType { icon, material, cupertino }

class CommonButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? radius;
  final double? pressedOpacity;
  late final _ClickType clickType;

  CommonButton.icon({
    super.key,
    required this.onTap,
    required this.child,
    this.padding,
    this.radius,
    this.pressedOpacity,
  }) {
    clickType = _ClickType.icon;
  }

  CommonButton.material({
    super.key,
    required this.onTap,
    required this.child,
    this.padding,
    this.radius,
    this.pressedOpacity,
  }) {
    clickType = _ClickType.material;
  }

  CommonButton.cupertino({
    super.key,
    required this.onTap,
    required this.child,
    this.padding,
    this.radius,
    this.pressedOpacity,
  }) {
    clickType = _ClickType.cupertino;
  }

  @override
  Widget build(BuildContext context) {
    switch (clickType) {
      case _ClickType.icon:
        return _IconButton(onTap: onTap, padding: padding, child: child);
      case _ClickType.material:
        return _MaterialButton(onTap: onTap, radius: radius, padding: padding, child: child);
      case _ClickType.cupertino:
        return _CupertinoButton(onTap: onTap, padding: padding, pressedOpacity: pressedOpacity, child: child);
    }
  }
}

class _IconButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const _IconButton({required this.onTap, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: IconButton(
        alignment: Alignment.center,
        padding: padding ?? EdgeInsets.zero,
        highlightColor: context.colorScheme.onSurfaceVariant.withColorOpacity(.1),
        onPressed: onTap,
        icon: child,
      ),
    );
  }
}

class _MaterialButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final double? radius;
  final EdgeInsetsGeometry? padding;

  const _MaterialButton({required this.onTap, required this.child, this.radius, required this.padding});

  @override
  Widget build(BuildContext context) {
    final animationDuration = Duration(milliseconds: 1500);

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Stack(
        children: [
          child,
          Positioned.fill(
            child: MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 0)),
              padding: EdgeInsets.zero,
              animationDuration: animationDuration,
              onPressed: onTap == null
                  ? null
                  : () {
                      Timer(animationDuration, () {
                        if (onTap != null) {
                          onTap!();
                        }
                      });
                    },
            ),
          ),
        ],
      ),
    );
  }
}

class _CupertinoButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final double? pressedOpacity;
  final EdgeInsetsGeometry? padding;

  const _CupertinoButton({required this.onTap, required this.child, this.pressedOpacity, this.padding});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 10,
      pressedOpacity: pressedOpacity ?? .7,
      padding: padding ?? EdgeInsets.zero,
      onPressed: onTap,
      child: child,
    );
  }
}
