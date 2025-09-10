import 'package:eff_mob_tes_app/data/themes.dart';
import 'package:eff_mob_tes_app/logic/home_page/bloc/home_bloc_bloc.dart';
import 'package:eff_mob_tes_app/view/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBlocBloc()),
        // BlocProvider(create: (context) => SubjectBloc()),
      ],
      child: MaterialApp(
        title: 'Characters',
        debugShowCheckedModeBanner: false,
        theme: kLightTheme,

        home: const MainPage(),
      ),
    );
  }
}



        //*TODO dark theme and switch
        //*TODO favorites database