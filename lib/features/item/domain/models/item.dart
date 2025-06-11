enum ItemStatus {
  lost,
  found,
  claimed,
}

class Item {
  final String id;
  final String name;
  final String description;
  final String location;
  final String imageUrl;
  final DateTime foundDate;
  final String foundTime;
  final String userId;
  final ItemStatus status;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.imageUrl,
    required this.foundDate,
    required this.foundTime,
    required this.userId,
    required this.status,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      location: json['location'],
      imageUrl: json['imageUrl'],
      foundDate: DateTime.parse(json['foundDate']),
      foundTime: json['foundTime'],
      userId: json['userId'],
      status: ItemStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => ItemStatus.found,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'location': location,
      'imageUrl': imageUrl,
      'foundDate': foundDate.toIso8601String(),
      'foundTime': foundTime,
      'userId': userId,
      'status': status.toString().split('.').last,
    };
  }

  Item copyWith({
    String? id,
    String? name,
    String? description,
    String? location,
    String? imageUrl,
    DateTime? foundDate,
    String? foundTime,
    String? userId,
    ItemStatus? status,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
      foundDate: foundDate ?? this.foundDate,
      foundTime: foundTime ?? this.foundTime,
      userId: userId ?? this.userId,
      status: status ?? this.status,
    );
  }
} 