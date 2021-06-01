T enumFromString<T>(Iterable<T> values, String value) {
  return values.firstWhere((type) => type.toString().split('.').last == value,
      orElse: () => null);
}

// T enumFromString<T>(List<T> values) =>
//       values.firstWhere((v) => this == _enumToString(v), orElse: () => null);

///   String _enumToString(Object o) => o.toString()
/// .split('.').last.toLowerCase();
