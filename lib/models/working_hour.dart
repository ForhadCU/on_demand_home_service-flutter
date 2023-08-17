class WorkingHour {
  int? quantity;
  String? matrix;

  WorkingHour({this.quantity, this.matrix});

  WorkingHour.fromJson(Map<String, dynamic> json) {
    quantity = json["quantity"];
    matrix = json["matrix"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["quantity"] = quantity;
    data["matrix"] = matrix;

    return data;
  }
}
