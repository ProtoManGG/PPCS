import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class InfoDialog extends StatelessWidget {
  final String title;
  final String imagePath;
  final int hotspotInfo;
  const InfoDialog({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.hotspotInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: SizedBox.fromSize(
        size: Size(Get.width * 0.2, Get.height * 0.2),
        child: SvgPicture.asset("assets/icons/$imagePath"),
      ),
      subtitle: Text(hotspotInfo.toString()),
    );
  }
}
