class ProductFoods {
  final String name;
  final double price;
  final String image;

  ProductFoods(this.name, this.price, this.image);

  // Convert ProductFoods to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'image': image,
    };
  }
}
