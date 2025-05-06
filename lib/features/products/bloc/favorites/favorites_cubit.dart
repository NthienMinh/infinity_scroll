
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinity_scroll/models/product/product.dart';
import 'package:infinity_scroll/utils/pref_utils.dart';

class FavoritesCubit extends Cubit<List<Product>> {
  FavoritesCubit() : super([]) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    List<Product> favorites = await PrefUtils().loadFavorites();
    emit(favorites);
  }

  Future<void> toggleFavorite(Product product) async {
    final current = [...state];
    final exists = current.any((p) => p.id == product.id);

    if (exists) {
      current.removeWhere((p) => p.id == product.id);
    } else {
      current.add(product);
    }

    await PrefUtils().saveFavorites(current);
    emit(current);
  }

  bool isFavorite(Product product) {
    return state.any((p) => p.id == product.id);
  }
}