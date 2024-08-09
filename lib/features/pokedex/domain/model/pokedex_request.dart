class PokedexRequest {
  PokedexRequest({
    this.limit,
    this.offset,
  });

  final int? limit;
  final int? offset;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};
    if (limit != null) map['limit'] = limit.toString();
    if (offset != null) map['offset'] = offset.toString();
    return map;
  }
}
