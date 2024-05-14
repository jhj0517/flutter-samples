import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';
import 'presentation/views/views.dart';
import 'presentation/providers/providers.dart';
import 'data/repositories/repositories.dart';
import 'di/dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.register();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeProvider>(
              create: (context) => ThemeProvider(
                  prefs: locator.get<SharedPreferences>()
              )
          ),
          ChangeNotifierProvider<HomeProvider>(
              create: (context) => HomeProvider(
                memoRepository: locator.get<MemoRepository>(),
                binanceRepository: locator.get<BinanceRepository>()
              )
          ),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              title: 'Flutter MVVM Provider Template',
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: themeProvider.attrs.colors,
              home: const MyHomePage(),
            );
          },
        )
    );
  }
}

