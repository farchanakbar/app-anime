import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Sawer extends StatelessWidget {
  const Sawer({super.key, required this.gotoLink});

  final void Function() gotoLink;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
            image: AssetImage(
              'assets/images/kimetsu.jpg',
            ),
            fit: BoxFit.cover),
      ),
      width: Get.width,
      child: Card(
        child: InkWell(
          onTap: gotoLink,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: Image.asset(
                    'assets/images/trakter.png',
                    fit: BoxFit.fill,
                  ),
                ),
                const Column(
                  children: [
                    Text(
                      '~ Support Mimin ~',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text('Nonton Anime Subtitle Indonesia'),
                    Text('Ngewibuu 2024')
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
