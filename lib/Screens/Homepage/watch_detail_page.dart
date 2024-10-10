
import 'package:clocker/Components/color.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  late final String title;
  late final String price;
  late final String description;
  late final List<String> images;
  late final String sellerUsername;

  DetailPage({
    required this.title,
    required this.price,
    required this.images,
    required this.sellerUsername,
  });
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          splashRadius: 20,
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: primaryColor,
          ),
        ),
        title: Text(
          "İlan Detayı",
          style: TextStyle(color: primaryColor,fontSize: 20,fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_border,
              )
          ),
        ],
      ),
    );
  }
}
