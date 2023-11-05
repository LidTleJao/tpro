import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tpro/Services.dart';
import 'package:tpro/menu/buttonBar.dart';
import 'package:tpro/menu/home_page.dart';
import 'package:tpro/models/index.dart';
import 'package:http/http.dart' as http;

class AddImagePage extends StatefulWidget {
  @override
  _AddImagePageState createState() => _AddImagePageState();
}

class _AddImagePageState extends State<AddImagePage> {
  final _mybox = Hive.box('mybox');
  Account? accs;
  XFile? _image;
  Type_imgs? type_imgs;
  String? bs64;
  TextEditingController captionController = TextEditingController();
  TextEditingController getimg = TextEditingController();
  TextEditingController getdetail = TextEditingController();
  TextEditingController gettypeimg = TextEditingController();

  String selectedCategory = 'none'; // ประเภทรูปภาพที่เลือก
  // รายการประเภทรูปภาพ
  List<String> data = [];

  void postimg() async {
    int tid = 0;
    for (var i = 0; i < type_imgs!.type_imgs.length; i++) {
      if (selectedCategory.contains(type_imgs!.type_imgs[i].name_type)) {
        tid = i + 1;
        print(tid);
      }
    }
    final dataa = {
      'id_account': accs!.id,
      'url': bs64,
      'detail': getdetail.text,
      'type_image': tid
    };

    print(bs64);
    String url = "http://192.168.1.20/database_minipro_mobile/list_image";
    final response = await http.post(Uri.parse(url), body: jsonEncode(dataa));
    print(response.body);
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ButtonBarPage()));
    }
  }

  static Account parseUser(String responseBody) {
    final Map<String, dynamic> parsed = json.decode(responseBody);
    return Account.fromJson(parsed);
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 500, maxWidth: 500);

    setState(() {
      _image = pickedImage;
    });
    List<int> _img64 = File(_image!.path).readAsBytesSync();
    bs64 = base64Encode(_img64);
  }

  @override
  void initState() {
    super.initState();
    // isLoading = true;
    // title = 'Loading Images...';
    accs = parseUser(_mybox.get("account"));
    type_imgs = Type_imgs();

    Services.getTypeimgs().then((typeimgsFromServer) {
      setState(() {
        type_imgs = typeimgsFromServer;
        for (var i = 0; i < type_imgs!.type_imgs.length; i++) {
          data += ['${type_imgs!.type_imgs[i].name_type}'];
        }
        print(data);
        // isLoading = false;
      });
    });
  }

  void postToVSCO() {
    // ใส่โค้ดเมื่อคุณต้องการโพสต์รูปภาพไปยัง VSCO
    // ขั้นตอนนี้อาจจะต้องใช้ API ของ VSCO หรือวิธีอื่น ๆ ที่ VSCO มีให้
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 31, 31, 31),
        title: Text('Post Image'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image != null
                ? Image.file(File(_image!.path))
                : Container(
                    height: 300,
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      size: 100,
                    ),
                  ),
            ElevatedButton(
              onPressed: _pickImage,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 31, 31, 31))),
              child: Text('Browse'),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: TextFormField(
                controller: getdetail,
                decoration: InputDecoration(
                  hintText: 'Detail',
                ),
              ),
            ),
            DropdownButton<String>(
              value: selectedCategory,
              items: data.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
            ),
            ElevatedButton(
              onPressed: postimg,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 31, 31, 31))),
              child: Text('Post To VSPHOTO'),
            ),
          ],
        ),
      ),
    );
  }
}
