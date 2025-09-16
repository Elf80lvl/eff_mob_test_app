import 'package:eff_mob_tes_app/logic/home_page/bloc/home_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageErrorWidget extends StatelessWidget {
  final String message;
  const HomePageErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBlocBloc, HomeBlocState>(
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Error: $message'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.read<HomeBlocBloc>().add(
                    const HomeBlocGetDataEvent(page: 1),
                  );
                },
                child: Text('Refresh'),
              ),
            ],
          ),
        );
      },
    );
  }
}
