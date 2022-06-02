class WrapMap {
  final Map<String, dynamic> data;
  WrapMap({
    this.data = const {},
  });

  factory WrapMap.fromJson(Map<String, dynamic> json) => WrapMap(data: json);
  Map<String, dynamic> toJson() => data;
}