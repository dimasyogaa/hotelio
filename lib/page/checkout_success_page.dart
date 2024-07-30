import 'package:course_hotelio/controller/c_home.dart';
import 'package:course_hotelio/page/home_page.dart';
import 'package:course_hotelio/widget/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/hotel.dart';

class CheckoutSuccessPage extends StatelessWidget {
  CheckoutSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cHome = Get.put(CHome());

    //
    Hotel hotel = ModalRoute.of(context)?.settings.arguments as Hotel;

    //
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 6, color: Colors.white),
                borderRadius: BorderRadius.circular(20),
                color: Colors.white),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                hotel.cover,
                width: 190,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 46,
          ),
          Text(
            'Payment Success',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Enjoy your a whole new experience\nin this beautiful world',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.black,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 46,
          ),
          ButtonCustom(label: 'View My Booking', onTap: () {
            cHome.indexPage = 1;

            // menghapus semua layar lalu menuju ke home page
            /// You are trying to use contextless navigation without
            //       a GetMaterialApp or Get.key.
            //       If you are testing your app, you can use:
            //       [Get.testMode = true], or if you are running your app on
            //       a physical device or emulator, you must exchange your [MaterialApp]
            //       for a [GetMaterialApp].
            Get.offAll(() => HomePage());
          })
        ],
      ),
    );
  }
}
