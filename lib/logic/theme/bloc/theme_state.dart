part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  final bool isDark;
  const ThemeState({this.isDark = false});

  @override
  List<Object> get props => [isDark];
}

class ThemeInitial extends ThemeState {}

class ThemeWithDataState extends ThemeState {
  const ThemeWithDataState({required bool isDark}) : super(isDark: isDark);
}
