class Factory {
  const Factory({
    required this.name,
    required this.address,
    required this.image,
  });

  final String name;
  final String address;
  final String image;

  factory Factory.fromMap(Map<String, dynamic> map) => Factory(
        name: map['name'],
        address: map['address'],
        image: map['image'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'address': address,
        'image': image,
      };
}
