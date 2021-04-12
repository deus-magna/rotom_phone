extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  T enumFromString<T>(List<T> values) =>
      values.firstWhere((v) => this == _enumToString(v), orElse: () => null);

  String _enumToString(Object o) => o.toString().split('.').last.toLowerCase();
}
