part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

final class ThemeSwitchThemeEvent extends ThemeEvent {}

final class ThemeSetInitialTheme extends ThemeEvent {
  final bool isDark;

  const ThemeSetInitialTheme({required this.isDark});

  @override
  List<Object> get props => [isDark];
}
