import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinity_scroll/features/products/bloc/products_event.dart';
import 'package:infinity_scroll/features/products/bloc/products_state.dart';
import 'package:infinity_scroll/models/api/api_response.dart';
import 'package:infinity_scroll/models/product/product.dart';
import 'package:infinity_scroll/services/products_services/products_services.dart';
import 'package:infinity_scroll/utils/pref_utils.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  static const int _limit = 20;
  int _skip = 0;
  bool _hasMore = true;
  List<Product> _products = [];
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  Timer? _debounce;
  bool _isLoadingMore = false;

  bool get hasMore => _hasMore;

  bool get isLoadingMore => _isLoadingMore;

  List<Product> get products => _products;

  ProductsBloc() : super(LoadingFirst()) {
    on<LoadFirst>(_onLoadFirst);
    on<LoadMore>(_onLoadMore);
    on<SearchChanged>(_onSearchChanged);
  }

  Future<void> _onLoadFirst(
    LoadFirst event,
    Emitter<ProductsState> emit,
  ) async {
    _products.clear();
    emit(LoadingFirst());
    _skip = 0;
    String valueSearch = searchController.text;
    final result =
        valueSearch.isEmpty
            ? await ProductsServices.read.getListItems(_skip, _limit)
            : await ProductsServices.read.getListItemsSearch(
              _skip,
              _limit,
              valueSearch,
            );


    if (result is Success) {
      var data = (result as Success).data as ProductResponse;
      _products = List<Product>.from(data.products);
      _hasMore = data.products.length == _limit;
      emit(LoadSuccess(products: _products, hasMore: _hasMore));
    } else if (result is Fail) {
      var message = (result as Fail).message;
      emit(LoadFailure(message));
    } else {
      var message = (result as Error).message;
      emit(LoadError(message));
    }
  }

  Future<void> _onLoadMore(LoadMore event, Emitter<ProductsState> emit) async {
    if (!_hasMore || _isLoadingMore) return;
    _isLoadingMore = true;
    emit(LoadingMore());
    _skip += _limit;
    String valueSearch = searchController.text;
    final result =
        valueSearch.isEmpty
            ? await ProductsServices.read.getListItems(_skip, _limit)
            : await ProductsServices.read.getListItemsSearch(
              _skip,
              _limit,
              valueSearch,
            );

    if (result is Success) {
      var data = (result as Success).data as ProductResponse;
      _products.addAll(data.products);
      _hasMore = data.products.length == _limit;
      emit(LoadSuccess(products: _products, hasMore: _hasMore));
    } else if (result is Fail) {
      var message = (result as Fail).message;
      emit(LoadFailure(message));
    } else {
      var message = (result as Error).message;
      emit(LoadError(message));
    }

    _isLoadingMore = false;
  }

  Future<void> _onSearchChanged(
    SearchChanged event,
    Emitter<ProductsState> emit,
  ) async {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      add(LoadFirst());
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    searchController.dispose();
    return super.close();
  }

}
