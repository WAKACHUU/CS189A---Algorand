import 'package:algorand_dart/algorand_dart.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:algo_learn/models/navigation/navigation_bloc.dart';
import 'package:algo_learn/models/navigation/navigation_tab.dart';
import 'package:algo_learn/theme/themes.dart';
import 'package:algo_learn/ui/screens/main/bloc/main_bloc.dart';
import 'package:algo_learn/ui/screens/main/dashboard/dashboard.dart';
import 'package:algo_learn/ui/screens/main/profile/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

final tabHandlers = <NavigationTab, Widget>{
  NavigationTab(label: 'Dashboard', icon: FeatherIcons.barChart2):
      provideDashboardPage(),
  NavigationTab(label: 'Wallet', icon: FeatherIcons.pocket):
      provideWalletPage(),
  // NavigationTab(label: 'Assets', icon: FeatherIcons.shoppingCart):
  //     provideAssetPage(),
  NavigationTab(label: 'Profile', icon: FeatherIcons.user):
      provideProfilePage(),
};

final tabs = tabHandlers.keys.toList();

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  // static String routeName = '/mainScreen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Palette.accentColor,
          title: Text(
            'Block Chain',
            style: TextStyle(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ))),
      body: SafeArea(
        child: BlocListener<MainBloc, Account?>(
          listener: (context, state) {
            context.read<NavigationBloc>().changeTab(tabs[0]);
          },
          child: Builder(
            builder: (BuildContext context) {
              final navigationTab = context.watch<NavigationBloc>().currentTab;
              final index = tabs.indexOf(navigationTab);
              return IndexedStack(
                index: index,
                children: tabHandlers.values.toList(),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Builder(
        builder: (context) {
          final navigationTab = context.watch<NavigationBloc>().currentTab;
          final index = tabs.indexOf(navigationTab);

          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Palette.activeColor,
            unselectedItemColor: Palette.inactiveColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: index,
            onTap: (index) =>
                context.read<NavigationBloc>().changeTab(tabs[index]),
            items: List.generate(
              tabs.length,
              (index) => BottomNavigationBarItem(
                label: tabs[index].label,
                icon: Icon(tabs[index].icon),
              ),
            ),
          );
        },
      ),
    );
  }
}
