String decodedMacAddress(String value) {
  final String newValue = value.replaceAllMapped(RegExp(r".{2}"), (match) => "${match.group(0)}:");
  return newValue.substring(0, newValue.length - 1);
}

(String, String) decodeSN(String value) {
  final List<String> values = value.split('_');
  return (values.first, values.last);
}
