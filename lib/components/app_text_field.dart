import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? hintText;
  final String? labelText;
  final Color? cursorColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final InputBorder? focusedBorder;
  final TextStyle? labelStyle;
  final TextInputType keyboardType;
  final int maxLines;
  final bool enabled;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const AppTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.hintText,
    this.labelStyle,
    this.cursorColor,
    this.labelText,
    this.prefixIcon,
    this.focusedBorder,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.enabled = true,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: obscureText ? 1 : maxLines,
      enabled: enabled,
      validator: validator,
      onChanged: onChanged,
      cursorColor: cursorColor ?? theme.colorScheme.primary,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        labelStyle:
            labelStyle ??
            theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withAlpha(153),
            ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2.0,
              ),
            ),

        filled: true,
        fillColor: theme.colorScheme.surface.withAlpha(13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
    );
  }
}
