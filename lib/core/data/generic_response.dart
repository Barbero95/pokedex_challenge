import 'dart:convert';

class GenericResponse {
  int statusCode;

  GenericResponse({
    required this.statusCode,
  });

  @override
  String toString() {
    return 'GenericResponse(status: $statusCode,)';
  }

  factory GenericResponse.fromMap(Map<String, dynamic> data) {
    return GenericResponse(
      statusCode: data['status'] as int,
    );
  }

  Map<String, dynamic> toMap() => {
        'status': statusCode,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GenericResponse].
  factory GenericResponse.fromJson(String data) {
    return GenericResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GenericResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  GenericResponse copyWith({
    int? statusCode,
  }) {
    return GenericResponse(
      statusCode: statusCode ?? this.statusCode,
    );
  }
}
