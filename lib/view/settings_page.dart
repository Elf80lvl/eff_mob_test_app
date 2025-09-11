import 'package:eff_mob_tes_app/logic/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 16),
      children: [
        //*change theme
        BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return SwitchListTile(
              title: Text('Dark Theme'),
              value: state.isDark,
              onChanged: (value) {
                context.read<ThemeBloc>().add(ThemeSwitchThemeEvent());
              },
            );
          },
        ),
      ],
    );
  }
}
