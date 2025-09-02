import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gebiya_web_admin/views/screens/side_bar_screens/widgets/category_widget.dart';

class CategoriesScreen extends StatefulWidget {
  static const String routeName = '/CategoriesScreen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  dynamic _image;
  late String categoryName;
  String? fileName;

  _pickImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);
    fileName = result?.files.first.name;
    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
      });
    }
  }

  _uploadCategoryBannerToStorage(dynamic image) async {
    Reference ref = _storage.ref().child('CategoryImages').child(fileName!);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadCategory() async {
    EasyLoading.show();
    if (_formKey.currentState!.validate()) {
      String imageUrl = await _uploadCategoryBannerToStorage(_image);
      await _firestore.collection('Categories').doc(fileName).set({
        'categoryName': categoryName,
        'image': imageUrl,
      }).whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _image = null;
          _formKey.currentState!.reset();
        });
      });
      ;
    } else {
      print("Bad guy ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                ' Category ',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
            ),
            Divider(color: Colors.grey),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          border: Border.all(color: Colors.grey.shade800),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _image != null
                            ? Image.memory(
                                _image,
                                fit: BoxFit.cover,
                              )
                            : Center(
                                child: Text("Categories"),
                              ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow.shade900,
                        ),
                        onPressed: () {
                          _pickImage();
                        },
                        child: const Text("Upload Image"),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: SizedBox(
                      width: 200,
                      child: TextFormField(
                          onChanged: (value) {
                            categoryName = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Category name must not be Empty';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Enter Category Name",
                            hintText: "Enter Category Name",
                          ))),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow.shade900,
                  ),
                  onPressed: () {
                    uploadCategory();
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
            Divider(color: Colors.grey),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Categories',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const CategoryWidget(),
          ],
        ),
      ),
    );
  }
}
