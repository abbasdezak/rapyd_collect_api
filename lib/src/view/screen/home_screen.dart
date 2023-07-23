import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rapyd_collect_api/core/app_color.dart';
import 'package:rapyd_collect_api/core/app_data.dart';
import 'package:rapyd_collect_api/src/view/screen/cart_screen.dart';
import 'package:rapyd_collect_api/src/view/screen/plans_screen.dart';
import 'package:rapyd_collect_api/src/controller/office_furniture_controller.dart';
import 'package:rapyd_collect_api/src/view/screen/items_screen.dart';

final OfficeFurnitureController controller =
    Get.put(OfficeFurnitureController());

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  final List<Widget> screens = const [
    Items(),
    PlansScreen(),
    CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () {
          return BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            currentIndex: controller.currentBottomNavItemIndex.value,
            showUnselectedLabels: true,
            onTap: controller.switchBetweenBottomNavigationItems,
            fixedColor: AppColor.lightBlack,
            items: AppData.bottomNavigationItems
                .map(
                  (element) => BottomNavigationBarItem(
                      icon: element.icon, label: element.label),
                )
                .toList(),
          );
        },
      ),
      body: Obx(() => screens[controller.currentBottomNavItemIndex.value]),
    );
  }
}
