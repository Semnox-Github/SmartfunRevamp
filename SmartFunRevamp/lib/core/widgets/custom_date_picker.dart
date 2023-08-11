import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    Key? key,
    required this.labelText,
    required this.format,
    required this.onItemSelected,
    this.hintText = "",
    this.initialText = '',
    this.initialDateTime,
    this.maximunDateTime,
    this.minimumDateTime,
    this.margin = EdgeInsets.zero,
    this.suffixIcon,
  }) : super(key: key);
  final String labelText;
  final String hintText;
  final String? initialText;
  final String format;
  final DateTime? initialDateTime;
  final DateTime? maximunDateTime;
  final DateTime? minimumDateTime;
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
            key: UniqueKey(),
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
      firstDate: widget.minimumDateTime ?? DateTime(DateTime.now().year - 10),
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
                  minimumDate: widget.minimumDateTime,
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
