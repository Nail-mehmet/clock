import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class SellWatchPage extends StatefulWidget {
  @override
  _SellWatchPageState createState() => _SellWatchPageState();
}

class _SellWatchPageState extends State<SellWatchPage> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFiles = [];
  List<String> _uploadedFileURLs = [];
  bool _isLoading = false;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final _formKey = GlobalKey<FormState>();
  final _mechanismTypeController = TextEditingController();
  final _yearController = TextEditingController();
  final _priceController = TextEditingController();
  final _conditionController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedBrand;
  String? _selectedType;
  String? _condition;
  int _remainingChars = 150;

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
  List<String> systemType = [
    'pilli',
    'Mekanik',
    'Solar',
    'Kurmalı',
  ];
  List<String> condition = [
    'sıfır',
    'kulanılmış',
    'ikinci el',
    'yenilnmiş',
  ];

  Future<void> _pickImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage(imageQuality: 80);
    if (selectedImages != null && selectedImages.length <= 5) {
      setState(() {
        _imageFiles!.addAll(selectedImages);
      });
    } else if (selectedImages != null && selectedImages.length > 5) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('En fazla 5 fotoğraf seçebilirsiniz!'),
      ));
    }
  }

  Future<void> _uploadImages() async {
    for (var imageFile in _imageFiles!) {
      String fileName = path.basename(imageFile.path);
      Reference storageRef = _storage.ref().child('images/$fileName');
      UploadTask uploadTask = storageRef.putFile(File(imageFile.path));

      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      _uploadedFileURLs.add(downloadURL);
    }
  }

  Future<void> _saveToFirestore() async {
    if (_formKey.currentState!.validate()) {
      User? currentUser = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance.collection('listings').add({
        'userId': currentUser!.uid,
        'brand': _selectedBrand,
        'mechanismType': _selectedType,
        'year': _yearController.text,
        'condition': _condition,
        'description': _descriptionController.text,
        'timestamp': FieldValue.serverTimestamp(),
        "images": _uploadedFileURLs,
        "price": _priceController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saat bilgileri başarıyla kaydedildi!')),
      );

      setState(() {
        _selectedBrand = null;
        _selectedType = null;
        _condition = null;
      });
      //_mechanismTypeController.clear();
      _yearController.clear();
      _priceController.clear();
      //_conditionController.clear();
      _descriptionController.clear();
    }
  }

  Future<void> _saveAllData() async {
    setState(() {
      _isLoading = true;
    });

    await _uploadImages();
    await _saveToFirestore();

    setState(() {
      _isLoading = false;
    });
  }

  void _removeImage(int index) {
    setState(() {
      _imageFiles!.removeAt(index);
    });
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
                    GestureDetector(
                      onTap: _pickImages,
                      child: DottedBorderButton(),
                    ),
                    SizedBox(height: 20),

                    // Seçilen Fotoğrafların Önizlemesi
                    if (_imageFiles!.isNotEmpty)
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _imageFiles!.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      File(_imageFiles![index].path),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _removeImage(index),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    else
                      Text('Henüz fotoğraf seçilmedi', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 20),
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
                          hint: Text('Saatin Markası'),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedType,
                    isExpanded: true,
                    hint: Text('Mekanizma'),
                    items: systemType.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(type),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedType = newValue;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 5,),
              // Çıkış Yıl
              // Kondisyon
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _condition,
                    isExpanded: true,
                    hint: Text('Kondisyon'),
                    items: condition.map((String condition) {
                      return DropdownMenuItem<String>(
                        value: condition,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(condition),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _condition = newValue;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: 'Satış Fiyatı',
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


              // Açıklama
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  autocorrect: false,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Açıklama',
                    hintText: 'Açıklama girin', // Hint text sol üstte görünmeye devam edecek
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    alignLabelWithHint: true, // HintText'in yukarıda sabitlenmesini sağlar
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null, // Alt satıra geçme özelliği korunur
                  minLines: 3, // İlk görünümde minimum 3 satır gösterilir
                  maxLength: 150, // 150 karakter sınırı
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen açıklama girin';
                    }
                    return null;
                  },
                ),

              ),

              // Kaydet Butonu
              SizedBox(height: 20),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: _saveAllData,
                child: Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Kesik Çizgili Buton
class DottedBorderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueAccent, style: BorderStyle.solid, width: 1),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.photo_library, size: 50, color: Colors.blue),
            SizedBox(height: 10),
            Text(
              'Fotoğrafları Yükle',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}


