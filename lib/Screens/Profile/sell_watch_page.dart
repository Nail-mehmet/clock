import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SellWatchPage extends StatefulWidget {
  @override
  _SellWatchPageState createState() => _SellWatchPageState();
}

class _SellWatchPageState extends State<SellWatchPage> {
  final _formKey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _mechanismTypeController = TextEditingController();
  final _yearController = TextEditingController();
  final _conditionController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      User? currentUser = FirebaseAuth.instance.currentUser;

      // Firestore'a kaydet
      await FirebaseFirestore.instance.collection('listings').add({
        'userId': currentUser!.uid,
        'brand': _brandController.text,
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
      _brandController.clear();
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
              // Marka
              TextFormField(
                controller: _brandController,
                decoration: InputDecoration(labelText: 'Marka'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen marka girin';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Mekanizma Tipi
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Mekanizma Tipi'),
                items: [
                  'Otomatik',
                  'Pilli',
                  'Kurmalı',
                ].map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
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
              SizedBox(height: 20),
              // Çıkış Yılı
              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(labelText: 'Çıkış Yılı'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen çıkış yılını girin';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Kondisyon
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Kondisyon'),
                items: [
                  'Yeni',
                  'İkinci El',
                  'Kullanılmış',
                ].map((String condition) {
                  return DropdownMenuItem<String>(
                    value: condition,
                    child: Text(condition),
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
              SizedBox(height: 20),
              // Açıklama
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Açıklama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen açıklama girin';
                  }
                  return null;
                },
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
