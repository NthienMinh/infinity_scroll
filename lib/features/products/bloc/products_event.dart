abstract class ProductsEvent {}

class LoadFirst extends ProductsEvent {
  LoadFirst();
}

class LoadMore extends ProductsEvent {
  LoadMore();
}

class SearchChanged extends ProductsEvent {
  SearchChanged();
}
