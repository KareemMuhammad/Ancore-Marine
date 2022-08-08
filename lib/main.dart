import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/blocs/cart_bloc/cart_cubit.dart';
import 'package:shop_app/blocs/categories_bloc/categories_cubit.dart';
import 'package:shop_app/blocs/maintenance_services_bloc/maintenance_cubit.dart';
import 'package:shop_app/blocs/product_bloc/product_cubit.dart';
import 'package:shop_app/models/favorite.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/repositories/cart_repo.dart';
import 'package:shop_app/repositories/categories_repo.dart';
import 'package:shop_app/repositories/maintenance_repo.dart';
import 'package:shop_app/repositories/products_repo.dart';
import 'package:shop_app/repositories/user_repo.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/services/about_service.dart';
import 'package:shop_app/theme.dart';
import 'blocs/about_bloc/about_cubit.dart';
import 'blocs/language_bloc/locale_cubit.dart';
import 'blocs/login_bloc/login_cubit.dart';
import 'blocs/register_bloc/register_cubit.dart';
import 'helper/language_delegate.dart';
import 'package:hive_flutter/hive_flutter.dart';

String? langCode;
String? userToken;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Hive.initFlutter();
  langCode = prefs.getString('lang');
  userToken = prefs.getString('authToken');
  Hive.registerAdapter(FavoriteAdapter());
  Hive.registerAdapter(ProductsAdapter());
  Hive.registerAdapter(ImagesAdapter());
  await Hive.openBox<Favorite>('favorite');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AboutCubit(aboutService: AboutService()),
        ),
        BlocProvider(
          create: (context) => LocaleCubit()..getStartLang(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(userRepository: UserRepository())
            ..getCurrentUser(userToken ?? ''),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(userRepository: UserRepository()),
        ),
        BlocProvider(
          create: (context) => CategoriesCubit(categoriesRepo: CategoriesRepo()),
        ),
        BlocProvider(
          create: (context) => ProductsCubit(productsRepo: ProductsRepo()),
        ),
        BlocProvider(
          create: (context) => MaintenanceCubit(maintenanceRepo: MaintenanceRepo()),
        ),
        BlocProvider(
          create: (context) => CartCubit(cartRepo: CartRepo()),
        ),
      ],
      child: BlocBuilder<LocaleCubit,LocaleState>(
          buildWhen: (previousState, currentState) =>
          previousState != currentState,
          builder: (context,state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme(),
            initialRoute: SplashScreen.routeName,
            routes: routes,
            supportedLocales: const[
              Locale('en'),
              Locale('ar'),
            ],
            localizationsDelegates: const[
              AppLocale.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: state.locale,
            localeResolutionCallback: (Locale? locale,
                Iterable<Locale> supportedLocales,) {
              if (locale != null) {
                for (Locale myLocal in supportedLocales) {
                  if (myLocal.countryCode == locale.countryCode) {
                    return locale;
                  }
                }
              }
              return supportedLocales.first;
            },
          );
        }
      ),
    );
  }
}
