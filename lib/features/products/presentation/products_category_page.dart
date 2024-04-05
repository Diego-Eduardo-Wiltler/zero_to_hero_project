
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:from_zero_to_hero_ht/features/products/presentation/product_detail_page.dart';
import 'package:from_zero_to_hero_ht/features/products/presentation/providers/product_provider.dart';

MaterialColor _getDynamicColor(int index) {
  final colors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
  ];
  return colors[index % colors.length];
}

class ProductBycategoryConsumer extends ConsumerWidget {
  const ProductBycategoryConsumer(this.category, {super.key});

  final String category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsByCategoryProvider(category: category));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products By Category'),
      ),
      body: products.when(
        data: (data) {
          return ListView.separated(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final product = data[index];
              final color = _getDynamicColor(index);
              return Card(
                margin: const EdgeInsets.all(8),
                color: color.shade100,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: color.shade500,
                    child: Text(
                      product.title[0]
                          .toUpperCase(), // Primeira letra do título
                      style: TextStyle(color: color.shade50),
                    ),
                  ),
                  title: Text(product.title,
                      style: TextStyle(color: color.shade900)),
                  subtitle: Text(product.category,
                      style: TextStyle(color: color.shade700)),
                    onTap: () => ProductDetail.showModal(context, product),

                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          );
        },
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
