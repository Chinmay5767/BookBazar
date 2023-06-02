class Books {
  int? item_id;
  String? name;
  double? rating;
  List<String>? type;
  double? price;
  String? author;

  String? description;
  String? image;

  Books({
    this.item_id,
    this.name,
    this.rating,
    this.type,
    this.price,
    this.author,
  
    this.description,
    this.image,
  });

  factory Books.fromJson(Map<String, dynamic> json) => Books(
        item_id: int.parse(json["item_id"]),
        name: json["name"],
        rating: double.parse(json["rating"]),
        type: json["type"].toString().split(", "),
        price: double.parse(json["price"]),
        author: json["author"],
        
        description: json['description'],
        image: json['image'],
      );
}
