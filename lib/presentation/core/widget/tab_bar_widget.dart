import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  final List<String> titles;
  final TabController tabController;

  const TabBarWidget(
      {Key? key,
      required this.titles,
      required this.tabController,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      height:60,
       decoration: const BoxDecoration(
         border:   Border(bottom: BorderSide(color: Color(0xFFBBBBBB))),
       ),
      child:  TabBar(
        padding: EdgeInsets.zero,
          labelStyle: Theme.of(context).textTheme.headline2!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),

          unselectedLabelStyle: Theme.of(context).textTheme.headline3,
          controller: tabController,
          indicatorColor: Colors.black,

         //  indicator: BoxDecoration(
         //  //  shape: BoxShape.rectangle,
         //    border:   Border(bottom: BorderSide(color: Colors.red)),
         //
         //  //  borderRadius: BorderRadius.circular(8.0,),
         // //
         //    color: Colors.black,
         //  ),
          indicatorPadding: const EdgeInsets.all(0),

          labelColor: Colors.black,
          unselectedLabelColor: const Color(0xFFBBBBBB),
          tabs: [
            for (var item in titles) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Tab(
                  child: Text(item),
                ),
              ),
            ]
          ],
        ),
      );
  }
}
