class Shop {
   int? id; // nullable
   String? name;
   String? logoUrl;
   String? email;
   String? websiteUrl;
   String? city;
 String? country;
   String? contactNumber;

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
