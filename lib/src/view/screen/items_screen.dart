import 'package:flutter/material.dart';
import 'package:rapyd_collect_api/core/app_data.dart';
import 'package:rapyd_collect_api/core/app_style.dart';
import 'package:rapyd_collect_api/src/model/furniture.dart';
import 'package:rapyd_collect_api/src/view/widget/furniture_list_view.dart';
import 'package:rapyd_collect_api/src/view/screen/items_detail_screen.dart';

class Items extends StatelessWidget {
  const Items({Key? key}) : super(key: key);

  PreferredSize _appBar() {
    return const PreferredSize(
      preferredSize: Size.fromHeight(120),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hello Sina", style: h2Style),
                  Text("Buy Your favorite desk", style: h3Style),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<Widget?> navigate(Furniture furniture) {
      return Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(seconds: 1),
          pageBuilder: (_, __, ___) => ItemsDetailScreen(furniture: furniture),
        ),
      );
    }

    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            const Text("Products", style: h2Style),
            FurnitureListView(
              furnitureList: AppData.furnitureList,
              isHorizontal: false,
              onTap: navigate,
            ),
          ],
        ),
      ),
    );
  }
}
