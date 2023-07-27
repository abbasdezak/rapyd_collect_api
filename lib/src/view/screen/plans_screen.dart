import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rapyd_collect_api/core/app_style.dart';
import 'package:rapyd_collect_api/src/view/widget/plan_card.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({Key? key}) : super(key: key);

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: Get.width * .98);
  final List<Map> plans = [
    {
      'title': 'Basic',
      'price': 5.99,
      'details': 'Limited support',
    },
    {
      'title': 'Pro',
      'price': 9.99,
      'details': '24/7 support - only chat',
    },
    {
      'title': 'Advanced',
      'price': 19.99,
      'details': '24/7 support - calls and chat',
    },
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _planLists(),
    );
  }

  ListView _planLists() {
    return ListView.builder(
      controller: _scrollController,
      itemBuilder: (context, index) {
        return PlanCard(
            title: plans[index]['title'],
            subTitle: plans[index]['price'].toString(),
            details: plans[index]['details'],
            onTap: () {});
      },
      itemCount: 3,
      scrollDirection: Axis.horizontal,
    );
  }
}
