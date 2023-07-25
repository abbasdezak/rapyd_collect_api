import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rapyd_collect_api/core/app_style.dart';

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
        return PlanTabView(
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
      width: Get.width * .9,
      height: Get.height * .7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey,
          )),
      padding: EdgeInsets.symmetric(horizontal: Get.width * .1),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * .3,
          ),
          Text(
            title,
            style: h15Style,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: Get.height * .03,
          ),
          Text(
            subTitle,
            style: h2Style,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: Get.height * .03,
          ),
          Text(
            details,
            style: h5Style,
            textAlign: TextAlign.center,
          ),
          Spacer(),
          ElevatedButton(onPressed: onTap, child: Text('Subscribe Now!')),
          SizedBox(
            height: Get.height * .1,
          ),
        ],
      ),
    );
  }
}
