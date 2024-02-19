class AllPlanModel {
  String? id;
  String? name;
  int? price;

  AllPlanModel({this.id, this.name, this.price});

  AllPlanModel.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    id = json['id'];
    name = json['name'];
  }
}
