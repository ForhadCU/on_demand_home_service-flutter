class ServiceCategory {
  String? name;
  String? iconUri;

  ServiceCategory({this.name, this.iconUri});

  ServiceCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    iconUri = json['iconUri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['iconUri'] = iconUri;
    return data;
  }
}