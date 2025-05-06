
import 'package:infinity_scroll/models/product/product.dart';

abstract class ProductsState {}

class LoadingFirst extends ProductsState {}

class LoadingMore extends ProductsState {}

class LoadSuccess extends ProductsState {
  final List<Product> products;
  final bool hasMore;

  LoadSuccess({required this.products, required this.hasMore});
}

class LoadFailure extends ProductsState {
  final String message;

  LoadFailure(this.message);
}

class LoadError extends ProductsState {
  final String message;

  LoadError(this.message);
}

