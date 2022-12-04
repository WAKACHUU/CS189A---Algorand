import 'package:algo_learn/home/home.dart';
import 'package:algo_learn/models/algorand_standard_asset_model.dart';
import 'package:algo_learn/models/navigation/navigation_bloc.dart';
import 'package:algo_learn/profile/profile.dart';
import 'package:algo_learn/routes/routes.dart';
import 'package:algo_learn/theme/themes.dart';
import 'package:algo_learn/ui/screens/asset/create/asset_form.dart';
import 'package:algo_learn/ui/screens/asset/transfer/asset_transfer.dart';
import 'package:algo_learn/ui/screens/main/bloc/main_bloc.dart';
import 'package:algo_learn/ui/screens/main/wallets/wallet_page.dart';
import 'package:algo_learn/ui/screens/screens.dart';
import 'package:algo_learn/ui/screens/share/share_address_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:algo_learn/login/login_page.dart';
import 'package:algo_learn/signup/signup.dart';
import 'package:algo_learn/courses/course_page.dart';
import 'package:algo_learn/wallet/wallet.dart';

var walletsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return WalletsPage();
});

var MeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return MePage();
});


var courseHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return CoursePage();
});

var HomeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return HomePage();
});

var signHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return SignUpDemo();
});

var loginHandler = Handler(
  type: HandlerType.route,
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return LoginDemo();
});


var rootHandler = Handler(
  // type: HandlerType.route,
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(
          create: (_) => MainBloc(accountRepository: accountRepository),
        ),
        BlocProvider<NavigationBloc>(
          create: (_) => NavigationBloc(tabs[0]),
        ),
      ],
      child: MainScreen(),
    );
  },
);

var assetTransferHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    final asset = context?.settings?.arguments;
    if (asset is! AlgorandStandardAsset) return null;

    return BlocProvider(
      create: (_) =>
          AssetTransferBloc(accountRepository: accountRepository)..start(asset),
      child: AssetTransferScreen(),
    );
  },
);

var assetFormHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return BlocProvider<AssetFormBloc>(
      create: (_) => AssetFormBloc(accountRepository: accountRepository),
      child: AssetFormScreen(),
    );
  },
);

var shareAddressHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    final address = params['address']?[0] ?? '';

    return BlocProvider<AssetFormBloc>(
      create: (_) => AssetFormBloc(accountRepository: accountRepository),
      child: ShareAddressScreen(
        address: address,
      ),
    );
  },
);
