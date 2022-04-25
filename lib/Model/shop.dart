class Shop {
  late int? id; // nullable
  late String? name;
  late String? logoUrl;
  late String? email;
  late String? websiteUrl;
  late String? city;
  late String? country;
  late String? contactNumber;

  Shop({
    this.id,
    this.name,
    this.logoUrl,
    this.email,
    this.websiteUrl,
    this.city,
    this.country,
    this.contactNumber,
  });
  
  @override
  String toString() {
    return '$name : $country';
  }
}
