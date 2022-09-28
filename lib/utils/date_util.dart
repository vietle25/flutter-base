import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/values/globals.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateUtil {
  static final String formatDate = 'dd/MM/y';
  static final String formatDateSql = 'y-MM-dd';
  static final String formatDateTimeZone = 'y-MM-dd HH:mm:ssZ';
  static final String formatDateTimeZoneT = 'y-MM-ddTHH:mm:ss.Z';
  static final String formatTime = 'HH:mm';
  static final String formatTimeSecond = 'HH:mm:ss';
  static final String formatA = 'a';
  static final String formatTimeA = 'hh:mm a';
  static final String formatTimeSecondA = 'hh:mm:ss a';
  static final String formatDateTime = '$formatDate $formatTimeSecond';
  static final String formatDateTimeSql = '$formatDateSql $formatTimeSecond';
  static final String formatTimeAWithDate = '$formatTimeA $formatDate';
  static final String formatTimeWithDate = '$formatTime $formatDate';
  static final String formatDayOfWeekDate = 'EEEE';
  static final String formatMonth = 'MMMM';
  static final String formatYear = 'y';
  static final String formatDay = 'dd';
  static final String formatMonth2 = 'MM';
  static final String formatMonthDay = "MMM d";

  /// Get time now
  static DateTime now() {
    return DateTime.now();
  }

  /// Get time of day now
  static TimeOfDay timeNow() {
    return TimeOfDay.now();
  }

  /// Parse now with [format]
  static String parseNow(String format) {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat(format);
    return formatter.format(now);
  }

  /// Compare string date with [value1] and [value2]
  static bool compareStringDate(String value1, String value2, String format) {
    DateFormat formatter = DateFormat(format);
    DateTime date1 = DateTime.parse(value1);
    DateTime date2 = DateTime.parse(value2);
    String formatDate1 = formatter.format(date1);
    String formatDate2 = formatter.format(date2);
    if (formatDate1.compareTo(formatDate2) != 0) {
      return true;
    }
    return false;
  }

  /// Convert from string format to format
  static String convertFromFormatToFormat(
      String date, String fromFormat, String toFormat) {
    DateTime dateTimeFromStr = DateUtil.convertStringToDate(date, fromFormat);
    return DateUtil.convertDateToString(dateTimeFromStr, toFormat);
  }

  /// Convert string to date
  static DateTime convertStringToDate(String date, String fromFormat) {
    String dtStr = "";
    DateFormat formatter;
    if (fromFormat != DateUtil.formatDate &&
        fromFormat != DateUtil.formatDateTime) {
      dtStr = DateTime.parse(date).toString();
      formatter = DateFormat(fromFormat);
    } else {
      var inputFormat = DateFormat(fromFormat);
      var dateVN = inputFormat.parse(date);
      formatter = DateFormat(DateUtil.formatDateSql);
      dtStr = formatter.parse("$dateVN").toString();
    }
    DateTime dateTimeFromStr = formatter.parse(dtStr, true).toLocal();
    return dateTimeFromStr;
  }

  /// Convert date to string
  static String convertDateToString(DateTime date, String toFormat) {
    initializeDateFormatting();
    DateFormat formatter = DateFormat(toFormat, Globals.language);
    return formatter.format(date);
  }

  /// Convert date to string
  static String convertFSTimeStampToDate(dynamic timestamp) {
    String date = '-';
    if (timestamp is Timestamp) {
      DateTime time = timestamp.toDate();
      date = DateUtil.convertDateToString(time, DateUtil.formatTimeWithDate);
    }
    return date;
  }

  /// Convert date to UTC
  static DateTime convertDateToUtc(DateTime date) {
    DateFormat formatter = DateFormat(DateUtil.formatDateTimeSql);
    String s = formatter.format(date);
    DateTime dateUtc = formatter.parse(s).toUtc();
    return dateUtc;
  }

  /// Convert time to string
  static String convertTimeToString(TimeOfDay tod, String format) {
    final now = DateUtil.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    DateFormat formatter = DateFormat(format);
    return formatter.format(dt);
  }

  /// Convert string to TimeOfDay
  static TimeOfDay convertStringToTime(String time) {
    TimeOfDay timeOfDay = TimeOfDay(
      hour: int.parse(time.split(":")[0]),
      minute: int.parse(time.split(":")[1]),
    );
    return timeOfDay;
  }

  /// Convert to two digits
  static String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  /// Format by seconds
  static String formatBySeconds(Duration duration) =>
      twoDigits(duration.inSeconds.remainder(60));

  /// Format by minutes
  static String formatByMinutes(Duration duration) {
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return '$twoDigitMinutes:${formatBySeconds(duration)}';
  }

  /// Format by hours
  static String formatByHours(Duration duration) {
    return '${twoDigits(duration.inHours)}:${formatByMinutes(duration)}';
  }

  /// To midnight
  static DateTime toMidnight(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  /// Is weekend
  static bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

  /// Is Today
  static bool isToday(DateTime date) {
    var now = DateTime.now();
    return date.day == now.day &&
        date.month == now.month &&
        date.year == now.year;
  }

  /// Is past day
  static bool isPastDay(DateTime date) {
    var today = toMidnight(DateTime.now());
    return date.isBefore(today);
  }

  /// Add days to date
  static DateTime addDaysToDate(DateTime date, int days) {
    DateTime newDate = date.add(Duration(days: days));
    if (date.hour != newDate.hour) {
      var hoursDifference = date.hour - newDate.hour;
      if (hoursDifference <= 3 && hoursDifference >= -3) {
        newDate = newDate.add(Duration(hours: hoursDifference));
      } else if (hoursDifference <= -21) {
        newDate = newDate.add(Duration(hours: 24 + hoursDifference));
      } else if (hoursDifference >= 21) {
        newDate = newDate.add(Duration(hours: hoursDifference - 24));
      }
    }
    return newDate;
  }

  /// Is special past day
  static bool isSpecialPastDay(DateTime date) {
    return isPastDay(date) || (isToday(date) && DateTime.now().hour >= 12);
  }

  /// Get first day of current month
  static DateTime getFirstDayOfCurrentMonth() {
    var dateTime = DateTime.now();
    dateTime = getFirstDayOfMonth(dateTime);
    return dateTime;
  }

  /// Get first day of next month
  static DateTime getFirstDayOfNextMonth() {
    var dateTime = getFirstDayOfCurrentMonth();
    dateTime = addDaysToDate(dateTime, 31);
    dateTime = getFirstDayOfMonth(dateTime);
    return dateTime;
  }

  /// Get last day of current month
  static DateTime getLastDayOfCurrentMonth() {
    return getLastDayOfMonth(DateTime.now());
  }

  /// Get last day of next month
  static DateTime getLastDayOfNextMonth() {
    return getLastDayOfMonth(getFirstDayOfNextMonth());
  }

  /// Add months
  static DateTime addMonths(DateTime fromMonth, int months) {
    DateTime firstDayOfCurrentMonth = fromMonth;
    for (int i = 0; i < months; i++) {
      firstDayOfCurrentMonth =
          getLastDayOfMonth(firstDayOfCurrentMonth).add(Duration(days: 1));
    }
    return firstDayOfCurrentMonth;
  }

  /// Get first day of month
  static DateTime getFirstDayOfMonth(DateTime month) {
    return DateTime(month.year, month.month);
  }

  /// Get last day of month
  static DateTime getLastDayOfMonth(DateTime month) {
    DateTime firstDayOfMonth = DateTime(month.year, month.month);
    DateTime nextMonth = firstDayOfMonth.add(Duration(days: 32));
    DateTime firstDayOfNextMonth = DateTime(nextMonth.year, nextMonth.month);
    return firstDayOfNextMonth.subtract(Duration(days: 1));
  }

  /// Is same day
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }

  /// Is current month
  static bool isCurrentMonth(DateTime date) {
    var now = DateTime.now();
    return date.month == now.month && date.year == now.year;
  }

  /// Calculate max weeks number monthly
  static int calculateMaxWeeksNumberMonthly(
      DateTime startDate, DateTime endDate) {
    int monthsNumber = calculateMonthsDifference(startDate, endDate);
    List<int> weeksNumbersMonthly = [];
    if (monthsNumber == 0) {
      return calculateWeeksNumber(startDate, endDate);
    } else {
      weeksNumbersMonthly
          .add(calculateWeeksNumber(startDate, getLastDayOfMonth(startDate)));
      DateTime firstDateOfMonth = getFirstDayOfMonth(startDate);
      for (int i = 1; i <= monthsNumber - 2; i++) {
        firstDateOfMonth = firstDateOfMonth.add(Duration(days: 31));
        weeksNumbersMonthly.add(calculateWeeksNumber(
            firstDateOfMonth, getLastDayOfMonth(firstDateOfMonth)));
      }
      weeksNumbersMonthly
          .add(calculateWeeksNumber(getFirstDayOfMonth(endDate), endDate));
      weeksNumbersMonthly.sort((a, b) => b.compareTo(a));
      return weeksNumbersMonthly[0];
    }
  }

  /// Calculate months difference
  static int calculateMonthsDifference(DateTime startDate, DateTime endDate) {
    var yearsDifference = endDate.year - startDate.year;
    return 12 * yearsDifference + endDate.month - startDate.month;
  }

  /// Calculate number of days difference
  static int calculateDaysNumber(DateTime startDate, DateTime endDate) {
    return endDate.difference(startDate).inDays;
  }

  /// Calculate weeks number
  static int calculateWeeksNumber(
      DateTime monthStartDate, DateTime monthEndDate) {
    int rowsNumber = 1;
    DateTime currentDay = monthStartDate;
    while (currentDay.isBefore(monthEndDate)) {
      currentDay = currentDay.add(Duration(days: 1));
      if (currentDay.weekday == DateTime.monday) {
        rowsNumber += 1;
      }
    }
    return rowsNumber;
  }

  static String getTimeOfChat(String createdAt) {
    initializeDateFormatting();
    DateTime dateTime = DateTime.parse(createdAt).toUtc();
    DateTime created = DateTime(dateTime.year, dateTime.month, dateTime.day);
    DateTime toDay =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    int day = toDay.difference(created).inDays;

    /// return time of day
    if (day < 1) {
      dateTime = dateTime.toLocal();
      return (dateTime.hour < 9 ? "0" : "") +
          dateTime.hour.toString() +
          ":" +
          (dateTime.minute < 9 ? "0" : "") +
          dateTime.minute.toString();
    }
    DateFormat formatter =
        DateFormat(DateUtil.formatTimeWithDate, Globals.language);
    return formatter.format(dateTime.toLocal());
  }

  static String getTimeFromTimestamp(Timestamp timestamp) {
    initializeDateFormatting();
    DateTime dateTime =
        DateTime.parse(timestamp.toDate().toLocal().toString()).toUtc();
    DateFormat formatter =
        DateFormat(DateUtil.formatTimeWithDate, Globals.language);
    return formatter.format(dateTime.toLocal());
  }
}
