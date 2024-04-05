import 'dart:math';

import 'package:flutter/material.dart';
import 'package:from_zero_to_hero_ht/features/products/presentation/products_category_page.dart';

MaterialColor getMaterialColor(int index) {
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
    Colors.blueGrey
  ];

  if (index + 1 > colors.length) {
    return colors[index - colors.length];
  }

  return colors[index];
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category, required this.indexColor});

  final int indexColor;
  final String category;

  @override
  Widget build(BuildContext context) {
    MaterialColor color = getMaterialColor(indexColor);

    return Card(
      elevation: 4,
      color: color.shade400,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        splashColor: color.shade900.withAlpha(180),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductBycategoryConsumer(category),
            ),
          );
        },
        child: SizedBox(
          width: 200,
          height: 150,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _CategoryCardBackgroundPainter(color: color),
                ),
              ),
              Center(
                child: Text(
                  category.replaceAll('-', ' ').toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color.shade50,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryCardBackgroundPainter extends CustomPainter {
  final MaterialColor color;

  _CategoryCardBackgroundPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.shade500;
    final circleRadius = min(size.width, size.height) / 2;

    canvas.drawCircle(
      Offset(-circleRadius / 2, -circleRadius / 2),
      circleRadius,
      paint,
    );

    paint.color = color.shade600;
    canvas.drawCircle(
      Offset(size.width + circleRadius / 2, size.height + circleRadius / 2),
      circleRadius,
      paint,
    );

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
