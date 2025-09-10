import 'package:eff_mob_tes_app/logic/home_page/bloc/home_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                context.read<HomeBlocBloc>().add(HomeBlocGetDataEvent());
              },
              child: Text('get'),
            ),
          ],
        ),
      ),
    );
  }
}
