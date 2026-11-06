import 'package:flutter/material.dart';

enum InputFieldType {
  name,
  email,
  password,
  confirmPassword,
}

class CustomTextFormField extends StatefulWidget {
  final InputFieldType inputType;
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final TextEditingController? passwordController;
  final bool isLast;

  const CustomTextFormField({
    super.key,
    required this.inputType,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.passwordController,
    this.isLast = false,
  });

  @override
  State<CustomTextFormField> createState() =>
      _CustomTextFormFieldState();
}

class _CustomTextFormFieldState
    extends State<CustomTextFormField> {

  bool hidePassword = true;

  String? validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Поле не может быть пустым';
    }

    switch (widget.inputType) {
      case InputFieldType.name:
        final reg = RegExp(
          r'^[A-Za-zА-Яа-яЁё\s]+$',
        );

        if (!reg.hasMatch(value.trim())) {
          return 'ФИО должно содержать только буквы';
        }
        break;

      case InputFieldType.email:
        final reg = RegExp(
          r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
        );

        if (!reg.hasMatch(value.trim())) {
          return 'Введите корректный Email';
        }
        break;

      case InputFieldType.password:
        final reg = RegExp(
          r'^(?=.*[A-Za-zА-Яа-яЁё])(?=.*\d)(?=.*[+_-]).{6,}$',
        );

        if (!reg.hasMatch(value)) {
          return 'От 6 символов: буква, цифра и +, _ или -';
        }
        break;

      case InputFieldType.confirmPassword:
        if (value != widget.passwordController?.text) {
          return 'Пароли не совпадают';
        }
        break;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isPassword =
        widget.inputType == InputFieldType.password ||
            widget.inputType == InputFieldType.confirmPassword;

    return TextFormField(
      controller: widget.controller,
      validator: validator,
      autovalidateMode:
      AutovalidateMode.onUserInteraction,
      obscureText:
      isPassword && hidePassword,

      keyboardType:
      widget.inputType == InputFieldType.email
          ? TextInputType.emailAddress
          : TextInputType.text,

      textInputAction:
      widget.isLast
          ? TextInputAction.done
          : TextInputAction.next,

      onFieldSubmitted: (_) {
        if (widget.isLast) {
          FocusScope.of(context).unfocus();
        } else {
          FocusScope.of(context).nextFocus();
        }
      },

      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,

        prefixIcon: Icon(
          widget.prefixIcon,
          color: const Color(0xFFFF5A76),
        ),

        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            hidePassword
                ? Icons.visibility
                : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              hidePassword = !hidePassword;
            });
          },
        )
            : null,

        filled: true,
        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFFF5A76),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),

        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}