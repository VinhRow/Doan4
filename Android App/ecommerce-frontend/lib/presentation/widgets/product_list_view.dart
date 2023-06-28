import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/data/models/product/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/ui.dart';
import '../../logic/services/formatter.dart';
import '../screens/product/product_details_screen.dart';
import 'gap_widget.dart';

class ProductListView extends StatelessWidget {
  final List<ProductModel> products;

  const ProductListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return CupertinoButton(
          onPressed: () {
            Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                arguments: product);
          },
          padding: const EdgeInsets.only(bottom: 2),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blueGrey, // Màu đường viền
                width: 3.0, // Độ dày của đường viền
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                  child: CachedNetworkImage(
                    // width: MediaQuery.of(context).size.width / 3,
                    width: 120,
                    height: 120,
                    imageUrl: "${product.images?[0]}",
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${product.title}",
                        style: TextStyles.body1
                            .copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${product.description}",
                        style: TextStyles.body2
                            .copyWith(color: AppColors.textLight),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const GapWidget(),
                      Text(
                        Formatter.formatPrice(product.price!),
                        style: TextStyles.heading3,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
