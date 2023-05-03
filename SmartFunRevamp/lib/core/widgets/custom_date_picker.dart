import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    Key? key,
    required this.labelText,
    this.hintText = "",
    this.initialText = '',
    required this.format,
    this.initialDateTime,
    this.maximunDateTime,
    required this.onItemSelected,
    this.margin = EdgeInsets.zero,
    this.suffixIcon,
  }) : super(key: key);
  final String labelText;
  final String hintText;
  final String? initialText;
  final String format;
  final DateTime? initialDateTime;
  final DateTime? maximunDateTime;
  final Function(DateTime) onItemSelected;
  final EdgeInsetsGeometry margin;
  final Icon? suffixIcon;

  @override
  State<StatefulWidget> createState() {
    return _CustomDatePickerState();
  }
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextFormField(
            keyboardType: TextInputType.none,
            controller: _controller,
            readOnly: true,
            onTap: () {
              if (Platform.isAndroid) {
                _showAndroidDatePicker(context);
              } else {
                _showiOSPicker(context);
              }
            },
            decoration: InputDecoration(
              isDense: true,
              suffixIcon: widget.suffixIcon,
              fillColor: Colors.transparent,
              filled: true,
              hintText: widget.hintText,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAndroidDatePicker(ctx) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.initialDateTime ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: widget.maximunDateTime ?? DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _controller.text = DateFormat(widget.format).format(pickedDate);
        widget.onItemSelected(pickedDate);
      });
    }
  }

  void _showiOSPicker(ctx) {
    showCupertinoModalPopup(
      context: ctx,
      builder: (_) => Container(
        height: 250,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: CupertinoDatePicker(
                  maximumYear: widget.maximunDateTime?.year ?? DateTime.now().year,
                  initialDateTime: widget.initialDateTime,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (date) {
                    setState(() {
                      _controller.text = DateFormat(widget.format).format(date);
                      widget.onItemSelected(date);
                    });
                  }),
            ),
            CupertinoButton(
              child: Text(SplashScreenNotifier.getLanguageLabel('Done')),
              onPressed: () => Navigator.of(ctx).pop(),
            )
          ],
        ),
      ),
    );
  }
}
