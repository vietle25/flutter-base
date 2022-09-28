import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_base/locales/localizes.dart';
import 'package:flutter_base/styles/common_style.dart';
import 'package:flutter_base/values/colors.dart';
import 'package:flutter_base/values/constants.dart';
import 'package:flutter_base/values/fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

/// CalendarPicker class to display the date range picker
class CalendarPickerWidget extends StatefulWidget {
  final PickerDateRange? initialSelectedRange; // Initial Selected Range
  final DateRangePickerSelectionMode? selectionMode; // Selection Mode
  final Function? onClose; // On close
  final Function? onCompleted; // On completed
  final Function? onChangedDate; // On changed date
  DateTime? minDate; // Min date
  DateTime? maxDate; // Max date

  CalendarPickerWidget({
    this.minDate,
    this.maxDate,
    this.selectionMode,
    this.initialSelectedRange,
    this.onClose,
    this.onCompleted,
    this.onChangedDate,
  }) {
    if (selectionMode == null) {
      maxDate = DateTime(2100, 12, 31);
      minDate = DateTime(1900, 01, 01);
    } else if (selectionMode == DateRangePickerSelectionMode.range) {
      maxDate =
          DateTime(2100, 12, 31); // DateTime.now().add(Duration(days: 6));
      minDate =
          DateTime(1900, 01, 01); //DateTime.now().subtract(Duration(days: 6));
    }
  }

  @override
  CalendarPickerState createState() => CalendarPickerState();
}

/// State for CalendarPicker
class CalendarPickerState extends State<CalendarPickerWidget> {
  DateTime? _selectedDate;
  DateTime? _startDateSelected;
  DateTime? _endDateSelected;
  String? _dateCount;
  String? _range;
  String? _rangeCount;
  DateRangePickerController? _controller;

  @override
  void initState() {
    _selectedDate = DateTime.now();
    _startDateSelected = DateTime.now();
    _endDateSelected = DateTime.now();
    _dateCount = '';
    _range = '';
    _rangeCount = '';
    _controller = DateRangePickerController();
    super.initState();
  }

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (widget.onChangedDate != null) {
      widget.onChangedDate!(args);
    }
    setState(
      () {
        if (args.value is PickerDateRange) {
          /// The argument value will return the changed range as [PickerDateRange]
          /// when the widget [SfDateRangeSelectionMode] set as range.
          _range = DateFormat('dd/MM/yyyy')
                  .format(args.value.startDate)
                  .toString() +
              (args.value.endDate != null
                  ? (' - ' +
                      DateFormat('dd/MM/yyyy')
                          .format(args.value.endDate ?? args.value.startDate)
                          .toString())
                  : "");
          _startDateSelected = args.value.startDate;
          _endDateSelected = args.value.endDate;
          if (_endDateSelected != null) {
            int diff = _endDateSelected!.difference(_startDateSelected!).inDays;
            DateTime _onWeekStartDate = _startDateSelected!
                .add(Duration(days: 7 - _startDateSelected!.weekday));
            DateTime _onWeekEndDate = _endDateSelected!
                .subtract(Duration(days: _endDateSelected!.weekday - 1));
            if (diff == 0) return;
            if (diff > 7) {
              if ((diff - 1) % 7 == 0 &&
                  _startDateSelected!.weekday == 7 &&
                  _endDateSelected!.weekday == 1) {
                _controller!.selectedRange = PickerDateRange(
                    _endDateSelected!.subtract(Duration(days: 7)),
                    _endDateSelected!.subtract(Duration(days: 1)));
              } else if (_startDateSelected!.weekday == 1 &&
                  _endDateSelected!.weekday == 7) {
                _controller!.selectedRange = PickerDateRange(_startDateSelected,
                    _startDateSelected!.add(Duration(days: 6)));
              } else {
                bool _condition = _startDateSelected!.weekday != 7 &&
                    (_endDateSelected!.weekday == 1 ||
                        _startDateSelected!.weekday >
                                _endDateSelected!.weekday &&
                            _startDateSelected!.weekday > 4 ||
                        _startDateSelected!.weekday < 4 &&
                            _endDateSelected!.weekday < 4 ||
                        _endDateSelected!.weekday < 4);
                _controller!.selectedRange = PickerDateRange(
                    _condition ? _startDateSelected : _onWeekEndDate,
                    _condition ? _onWeekStartDate : _endDateSelected);
              }
            } else if (_startDateSelected!.weekday >=
                _endDateSelected!.weekday) {
              bool _condition =
                  _startDateSelected!.weekday == _endDateSelected!.weekday &&
                          _startDateSelected!.weekday > 4 ||
                      _startDateSelected!.weekday > 4 &&
                          _endDateSelected!.weekday != 1 ||
                      _endDateSelected!.weekday > 4;
              _controller!.selectedRange = PickerDateRange(
                  _condition ? _onWeekEndDate : _startDateSelected,
                  _condition ? _endDateSelected : _onWeekStartDate);
            }
          }
          // widget.maxDate = _startDateSelected.add(Duration(days: 6));
          // widget.minDate = _startDateSelected.subtract(Duration(days: 6));
        } else if (args.value is DateTime) {
          /// The argument value will return the changed dates as [List<DateTime>]
          /// when the widget [SfDateRangeSelectionMode] set as multiple.
          _selectedDate = args.value;
        } else if (args.value is List<DateTime>) {
          /// The argument value will return the changed ranges as
          /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
          /// multi range.
          _dateCount = args.value.length.toString();
        } else {
          /// The argument value will return the changed date as [DateTime] when the
          /// widget [SfDateRangeSelectionMode] set as single.
          _rangeCount = args.value.length.toString();
        }
      },
    );
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    if (date2 == date1) {
      return true;
    }
    if (date1 == null || date2 == null) {
      return false;
    }
    return date1.month == date2.month &&
        date1.year == date2.year &&
        date1.day == date2.day;
  }

  /// On close dialog
  onClose() {
    if (widget.onClose != null) {
      widget.onClose!();
    }
    Navigator.pop(context, false); // passing false
  }

  /// On completed selected date
  onCompleted() {
    if (widget.onCompleted != null) {
      widget.onCompleted!(_startDateSelected, _endDateSelected);
    }
    Navigator.pop(context, true); // passing true
  }

  @override
  Widget build(BuildContext context) {
    return showDialogCalender(context);
  }

  /// Show dialog Calendar
  showDialogCalender(context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Constants.cornerRadius),
        ),
      ),
      child: Container(
        height: 400,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 88,
              padding: EdgeInsets.symmetric(
                  vertical: Constants.padding16,
                  horizontal: Constants.padding16 + 6),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                color: Colors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Constants.cornerRadius),
                  topRight: Radius.circular(Constants.cornerRadius),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.primary,
                    Colors.primaryGradient
                  ], // red to yellow
                  tileMode:
                      TileMode.clamp, // repeats the gradient over the canvas
                ),
              ),
              child: Row(
                children: [
                  Text(
                    // _range.isNotEmpty ? _range : "Select date",
                    Localizes.selectDate.tr,
                    style: CommonStyle.text(color: Colors.white).merge(
                        TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: Fonts.font12)),
                  )
                ],
              ),
            ),
            Positioned(
              top: 36,
              left: 12,
              right: 12,
              bottom: 32,
              child: SfDateRangePicker(
                headerHeight: 48,
                controller: _controller,
                headerStyle: DateRangePickerHeaderStyle(
                  backgroundColor: Colors.transparent,
                  textStyle: CommonStyle.textLargeBold(color: Colors.white),
                ),
                monthFormat: "MMMM, ",
                monthViewSettings: DateRangePickerMonthViewSettings(
                  dayFormat: "EEE",
                  firstDayOfWeek: 1,
                  enableSwipeSelection: true,
                  viewHeaderHeight: 50,
                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                      textStyle:
                          CommonStyle.textSmallBold(color: Colors.textLight)),
                ),
                rangeSelectionColor: Colors.primaryGradient,
                view: DateRangePickerView.month,
                onSelectionChanged: _onSelectionChanged,
                minDate: widget.minDate,
                // Default minDate: DateTime(1900, 01, 01),
                maxDate: widget.maxDate,
                // Default maxDate: DateTime(2100, 12, 31),
                selectionMode:
                    widget.selectionMode ?? DateRangePickerSelectionMode.single,
                initialSelectedRange: widget.initialSelectedRange ??
                    PickerDateRange(DateTime.now(), DateTime.now()),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    onPressed: onClose,
                    child: Text(
                      Localizes.cancel.tr.toUpperCase(),
                      style: CommonStyle.textBold(
                        color: Colors.textLight,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: onCompleted,
                    child: Text(
                      Localizes.ok.tr.toUpperCase(),
                      style: CommonStyle.textBold(
                        color: Colors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
