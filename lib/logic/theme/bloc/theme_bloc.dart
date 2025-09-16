import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<ThemeSetInitialTheme>((event, emit) {
      emit(ThemeWithDataState(isDark: event.isDark));
    });

    on<ThemeSwitchThemeEvent>((event, emit) {
      emit(ThemeWithDataState(isDark: !state.isDark));
    });
  }
}
