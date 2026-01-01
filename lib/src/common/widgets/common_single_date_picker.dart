import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';

class CommonSingleDatePicker extends StatefulWidget {
  final String? hintText;
  final Function(DateTime) onDateSelected;
  final DateTime? initialDate;
  final String? suffixIcon;
  final Color? suffixIconColor;
  final Color? fillColor;
  final double? verticalPadding;
  final double? topLeftBorderRadius;
  final double? topRightBorderRadius;
  final double? bottomLeftBorderRadius;
  final double? bottomRightBorderRadius;
  final double? borderRadius;
  final String? labelText;
  final bool isRequired;

  const CommonSingleDatePicker({
    super.key,
    this.hintText,
    required this.onDateSelected,
    this.initialDate,
    this.suffixIcon,
    this.suffixIconColor,
    this.fillColor,
    this.verticalPadding,
    this.topLeftBorderRadius,
    this.topRightBorderRadius,
    this.bottomLeftBorderRadius,
    this.bottomRightBorderRadius,
    this.borderRadius,
    this.labelText,
    this.isRequired = false,
  });

  @override
  State<CommonSingleDatePicker> createState() => _CommonSingleDatePickerState();
}

class _CommonSingleDatePickerState extends State<CommonSingleDatePicker> {
  late DateTime _selectedDay;
  late TextEditingController _dateController;

  final DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.initialDate ?? DateTime.now();
    _dateController = TextEditingController(
      text: widget.initialDate != null
          ? dateFormat.format(widget.initialDate!)
          : '',
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: AppColors.lightTextPrimary,
        fontWeight: FontWeight.w700,
        fontSize: 15.sp,
      ),
      controller: _dateController,
      onTap: () {
        _selectDate(context, _selectedDay, _dateController);
      },
      readOnly: true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
        filled: true,
        fillColor: widget.fillColor ?? AppColors.white,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: AppColors.lightTextTertiary,
          fontWeight: FontWeight.w700,
          fontSize: 15.sp,
        ),
        label: widget.labelText != null && widget.isRequired
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.labelText!),
                  Text(
                    ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              )
            : (widget.labelText != null ? Text(widget.labelText!) : null),
        labelStyle: TextStyle(
          color: AppColors.lightTextTertiary,
          fontWeight: FontWeight.w700,
          fontSize: 15.sp,
        ),
        floatingLabelStyle: TextStyle(
          color: AppColors.lightTextTertiary,
          fontWeight: FontWeight.w700,
          fontSize: 16.sp,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _getBorderRadius(),
          borderSide: BorderSide(
            color: AppColors.lightTextPrimary.withValues(alpha: 0.10),
            width: 2.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: _getBorderRadius(),
          borderSide: BorderSide(
            color: AppColors.lightPrimary.withValues(alpha: 0.80),
            width: 2.w,
          ),
        ),
      ),
      keyboardType: TextInputType.datetime,
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    DateTime selectedDate,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showRoundedDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.utc(1990, 1, 1),
      lastDate: DateTime.utc(2030, 12, 31),
      borderRadius: 16.r,

      height: MediaQuery.of(context).size.height * 0.35,
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: AppColors.lightPrimary),
      ),
      styleDatePicker: MaterialRoundedDatePickerStyle(
        textStyleYearButton: TextStyle(
          letterSpacing: 0,
          color: AppColors.white,
          fontSize: 30.sp,
          fontWeight: FontWeight.w900,
        ),
        textStyleDayButton: TextStyle(
          letterSpacing: 0,
          color: AppColors.white,
          fontSize: 28.sp,
          fontWeight: FontWeight.w700,
        ),
        textStyleButtonPositive: TextStyle(
          letterSpacing: 0,
          color: AppColors.lightPrimary,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        textStyleButtonNegative: TextStyle(
          letterSpacing: 0,
          color: AppColors.lightPrimary,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        backgroundHeader: AppColors.lightPrimary,
        textStyleCurrentDayOnCalendar: TextStyle(
          letterSpacing: 0,
          color: AppColors.lightPrimary,
        ),
        textStyleDayOnCalendarSelected: TextStyle(
          letterSpacing: 0,
          color: AppColors.white,
          fontWeight: FontWeight.w700,
          fontSize: 14.sp,
        ),
      ),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        _selectedDay = picked;
        widget.onDateSelected(picked);
        controller.text = dateFormat.format(picked);
      });
    }
  }

  BorderRadius _getBorderRadius() {
    return BorderRadius.only(
      topLeft: Radius.circular(
        widget.topLeftBorderRadius?.r ?? widget.borderRadius?.r ?? 8.r,
      ),
      topRight: Radius.circular(
        widget.topRightBorderRadius?.r ?? widget.borderRadius?.r ?? 8.r,
      ),
      bottomLeft: Radius.circular(
        widget.bottomLeftBorderRadius?.r ?? widget.borderRadius?.r ?? 8.r,
      ),
      bottomRight: Radius.circular(
        widget.bottomRightBorderRadius?.r ?? widget.borderRadius?.r ?? 8.r,
      ),
    );
  }
}
