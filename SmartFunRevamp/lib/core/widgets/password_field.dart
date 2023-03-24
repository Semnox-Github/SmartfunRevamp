import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
    required this.onSaved,
    this.borderColor = Colors.white,
    this.fillColor = Colors.white,
  }) : super(key: key);
  final Function(String) onSaved;
  final Color borderColor;
  final Color fillColor;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5.0),
        TextFormField(
          initialValue: 'testuser2!123@12',
          obscureText: _isObscured,
          onSaved: (newValue) => widget.onSaved(newValue!),
          validator: (value) => value!.isEmpty ? 'Required' : null,
          cursorColor: Colors.black,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            isDense: true,
            fillColor: widget.fillColor,
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
              icon: Icon(
                !_isObscured ? Icons.visibility_off : Icons.visibility,
                color: Colors.black,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: widget.borderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: widget.borderColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
