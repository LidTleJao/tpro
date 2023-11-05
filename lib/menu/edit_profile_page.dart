import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tpro/menu/account_page.dart';
import 'package:tpro/menu/buttonBar.dart';
import 'package:tpro/menu/login_page.dart';
import 'package:tpro/models/account.dart';

class EditProFilePage extends StatefulWidget {
  const EditProFilePage({Key? key}) : super(key: key);

  @override
  State<EditProFilePage> createState() => _EditProFilePageState();
}

class _EditProFilePageState extends State<EditProFilePage> {
  final _mybox = Hive.box('mybox');
  Account? accs;
  bool isLoading = false;
  String? title;
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  @override
  void initState() {
    super.initState();
    isLoading = true;
    title = 'Loading Images...';
    getUser();
  }

  void getUser() {
    // String account = _mybox.get("account");
    accs = parseUser(_mybox.get("account"));
    isLoading = false;
  }

  void editAccount() async {
    final dataa = {'name': name.text};
    String url =
        "http://192.168.1.20/database_minipro_mobile/account/${accs!.id}";
    final response = await http.put(Uri.parse(url), body: jsonEncode(dataa));
    // var data = json.decode(response.body);
    isLoading = false;

    // print(data);
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ButtonBarPage()));
    }
  }

  static Account parseUser(String responseBody) {
    final Map<String, dynamic> parsed = json.decode(responseBody);

    return Account.fromJson(parsed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ButtonBarPage()));
                },
                icon: Icon(Icons.arrow_back)),
            Text(
              "Edit Account",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        // title: Text('สมัคร VSPHOTO'),
      ),
      body: Form(
        child: Center(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Card(
                  elevation: 8,
                  child: Container(
                    padding: const EdgeInsets.all(32.0),
                    constraints: const BoxConstraints(maxWidth: 350),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('lib/Allimage/logovsphoto.jpg',
                              width: 150),
                          _gap(),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              "${accs!.name}",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                          _gap(),
                          TextFormField(
                            controller: name,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              hintText: 'Enter your Name',
                              prefixIcon: Icon(Icons.account_circle_outlined),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 31, 31, 31),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Summit',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              onPressed: () {
                                editAccount();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
