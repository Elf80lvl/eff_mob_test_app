import 'package:flutter/material.dart';

class NoFavoritesWidget extends StatelessWidget {
  const NoFavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(999),
            child: Image.asset(
              'assets/images/rick.jpg',
              width: 300,
              // height: 200,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No favorites',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodySmall!.color!,
            ),
          ),
        ],
      ),
    );
  }
}
