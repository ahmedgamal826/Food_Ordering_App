// class Offer {
//   final String title;
//   final String description;
//   final String imageUrl;
//   final String discount;

//   Offer({
//     required this.title,
//     required this.description,
//     required this.imageUrl,
//     required this.discount,
//   });
// }

class Offer {
  final String title;
  final double originalPrice;
  final double discountedPrice;
  final String imageUrl;
  final String discount;

  Offer({
    required this.title,
    required this.originalPrice,
    required this.discountedPrice,
    required this.imageUrl,
    required this.discount,
  });
}
