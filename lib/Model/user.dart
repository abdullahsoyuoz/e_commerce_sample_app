class User {
 int? id; // nullable
   String? name;
   String? surname;
   String? photoUrl;

  User({
    this.id,
    this.name,
    this.surname,
    this.photoUrl,
  });

  factory User.fromJson(Map<String, dynamic> item) {
    return User(
      id: item["id"],
      name: item["name"],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
