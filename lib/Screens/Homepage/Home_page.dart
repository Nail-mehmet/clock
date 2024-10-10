import 'package:clocker/Components/color.dart';
import 'package:clocker/Screens/Homepage/promotion_widget.dart';
import 'package:clocker/Screens/Homepage/watch_detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
  Future<String> _getUsername(String userId) async {
    DocumentSnapshot userDoc =
    await FirebaseFirestore.instance.collection('Users').doc(userId).get();

    if (userDoc.exists) {
      return userDoc['username']; // Kullanıcı adı için doğru alan
    } else {
      return "Bilinmeyen kullanıcı"; // Kullanıcı bulunamazsa
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
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
                          color: primaryColor
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "see all",
                          style: TextStyle(fontSize: 15, color: primaryColor),
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
                          color: index == 0 ? primaryColor : Colors.white,
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
                        String userId = data["userId"];
                        String brand = data["brand"];
                        String title = data['description'];
                        String price = data['price'].toString();
                        List<dynamic> images = data["images"];
                        String imageUrl = images.isNotEmpty
                            ? images[0]
                            : 'https://via.placeholder.com/150';

                        return FutureBuilder(
                            future: _getUsername(userId),
                            builder: (context, userSnapshot) {
                              if(userSnapshot.connectionState == ConnectionState.waiting){
                                return CircularProgressIndicator();
                              }
                              if(!userSnapshot.hasData) {
                                return Text("Kullanıcı adı yüklenemedi");
                              }
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                       title: brand,
                                       price: price,
                                       images: List<String>.from(images),
                                        sellerUsername: userSnapshot.data!,
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  color: CupertinoColors.white,
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
                                                color: primaryColor
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Text(
                                                  price,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                SizedBox(width: 4,),
                                                Container(
                                                  width: 1,
                                                  height: 10,
                                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                                  color: Colors.grey,
                                                ),
                                                Icon(
                                                  Icons.favorite,
                                                  color: Colors.redAccent,
                                                  size: 20,
                                                ),
                                                SizedBox(width: 4,),
                                                Text("8500")
                                              ],
                                            ),
                                            Text(
                                                userSnapshot.data!
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 60,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
