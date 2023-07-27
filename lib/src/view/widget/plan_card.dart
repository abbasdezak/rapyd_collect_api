import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapyd_collect_api/core/app_style.dart';

class PlanCard extends StatelessWidget {
  const PlanCard({
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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
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
          const Spacer(),
          ElevatedButton(onPressed: onTap, child: const Text('Subscribe Now!')),
          SizedBox(
            height: Get.height * .1,
          ),
        ],
      ),
    );
  }
}
