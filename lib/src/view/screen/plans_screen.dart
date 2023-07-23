import 'package:get/get.dart';
import 'package:rapyd_collect_api/core/app_asset.dart';
import 'package:flutter/material.dart';
import 'package:rapyd_collect_api/core/app_style.dart';
import 'package:rapyd_collect_api/src/controller/office_furniture_controller.dart';
import 'package:rapyd_collect_api/src/view/widget/cart_list_view.dart';
import 'package:rapyd_collect_api/src/view/widget/counter_button.dart';
import 'package:rapyd_collect_api/src/view/widget/empty_widget.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({Key? key}) : super(key: key);

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Plans', style: h4Style),
          bottom: TabBar(controller: _tabController, tabs: [
            Text('Basic', style: h4Style),
            Text('Pro', style: h4Style),
            Text('Advanced', style: h4Style),
          ]),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            PlanTabView(
                title: 'Basic',
                subTitle: '5.99 \$',
                details: '10 musics per month \n 128 quality',
                onTap: () {}),
            PlanTabView(
                title: 'Pro',
                subTitle: '15.99 \$',
                details: '20 musics per month \n 128,320 quality',
                onTap: () {}),
            PlanTabView(
                title: 'Advanced',
                subTitle: '25.99 \$',
                details: '50 musics per month \n 128,320,HiFi quality',
                onTap: () {}),
          ],
        ));
  }
}

class PlanTabView extends StatelessWidget {
  const PlanTabView({
    super.key,
    required this.title,
    required this.subTitle,
    required this.details,
    required this.onTap,
  });

  final String title;
  final String subTitle;
  final String details;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey[200]!,
          )),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * .1,
          ),
          Text(
            title,
            style: h15Style,
            textAlign: TextAlign.center,
          ),
          Text(
            subTitle,
            style: h2Style,
            textAlign: TextAlign.center,
          ),
          Text(
            details,
            style: h5Style,
            textAlign: TextAlign.center,
          ),
          Spacer(),
          ElevatedButton(onPressed: onTap, child: Text('Subscribe Now!')),
          SizedBox(
            height: Get.height * .05,
          ),
        ],
      ),
    );
  }
}
