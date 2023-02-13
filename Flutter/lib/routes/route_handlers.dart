import 'package:algo_learn/ui/screens/main/home/home.dart';
import 'package:algo_learn/models/algorand_standard_asset_model.dart';
import 'package:algo_learn/models/navigation/navigation_bloc.dart';
<<<<<<< HEAD:lib/routes/route_handlers.dart
import 'package:algo_learn/ui/screens/main/me/me.dart';
=======
import 'package:algo_learn/ui/screens/main/me/profile2.dart';
>>>>>>> e43f48216f76a3bc5f72097dbe4992e89a0cc2ff:Flutter/lib/routes/route_handlers.dart
import 'package:algo_learn/routes/routes.dart';
import 'package:algo_learn/theme/themes.dart';
import 'package:algo_learn/ui/screens/asset/create/asset_form.dart';
import 'package:algo_learn/ui/screens/asset/transfer/asset_transfer.dart';
import 'package:algo_learn/ui/screens/main/bloc/main_bloc.dart';
import 'package:algo_learn/ui/screens/main/wallets/wallet_page.dart';
import 'package:algo_learn/ui/screens/screens.dart';
import 'package:algo_learn/ui/screens/share/share_address_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:algo_learn/ui/screens/main/login/login_page.dart';
import 'package:algo_learn/ui/screens/main/signup/signup.dart';
import 'package:algo_learn/ui/screens/main/courses/course_page.dart';
// import 'package:algo_learn/ui/screens/main/wallet/wallet.dart';
import 'package:algo_learn/ui/screens/main/me/edit_me.dart';

var editProfileHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return EditProfilePage();
});

// var walletsHandler = Handler(
//     handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
//   return WalletsPage();
// });

var MeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return MePage2();
});

var courseHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return CoursePage();
});

var HomeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return HomePage();
});

var signHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
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
