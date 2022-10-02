# Flutter Zoom Drawer Urban_block_party

A new Flutter project demonstrating the use of Flutter Zoom Drawer package.

## Getting Started

The checkout the full Urban_block_party :memo: [Urban_block_party Code](https://github.com/medyas/flutter_zoom_drawer/tree/master/Urban_block_party/)

```dart
class HomeScreen extends StatefulWidget {

  static const List<MenuItem> MAIN_MENU = [
    MenuItem("Payment", Icons.payment, 0),
    MenuItem("Promos", Icons.card_giftcard, 1),
    MenuItem("Notification", Icons.notifications, 2),
    MenuItem("Help", Icons.help, 3),
    MenuItem("About Us", Icons.info_outline, 4),
    MenuItem("Rate Us", Icons.star_border, 5),
  ];

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _drawerController = ZoomDrawerController();

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _drawerController,
      menuScreen: MenuScreen(
        HomeScreen.MAIN_MENU,
        callback: _updatePage,
        current: _currentPage,
      ),
      mainScreen: MainScreen(),
      borderRadius: 24.0,
      showShadow: false,
      angle: 0.0,
    );
  }

  void _updatePage(index) {
    context.read<MenuProvider>().updateCurrentPage(index);
    _drawerController.toggle();
  }
}
```
