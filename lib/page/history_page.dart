import 'package:course_hotelio/config/app_color.dart';
import 'package:course_hotelio/config/app_format.dart';
import 'package:course_hotelio/config/app_route.dart';
import 'package:course_hotelio/controller/c_history.dart';
import 'package:course_hotelio/controller/c_user.dart';
import 'package:course_hotelio/model/booking.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../config/app_asset.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final cHistory = Get.put(CHistory());
  final cUser = Get.put(CUser());

  @override
  void initState() {
    cHistory.getListBooking(cUser.Data.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 24,),
        header(context),
        const SizedBox(height: 24,),
        GetBuilder<CHistory>(builder: (_) {
          return GroupedListView<Booking, String>(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),

            //
            elements: _.listBooking,

            //
            groupBy: (element) => element.date,
            groupSeparatorBuilder: (String groupByValue) {
              String date = DateFormat('yyyy-MM-dd').format(DateTime.now()) ==
                  groupByValue ? 'Today New'
                  : AppFormat.dateMonth(groupByValue);

              //
              return Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 16.0),
                child: Text(
                  date,
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(
                      fontWeight: FontWeight.bold
                  ),
                ),
              );

              //
            },

            //
            itemBuilder: (context, element) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, AppRoute.detailBooking, arguments: element);
                    },
                    child: item(context, element)),
              );
            },

            //
            // sorting
            itemComparator: (item1, item2) =>
               item1.date.compareTo(item2.date),

            // optional
            useStickyGroupSeparators: false,

            // optional
            floatingHeader: false,

            // optional
            order: GroupedListOrder.DESC,

            // optional
            // footer: Text("Widget at the bottom of list"), // optional

            //
          );

        })
      ],
    );
  }

  Padding header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              AppAsset.profile,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),

          //
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'My Booking',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w900),
              ),
              Obx(() {
                  return Text(
                    '${cHistory.listBooking.length ?? 0} transaction',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  );
                }
              ),
            ],

            //
          ),

          //
        ],
      ),
    );
  }

  Widget item(BuildContext context, Booking booking) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16)
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              booking.cover,
              fit: BoxFit.cover,
              height: 70,
              width: 90,
            ),
          ),
          const SizedBox(width: 16,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    booking.name,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold
                    ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,


                ),
                Text(
                   AppFormat.date(booking.date) ,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w300
                    )
                )
              ],
            ),
          ),
          const SizedBox(width: 16,),
          Container(
            decoration: BoxDecoration(
              color: booking.status == 'PAID' ? AppColor.secondary :Colors.red,
              borderRadius: BorderRadius.circular(30)
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 2
            ),
            child: Text(
              booking.status,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
