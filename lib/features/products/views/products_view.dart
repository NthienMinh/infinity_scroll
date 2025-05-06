import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinity_scroll/configs/color_configs.dart';
import 'package:infinity_scroll/configs/text_style_configs.dart';
import 'package:infinity_scroll/features/products/bloc/favorites/favorites_cubit.dart';
import 'package:infinity_scroll/features/products/bloc/products_bloc.dart';
import 'package:infinity_scroll/features/products/bloc/products_event.dart';
import 'package:infinity_scroll/features/products/bloc/products_state.dart';
import 'package:infinity_scroll/models/product/product.dart';
import 'package:infinity_scroll/resource/texts/texts.dart';
import 'package:infinity_scroll/utils/resizable_utils.dart';
import 'package:infinity_scroll/widgets/warning_widget.dart';

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
      return WarningWidget(
        text: Texts.productsText.getDataFail,
        onPressed: () {
          bloc.add(LoadFirst());
        },
      );
    }
    if (bloc.state is LoadError) {
      return WarningWidget(
        text: Texts.productsText.getDataError,
        onPressed: () {
          bloc.add(LoadFirst());
        },
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        bloc.add(LoadFirst());
      },
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: bloc.scrollController,
            child: Column(
              children: [
                SizedBox(height: Resizable.size(context, 80)),
                if (bloc.state is LoadingFirst)
                  const Center(child: CircularProgressIndicator()),
                ...bloc.products.map(
                  (e) => ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.title,
                          style: TextStyleConfigs.bigTextStyle(context),
                        ),
                        Text(
                          '${e.price}\$',
                          style: TextStyleConfigs.smallTextStyle(context),
                        ),
                      ],
                    ),
                    trailing: BlocBuilder<FavoritesCubit, List<int>>(
                      bloc: favoritesCubit,
                      builder: (c, s) {
                        return IconButton(
                          onPressed: () {
                            favoritesCubit.toggleFavorite(e);
                          },
                          icon: Icon(
                            Icons.favorite,
                            color:
                                favoritesCubit.isFavorite(e)
                                    ? Colors.red
                                    : Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                if (bloc.state is LoadingMore)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
          SizedBox(
            height: Resizable.size(context, 80),
            child: Padding(
              padding: EdgeInsets.all(Resizable.padding(context, 10)),
              child: TextField(
                controller: bloc.searchController,
                onChanged: (value) {
                  bloc.add(SearchChanged());
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: ColorConfigs.whiteColor,
                  border: const OutlineInputBorder(),
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
          ),
        ],
      ),
    );
  }
}
