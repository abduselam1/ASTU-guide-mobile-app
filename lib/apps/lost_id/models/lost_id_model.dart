class LostIdModel {
  final int id;
  final String name;
  final String item;
  final String phoneNumber;
  final String identifier;
  final String createdAt;

  LostIdModel({
    this.id,
    this.name,
    this.item,
    this.phoneNumber,
    this.identifier,
    this.createdAt,
  });

  factory LostIdModel.fromJson(Map<String, dynamic> json) {
    return LostIdModel(
      id: json['id'],
      name: json['name'],
      item: json['item'],
      identifier: json['identifier'],
      phoneNumber: json['phone_number'],
      createdAt: json['created_at'],
    );
  }
}
