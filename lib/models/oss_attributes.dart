class OSSAttribute {
  final String name;
  final String licence;
  final String url;

  const OSSAttribute(this.name, this.licence, this.url);

  OSSAttribute copyWith({
    String? name,
    String? licence,
    String? url,
  }) {
    return OSSAttribute(
      name ?? this.name,
      licence ?? this.licence,
      url ?? this.url,
    );
  }
}
