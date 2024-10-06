
import 'package:clocker/Screens/Homepage/promotion_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final brands = [
    "All",
    "Rolex",
    "Ap",
    "Tissot",
    "Patek",
    "Seiko",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: MediaQuery.of(context).padding,
        child: Column(
          children: [
            PromotionWidget(),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(24, 0, 24, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Most Popular Brands", style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),),
                      TextButton(
                          onPressed: () {},
                          child: Text("see all",style: TextStyle(fontSize: 15,color: Colors.blue),)
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 38,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 24),
                    itemCount: brands.length,
                    itemBuilder: (context,index) {
                      return Container(
                        margin: EdgeInsets.only(right: 24),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: index == 0 ? Colors.black : Colors.white,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          brands[index],
                          style: TextStyle(
                            color: index == 0 ? Colors.white : Colors.black
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}