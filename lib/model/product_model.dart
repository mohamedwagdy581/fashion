class ProductModel
{
  late String id;
  late String name;
  late int price;
  late int oldPrice;
  late String image;
  late String details;
  late String brand;
  late String size;
  late String color;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.image,
    required this.details,
    required this.brand,
    required this.size,
    required this.color,
  });

  ProductModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image '];
    details = json['details '];
    oldPrice = json['oldPrice '];
    brand = json['brand '];
    size = json['size '];
    color = json['color '];
  }

  Map<String, dynamic> toMap ()
  {
    return {
      'id' : id,
      'name' : name,
      'price' : price,
      'image' : image,
      'details' : details,
      'oldPrice' : oldPrice,
      'brand' : brand,
      'size' : size,
      'color' : color,
    };
  }

}