import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inshorts/core/core.dart';
import 'package:inshorts/resources/resources.dart';
import 'package:inshorts/utils/common_button.dart';

class AppInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final void Function(String value)? onChanged;
  final String? Function(String? value)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final int? maxLine;
  final int? maxLength;
  final bool? readOnly;
  final bool autofocus;
  final bool enabled;
  final bool? obscureText;
  final Widget? suffix;
  final Widget? prefixIcon;
  final TextCapitalization? textCapitalization;
  final VoidCallback? onTap;
  final void Function(String value)? onFieldSubmitted;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? hintStyle;
  final bool? isApplyShadow;
  final TextStyle? style;
  final TextStyle? errorStyle;
  final Color? borderColor;
  final double borderRadius;
  final TextAlign? textAlign;
  final bool? filled;
  final Color? fillColor;

  const AppInputField({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.autofillHints,
    this.maxLine,
    this.readOnly,
    this.autofocus = true,
    this.enabled = true,
    this.obscureText,
    this.suffix,
    this.prefixIcon,
    this.textCapitalization,
    this.onTap,
    this.onFieldSubmitted,
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    this.contentPadding,
    this.maxLength,
    this.hintStyle,
    this.isApplyShadow = true,
    this.style,
    this.errorStyle,
    this.borderColor,
    this.borderRadius = Spacing.normal,
    this.textAlign,
    this.filled,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return CommonButton.cupertino(
      onTap: enabled ? onTap : null,
      child: TextFormField(
        textAlign: textAlign ?? TextAlign.start,
        obscureText: obscureText ?? false,
        controller: controller,
        onChanged: onChanged,
        autofocus: autofocus,
        style: (style ?? context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w400))?.copyWith(
          color: enabled ? null : context.colorScheme.onSurfaceVariant,
        ),
        maxLength: maxLength,
        keyboardType: keyboardType,
        autofillHints: autofillHints,
        textInputAction: textInputAction ?? TextInputAction.next,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        maxLines: maxLine ?? 1,
        onFieldSubmitted: onFieldSubmitted,

        onTap: onTap,
        validator: validator,
        readOnly: readOnly ?? false,
        enabled: enabled,

        inputFormatters: inputFormatters,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          filled: filled ?? false,
          fillColor: fillColor,
          hintText: hintText,
          prefixIcon: prefixIcon,
          hintStyle:
              hintStyle ??
              context.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: context.colorScheme.surfaceTint,
              ),
          prefixIconConstraints: prefixIconConstraints ?? BoxConstraints(minWidth: 34),
          suffixIcon: suffix,
          suffixIconConstraints: suffixIconConstraints ?? BoxConstraints(minWidth: 52),
          helperStyle: TextStyle(height: 0, fontSize: 0),
          counterStyle: TextStyle(height: 0, fontSize: 0),
          contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: Spacing.normal, horizontal: Spacing.large),
          isDense: true,
          errorStyle: errorStyle,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? context.colorScheme.surfaceContainerLow),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? context.colorScheme.primary),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? context.colorScheme.surfaceContainerLow),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: context.colorScheme.error),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: context.colorScheme.error),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? context.colorScheme.surfaceContainerLow),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
