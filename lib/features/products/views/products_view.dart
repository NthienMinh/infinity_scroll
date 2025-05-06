import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinity_scroll/configs/text_style_configs.dart';
import 'package:infinity_scroll/features/products/bloc/favorites/favorites_cubit.dart';
import 'package:infinity_scroll/features/products/bloc/products_bloc.dart';
import 'package:infinity_scroll/features/products/bloc/products_event.dart';
import 'package:infinity_scroll/features/products/bloc/products_state.dart';
import 'package:infinity_scroll/models/product/product.dart';
import 'package:infinity_scroll/resource/texts/texts.dart';
import 'package:infinity_scroll/utils/resizable_utils.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<ProductsBloc>();
    var favoritesCubit = context.read<FavoritesCubit>();
    bloc.scrollController.addListener(() {
      if (bloc.scrollController.position.pixels >=
              bloc.scrollController.position.maxScrollExtent - 100 &&
          !bloc.isLoadingMore &&
          bloc.hasMore) {
        bloc.add(LoadMore());
      }
    });
    if (bloc.state is LoadFailure) {
      return Center(child: Text(Texts.productsText.getDataFail));
    }
    if (bloc.state is LoadError) {
      return Center(child: Text(Texts.productsText.getDataError));
    }

    return SingleChildScrollView(
      controller: bloc.scrollController,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(Resizable.padding(context, 10)),
            child: TextField(
              controller: bloc.searchController,
              onChanged: (value) {
                bloc.add(SearchChanged());
              },
              decoration: InputDecoration(
                hintText: Texts.productsText.hintSearch,
                suffixIcon:
                    bloc.searchController.text.isNotEmpty
                        ? IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            bloc.searchController.clear();
                            bloc.add(LoadFirst());
                          },
                        )
                        : null,
              ),
            ),
          ),
          if (bloc.state is LoadingFirst)
            const Center(child: CircularProgressIndicator()),
          ...bloc.products.map(
            (e) => ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e.title, style: TextStyleConfigs.bigTextStyle(context)),
                  Text(
                    '${e.price}\$',
                    style: TextStyleConfigs.smallTextStyle(context),
                  ),
                ],
              ),
              trailing: BlocBuilder<FavoritesCubit, List<Product>>(
                  bloc: favoritesCubit,
                  builder: (c,s){
                return IconButton(
                  onPressed: () {
                    favoritesCubit.toggleFavorite(e);
                  },
                  icon: Icon(
                      Icons.favorite,
                      color:
                      favoritesCubit.isFavorite(e) ? Colors.red : Colors.grey
                  ),
                );
              }),
            ),
          ),
          if (bloc.state is LoadingMore)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
