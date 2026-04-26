/// Extension to parse study day name strings in the format:
/// "دراسة كيمياء تحصيلي و فيزياء تحصيلي — الأحد - 2026-04-05"
/// into structured parts: title, dayName, and date.

class StudyDayParsedName {
  final String title;
  final String dayName;
  final String date;

  const StudyDayParsedName({
    required this.title,
    required this.dayName,
    required this.date,
  });

  bool get hasMetadata => dayName.isNotEmpty || date.isNotEmpty;
}

extension StudyDayNameExtension on String {
  /// Parses a string like:
  /// "دراسة كيمياء تحصيلي و فيزياء تحصيلي — الأحد - 2026-04-05"
  ///
  /// Returns a [StudyDayParsedName] with:
  /// - [title]   → "دراسة كيمياء تحصيلي و فيزياء تحصيلي"
  /// - [dayName] → "الأحد"
  /// - [date]    → "2026-04-05"
  StudyDayParsedName parseStudyDayName() {
    // Split on the em dash "—"
    final parts = split('—');

    if (parts.length < 2) {
      // No em dash found, return the whole string as title
      return StudyDayParsedName(title: trim(), dayName: '', date: '');
    }

    final title = parts.first.trim();
    final rest = parts.last.trim(); // e.g. "الأحد - 2026-04-05"

    // Use regex to split on the first dash and allow variable spaces
    final match = RegExp(r'^(.*?)\s*-\s*(.*)$').firstMatch(rest);
    
    if (match != null) {
      return StudyDayParsedName(
        title: title,
        dayName: match.group(1)?.trim() ?? '',
        date: match.group(2)?.trim() ?? '',
      );
    }

    return StudyDayParsedName(
      title: title,
      dayName: rest,
      date: '',
    );
  }
}
