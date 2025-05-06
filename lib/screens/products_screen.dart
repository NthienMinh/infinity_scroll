import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinity_scroll/features/products/bloc/products_bloc.dart';
import 'package:infinity_scroll/features/products/bloc/products_event.dart';
import 'package:infinity_scroll/features/products/bloc/products_state.dart';
import 'package:infinity_scroll/features/products/views/products_view.dart';
import 'package:infinity_scroll/resource/texts/texts.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Texts.productsText.products)),
      body: BlocProvider(
        create: (context) => ProductsBloc()..add(LoadFirst()),
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            return ProductsView();
          },
        ),
      ),
    );
  }
}
