class Product {
  String? id;
  bool? active;
  List<String>? attributes;
  int? createdAt;
  String? description;
  List<String>? images;
  Metadata? metadata;
  String? name;
  PackageDimensions? packageDimensions;
  bool? shippable;
  List<Null>? skus;
  String? statementDescriptor;
  String? type;
  String? unitLabel;
  int? updatedAt;

  Product(
      {this.id,
      this.active,
      this.attributes,
      this.createdAt,
      this.description,
      this.images,
      this.metadata,
      this.name,
      this.packageDimensions,
      this.shippable,
      this.skus,
      this.statementDescriptor,
      this.type,
      this.unitLabel,
      this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    attributes = json['attributes'].cast<String>();
    createdAt = json['created_at'];
    description = json['description'];
    images = json['images'].cast<String>();
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    name = json['name'];
    packageDimensions = json['package_dimensions'] != null
        ? new PackageDimensions.fromJson(json['package_dimensions'])
        : null;
    shippable = json['shippable'];

    statementDescriptor = json['statement_descriptor'];
    type = json['type'];
    unitLabel = json['unit_label'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['active'] = this.active;
    data['attributes'] = this.attributes;
    data['created_at'] = this.createdAt;
    data['description'] = this.description;
    data['images'] = this.images;
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.toJson();
    }
    data['name'] = this.name;
    if (this.packageDimensions != null) {
      data['package_dimensions'] = this.packageDimensions!.toJson();
    }
    data['shippable'] = this.shippable;

    data['statement_descriptor'] = this.statementDescriptor;
    data['type'] = this.type;
    data['unit_label'] = this.unitLabel;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Metadata {
  Metadata.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class PackageDimensions {
  int? height;
  int? length;
  int? weight;
  int? width;

  PackageDimensions({this.height, this.length, this.weight, this.width});

  PackageDimensions.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    length = json['length'];
    weight = json['weight'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['length'] = this.length;
    data['weight'] = this.weight;
    data['width'] = this.width;
    return data;
  }
}
