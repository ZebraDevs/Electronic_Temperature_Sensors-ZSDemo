class PageResponse {
  final int totalElements;
  final int size;
  final int totalPages;
  final int page;

  PageResponse({
    required this.totalElements,
    required this.size,
    required this.totalPages,
    required this.page,
  });

  PageResponse copyWith({
    int? totalElements,
    int? size,
    int? totalPages,
    int? page,
  }) {
    return PageResponse(
      totalElements: totalElements ?? this.totalElements,
      size: size ?? this.size,
      totalPages: totalPages ?? this.totalPages,
      page: page ?? this.page,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total_elements': totalElements,
      'size': size,
      'total_pages': totalPages,
      'page': page,
    };
  }

  factory PageResponse.fromMap(Map<String, dynamic> map) {
    return PageResponse(
      totalElements: map['total_elements'] as int,
      size: map['size'] as int,
      totalPages: map['total_pages'] as int,
      page: map['page'] as int,
    );
  }

  @override
  String toString() {
    return 'PageResponse(totalElements: $totalElements, size: $size, totalPages: $totalPages, page: $page)';
  }

  @override
  bool operator ==(covariant PageResponse other) {
    if (identical(this, other)) return true;

    return other.totalElements == totalElements &&
        other.size == size &&
        other.totalPages == totalPages &&
        other.page == page;
  }

  @override
  int get hashCode {
    return totalElements.hashCode ^ size.hashCode ^ totalPages.hashCode ^ page.hashCode;
  }
}
