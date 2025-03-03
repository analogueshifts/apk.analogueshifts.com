import 'package:intl/intl.dart';

/// Returns a custom label based on the provided date.
  String getDateGroupLabel(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    // "Now": items within the last minute.
    if (difference.inMinutes < 1) {
      return 'Now';
    }

    // "Today": same calendar day.
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Today';
    }

    // "Yesterday": one day behind.
    final yesterday = now.subtract(const Duration(days: 1));
    if (date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day) {
      return 'Yesterday';
    }

    // "This Week": items from the current week (starting on Monday)
    final currentWeekStart = now.subtract(Duration(days: now.weekday - 1));
    if (date.isAfter(currentWeekStart)) {
      return 'This Week';
    }

    // "Last Week": items from the week immediately before the current week.
    final lastWeekStart = currentWeekStart.subtract(const Duration(days: 7));
    final lastWeekEnd = currentWeekStart.subtract(const Duration(days: 1));
    if (date.isAfter(lastWeekStart) && date.isBefore(lastWeekEnd.add(const Duration(days: 1)))) {
      return 'Last Week';
    }

    // "Last Month": items from the previous calendar month.
    final lastMonth = DateTime(now.year, now.month - 1, 1);
    final lastMonthEnd = DateTime(now.year, now.month, 0);
    if (date.isAfter(lastMonth.subtract(const Duration(days: 1))) &&
        date.isBefore(lastMonthEnd.add(const Duration(days: 1)))) {
      return 'Last Month';
    }

    // Otherwise, return a formatted date.
    return DateFormat('MMM dd, yyyy').format(date);
  }