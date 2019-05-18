class Product {
  String id;
  String name;
  String description;
  String urlFoto;

  Product(
      {this.id,
        this.name,
        this.description,
        this.urlFoto});

  factory Product.fromJson(Map json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      urlFoto: json['urlFoto'] as String,
    );
  }

  @override
  String toString() {
    return "Product[$id]: $name";
  }
}