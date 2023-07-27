import 'package:rapyd_collect_api/core/models/product.dart';

class Plan {
  String? id;
  String? aggregateUsage;
  String? amount;
  String? billingScheme;
  int? createdAt;
  String? currency;
  String? interval;
  int? intervalCount;
  Metadata? metadata;
  Product? product;
  String? nickname;
  List<Tiers>? tiers;
  String? tiersMode;
  TransformUsage? transformUsage;
  int? trialPeriodDays;
  String? usageType;

  Plan(
      {this.id,
      this.aggregateUsage,
      this.amount,
      this.billingScheme,
      this.createdAt,
      this.currency,
      this.interval,
      this.intervalCount,
      this.metadata,
      this.product,
      this.nickname,
      this.tiers,
      this.tiersMode,
      this.transformUsage,
      this.trialPeriodDays,
      this.usageType});

  Plan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aggregateUsage = json['aggregate_usage'];
    amount = json['amount'].toString();
    billingScheme = json['billing_scheme'];
    createdAt = json['created_at'];
    currency = json['currency'];
    interval = json['interval'];
    intervalCount = json['interval_count'];
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    nickname = json['nickname'];
    if (json['tiers'] != null) {
      tiers = <Tiers>[];
      json['tiers'].forEach((v) {
        tiers!.add(new Tiers.fromJson(v));
      });
    }
    tiersMode = json['tiers_mode'];
    transformUsage = json['transform_usage'] != null
        ? new TransformUsage.fromJson(json['transform_usage'])
        : null;
    trialPeriodDays = json['trial_period_days'];
    usageType = json['usage_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['aggregate_usage'] = this.aggregateUsage;
    data['amount'] = this.amount;
    data['billing_scheme'] = this.billingScheme;
    data['created_at'] = this.createdAt;
    data['currency'] = this.currency;
    data['interval'] = this.interval;
    data['interval_count'] = this.intervalCount;
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['nickname'] = this.nickname;
    if (this.tiers != null) {
      data['tiers'] = this.tiers!.map((v) => v.toJson()).toList();
    }
    data['tiers_mode'] = this.tiersMode;
    if (this.transformUsage != null) {
      data['transform_usage'] = this.transformUsage!.toJson();
    }
    data['trial_period_days'] = this.trialPeriodDays;
    data['usage_type'] = this.usageType;
    return data;
  }
}

class Metadata {
  Metadata();

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

class Tiers {
  double? amount;
  String? upTo;
  int? flatAmount;

  Tiers({this.amount, this.upTo, this.flatAmount});

  Tiers.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    upTo = json['up_to'];
    flatAmount = json['flat_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['up_to'] = this.upTo;
    data['flat_amount'] = this.flatAmount;
    return data;
  }
}

class TransformUsage {
  int? divideBy;
  String? round;

  TransformUsage({this.divideBy, this.round});

  TransformUsage.fromJson(Map<String, dynamic> json) {
    divideBy = json['divide_by'];
    round = json['round'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['divide_by'] = this.divideBy;
    data['round'] = this.round;
    return data;
  }
}
