import 'package:clocker/Screens/Homepage/promotion_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                      Text(
                        "Most Popular Brands",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "see all",
                          style: TextStyle(fontSize: 15, color: Colors.blue),
                        ),
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
                    itemBuilder: (context, index) {
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
                              color: index == 0 ? Colors.white : Colors.black),
                        ),
                      );
                    },
                  ),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("listings")
                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('Henüz ilan yok.'));
                    }

                    return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75, // Görsel ve yazının orantısını ayarlar
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      padding: EdgeInsets.all(16.0),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index];
                        String title = data['description'];
                        String price = data['year'].toString();
                        List<dynamic> images = data["images"];
                        String imageUrl = images.isNotEmpty
                            ? images[0]
                            : 'https://via.placeholder.com/150';

                        return InkWell(
                          onTap: () {},
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Görsel gösterimi
                                Container(
                                  height: 150, // Görsel yüksekliği
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(imageUrl),
                                      fit: BoxFit.cover, // Görselin kutuya sığdırılması
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "$price TL",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
