import 'package:eff_mob_tes_app/data/const.dart';
import 'package:eff_mob_tes_app/logic/home_page/bloc/home_bloc_bloc.dart';
import 'package:eff_mob_tes_app/logic/theme/bloc/theme_bloc.dart';
import 'package:eff_mob_tes_app/services/system_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
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

          //*clear cache of characters
          ListTile(
            onTap: () {
              try {
                context.read<HomeBlocBloc>().add(HomeBlocClearCacheEvent());
                SystemMessage.showBottomMessage(
                  message: 'Cache cleared',
                  context: context,
                );
              } catch (e) {
                SystemMessage.showBottomMessage(
                  message: e.toString(),
                  context: context,
                );
              }
            },
            title: Text('Clear cache'),
            subtitle: Text('Delete all saved cached characters'),
          ),

          //*app version
          ListTile(subtitle: Text(kAppVersion)),
        ],
      ),
    );
  }
}
