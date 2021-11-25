class ProfileModel {
  int? id;
  String? name;
  String? image;

  ProfileModel({
    this.id,
    this.name,
    this.image,
  });

  factory ProfileModel.fromDatabaseJson(Map<String, dynamic> data) {
    return ProfileModel(
      id: data['id'],
      name: data['name'],
      image: data['image'],
    );
  }

  Map<String, dynamic> toDatabaseJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
