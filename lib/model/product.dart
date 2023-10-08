import 'dart:convert';

import 'package:clothing/constants/server.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../helpers/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    _toggleFavorite();

    final response = await http.patch(
      Uri.https(ServerConstants.domain,
          ServerConstants.updateAndDeletePath(ApiPaths.products, id)),
      body: jsonEncode({
        'isFavorite': isFavorite.toString(),
      }),
    );
    if (response.statusCode >= 400) {
      _toggleFavorite();
      throw AppHttpException(
          statusCode: 400,
          msg: 'There was an error when favoriting the product');
    }
  }
}

List<Product> mockProducts = [
  Product(
    id: '',
    title: 'Red Shirt',
    description: 'A red shirt - it is pretty red!',
    price: 29.99,
    imageUrl:
        'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
  ),
  Product(
    id: '',
    title: 'Trousers',
    description: 'A nice pair of trousers.',
    price: 59.99,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
  ),
  Product(
    id: '',
    title: 'Yellow Scarf',
    description: 'Warm and cozy - exactly what you need for the winter.',
    price: 19.99,
    imageUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
  ),
  Product(
    id: '',
    title: 'A Pan',
    description: 'Prepare any meal you want.',
    price: 49.99,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
  ),
  Product(
    id: '',
    title: 'Blue Dress',
    description: 'A beautiful blue dress for special occasions.',
    price: 39.99,
    imageUrl: 'https://m.media-amazon.com/images/I/71JXtHV4AsL._AC_SX569_.jpg',
  ),
  Product(
    id: '',
    title: 'Running Shoes',
    description: 'Comfortable shoes for your daily runs.',
    price: 79.99,
    imageUrl: 'https://m.media-amazon.com/images/I/71RiiEL5XkL._AC_SX575_.jpg',
  ),
  Product(
    id: '',
    title: 'Coffee Maker',
    description: 'Brew your favorite coffee with this stylish machine.',
    price: 89.99,
    imageUrl:
        'https://m.media-amazon.com/images/I/41aguIvkgKL.__AC_SX300_SY300_QL70_ML2_.jpg',
  ),
  Product(
    id: '',
    title: 'Headphones',
    description: 'High-quality headphones for music lovers.',
    price: 129.99,
    imageUrl: 'https://m.media-amazon.com/images/I/71VEeIkehCL._AC_UL320_.jpg',
  ),
  Product(
    id: '',
    title: 'Leather Wallet',
    description: 'A stylish leather wallet with multiple card slots.',
    price: 24.99,
    imageUrl: 'https://m.media-amazon.com/images/I/81yPAojLoxL._AC_UL320_.jpg',
  ),
];
