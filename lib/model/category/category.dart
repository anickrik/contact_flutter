const String tableCategories = 'categories';

class CategoryFields {
  static final List<String> values = [
    /// Add all fields
    id, name
  ];

  static const String id = '_id';
  static const String name = 'name';
}

class Category {
  final int? id;
  final String name;

  const Category({this.id, required this.name});

  Category copy({
    int? id,
    String? name,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  static Category fromJson(Map<String, Object?> json) => Category(
        id: json[CategoryFields.id] as int?,
        name: json[CategoryFields.name] as String,
      );

  Map<String, Object?> toJson() => {
        CategoryFields.id: id,
        CategoryFields.name: name,
      };
}
