import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTextField extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<String>? onDateChanged;

  const DateTextField({super.key, this.initialDate, this.onDateChanged});

  @override
  // ignore: library_private_types_in_public_api
  _DateTextFieldState createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  late DateTime _selectedDate;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
    _controller = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(_selectedDate),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _controller.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
      if (widget.onDateChanged != null) {
        widget.onDateChanged!(_controller.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      readOnly: true,
      decoration: textInputDecoration.copyWith(
        fillColor: Theme.of(context).colorScheme.brightness == Brightness.light
            ? AppColors.white
            : AppColors.background,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color:
                    Theme.of(context).colorScheme.brightness == Brightness.light
                        ? const Color(0xff000000).withOpacity(0.07)
                        : const Color(0xffFFFFFF).withOpacity(0.18))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color:
                    Theme.of(context).colorScheme.brightness == Brightness.light
                        ? const Color(0xff000000).withOpacity(0.07)
                        : const Color(0xffFFFFFF).withOpacity(0.18))),
        hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.brightness == Brightness.light
                ? const Color(0xff000000).withOpacity(0.25)
                : const Color(0xffFFFFFF).withOpacity(0.4)),
        hintText: 'Select date',
        suffixIcon: Icon(Icons.calendar_today),
      ),
      onTap: _selectDate,
    );
  }
}
