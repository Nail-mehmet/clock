

import 'package:clocker/Components/color.dart';
import 'package:flutter/material.dart';

class PromotionWidget extends StatelessWidget {
  const PromotionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      margin: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("35%",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: secondaryColor),),
                  Text("Todays Special",style: TextStyle(fontSize: 20,color: secondaryColor)),
                  Text("Saat al, sat, takas et",style: TextStyle(fontSize: 15,color: secondaryColor)),
                ],
              ),
            ),
          ),
          Expanded(
            child: Image(
              image: AssetImage("assets/promotionRolex.png"),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),

    );
  }
}
