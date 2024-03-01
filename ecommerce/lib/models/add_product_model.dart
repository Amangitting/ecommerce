import 'package:flutter/material.dart';

class AddProductModel {
  int ?id;
  String? title;
  String? description;
  num? price;
  num? discountPercentage;
  num? rating;
  num? stock;
  String? brand;
  String? category;

  AddProductModel(
      {this.title,
      this.id,
      this.description,
      this.price,
      this.discountPercentage,
      this.rating,
      this.stock,
      this.brand,
      this.category});

  AddProductModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
        id = json['id'];

    description = json['description'];
    price = json['price'];
    discountPercentage = json['discountPercentage'];
    rating = json['rating'];
    stock = json['stock'];
    brand = json['brand'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
        data['id'] = id;

    data['description'] = description;
    data['price'] = price;
    data['discountPercentage'] = discountPercentage;
    data['rating'] = rating;
    data['stock'] = stock;
    data['brand'] = brand;
    data['category'] = category;
    return data;
  }
    Map<String, dynamic> toFormData() {
    return {
      'title': title??"",
 
    };
  }
}
