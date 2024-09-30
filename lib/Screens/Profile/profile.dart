import 'package:clocker/Components/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? getCurrentUser () {
    return _auth.currentUser;
  }
  Future<String?> getUserName() async {
    User? currentUser = getCurrentUser(); // Mevcut kullanıcıyı al
    if (currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser.uid)
          .get();

      // Kullanıcının adını 'name' alanından alıyoruz
      return userDoc['username'] ?? 'No name available';
    }
    return null; // Kullanıcı oturumu yoksa
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profil Fotoğrafı, Kullanıcı Adı, E-posta
              Center(
                child: Column(
                  children: [

                    CircleAvatar(
                      radius: 50, // Profil fotoğrafının büyüklüğü
                      backgroundImage: AssetImage('assets/Walter.jpg'), // Profil resmi
                    ),
                    SizedBox(height: 10),
                    FutureBuilder<String?>(
                      future: getUserName(), // Kullanıcı adını çeken fonksiyon
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator(); // Yükleniyor göstergesi
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}'); // Hata mesajı
                        }
                        if (snapshot.hasData) {
                          return Text('${snapshot.data}'); // Adı ekrana yazdırma
                        }
                        return Text('No user data available'); // Veriler boşsa
                      },
                    ),
                    Text(
                      _auth.currentUser!.email!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(

                      onPressed: () {
                        // Butona tıklanınca yapılacak işlem
                        print('Saatini Sat Butonuna Tıklandı');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: accent
                      ),
                      child: Text(
                        'Saatini Sat',
                        style: TextStyle(fontSize: 18,color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              // Yuvarlatılmış köşeli tıklanabilir bölümler
              Column(
                children: [
                  ProfileSection(title: 'Hesap Bilgileri', onTap: () {}),
                  ProfileSection(title: 'Banka Bilgileri', onTap: () {}),
                  ProfileSection(title: 'Bildirimler', onTap: () {}),
                  ProfileSection(title: 'Gizlilik ve Güvenlik', onTap: () {}),
                  ProfileSection(title: 'Yardım ve Destek', onTap: () {}),
                ],
              ),
              // Alt kısımda "Saatini Sat" butonu
              SizedBox(height: 80),
              // Altta biraz boşluk bırakıyoruz
            ],
          ),
        ),
      ),
    );
  }
}

// Yuvarlatılmış köşeli, tıklanabilir profil bölümlerini temsil eden widget
class ProfileSection extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ProfileSection({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3), // gölgeyi ayarladık
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
