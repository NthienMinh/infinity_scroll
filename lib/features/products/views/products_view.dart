import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinity_scroll/configs/text_style_configs.dart';
import 'package:infinity_scroll/features/products/bloc/products_bloc.dart';
import 'package:infinity_scroll/features/products/bloc/products_event.dart';
import 'package:infinity_scroll/features/products/bloc/products_state.dart';
import 'package:infinity_scroll/resource/texts/texts.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<ProductsBloc>();

    bloc.scrollController.addListener(() {
      if (bloc.scrollController.position.pixels >=
              bloc.scrollController.position.maxScrollExtent - 100 &&
          !bloc.isLoadingMore &&
          bloc.hasMore) {
        bloc.add(LoadMore());
      }
    });

    if (bloc.state is LoadingFirst) {
      return const Center(child: CircularProgressIndicator());
    }
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
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite),
              ),
            ),
          ),
          if (bloc.state is LoadingMore)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
