import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SellWatchPage extends StatefulWidget {
  @override
  _SellWatchPageState createState() => _SellWatchPageState();
}

class _SellWatchPageState extends State<SellWatchPage> {
  final _formKey = GlobalKey<FormState>();
  final _mechanismTypeController = TextEditingController();
  final _yearController = TextEditingController();
  final _conditionController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedBrand;
  List<String> watchBrands = [
    'Rolex',
    'Patek Philippe',
    'Audemars Piguet',
    'Richard Mille',
    'Tissot',
    'Seiko',
    'Casio',
    'Citizen',
    'Orient',
    'Longines',
    'Tag Heuer',
    'Breitling',
    'Panerai',
    'Hublot',
    'IWC Schaffhausen',
    'Bell & Ross',
    'Movado',
    'Fossil',
    'Chopard',
    'Vacheron Constantin',
  ];

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      User? currentUser = FirebaseAuth.instance.currentUser;

      // Firestore'a kaydet
      await FirebaseFirestore.instance.collection('listings').add({
        'userId': currentUser!.uid,
        'brand': _selectedBrand,
        'mechanismType': _mechanismTypeController.text,
        'year': _yearController.text,
        'condition': _conditionController.text,
        'description': _descriptionController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saat bilgileri başarıyla kaydedildi!')),
      );

      // Formu temizle
      setState(() {
        _selectedBrand = null;
      });
      _mechanismTypeController.clear();
      _yearController.clear();
      _conditionController.clear();
      _descriptionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saatini Sat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Saat Markası
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saat Markası',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedBrand,
                          isExpanded: true,
                          hint: Text('Seçin'),
                          items: watchBrands.map((String brand) {
                            return DropdownMenuItem<String>(
                              value: brand,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(brand),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedBrand = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Mekanizma Tipi
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Mekanizma Tipi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  items: ['Otomatik', 'Pilli', 'Kurmalı'].map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0), // Padding eklendi
                        child: Text(type),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _mechanismTypeController.text = value ?? '';
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Lütfen mekanizma tipini seçin';
                    }
                    return null;
                  },
                ),
              ),

              // Çıkış Yılı
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _yearController,
                  decoration: InputDecoration(
                    labelText: 'Çıkış Yılı',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen çıkış yılını girin';
                    }
                    return null;
                  },
                ),
              ),

              // Kondisyon
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Kondisyon',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  items: ['Yeni', 'İkinci El', 'Kullanılmış'].map((String condition) {
                    return DropdownMenuItem<String>(
                      value: condition,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(condition),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _conditionController.text = value ?? '';
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Lütfen kondisyona göre bir seçim yapın';
                    }
                    return null;
                  },
                ),
              ),

              // Açıklama (Çok satırlı)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Açıklama',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  maxLines: 3, // Açıklama alanı için 3 satır
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen açıklama girin';
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: _submit,
                child: Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
