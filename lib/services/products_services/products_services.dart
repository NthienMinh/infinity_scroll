import 'package:infinity_scroll/services/products_services/products_read.dart';
import 'package:infinity_scroll/services/products_services/products_write.dart';

class ProductsServices {
  ProductsServices._internal();

  static final ProductsRead _read = ProductsRead();
  static final ProductsWrite _write = ProductsWrite();

  static ProductsRead get read => _read;
  static ProductsWrite get write => _write;
}
