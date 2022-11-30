import 'package:algo_learn/routes/routes.dart';
import 'package:algo_learn/ui/screens/asset/create/asset_form.dart';
import 'package:algo_learn/ui/screens/screens.dart';
import 'package:algo_learn/ui/screens/share/share_address_screen.dart';

final router = FluroRouter();

class RouteConfiguration {
  static Future<void> register() async {
    // Register the routes
    router.define("/", handler: rootHandler);
    router.define(AssetFormScreen.routeName, handler: assetFormHandler);
    router.define(AssetTransferScreen.routeName, handler: assetTransferHandler);
    router.define(ShareAddressScreen.routeName, handler: shareAddressHandler);
  }
}