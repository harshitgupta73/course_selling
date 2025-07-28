class Banners {
  final String imageUrl;
  final String? id;

  Banners({required this.imageUrl,this.id});

  factory Banners.fromJson(Map<String, dynamic> json) {
    return Banners(imageUrl: json['imageUrl'],id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {'imageUrl': imageUrl,'id':id};
  }
}
