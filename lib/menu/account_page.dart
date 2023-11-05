import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive/hive.dart';
import 'package:tpro/Services.dart';
import 'package:tpro/menu/edit_profile_page.dart';
import 'package:tpro/menu/login_page.dart';
import 'package:tpro/menu/setting_page.dart';
import 'package:tpro/models/account.dart';
import 'package:tpro/models/accounts.dart';
import 'package:tpro/models/imgs.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _mybox = Hive.box('mybox');
  Account? accs;
  Imgs? imgs;
  String? title;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    title = 'Loading Images...';
    imgs = Imgs();
    getUser();
  }

  void getUser() {
    // String account = _mybox.get("account");
    accs = parseUser(_mybox.get("account"));
    Services.getImgsByUser(accs!.id.toInt()).then((imgsFromServer) {
      setState(() {
        imgs = imgsFromServer;
        print(imgs);
        isLoading = false;
      });
    });
  }

  static Account parseUser(String responseBody) {
    final Map<String, dynamic> parsed = json.decode(responseBody);
    return Account.fromJson(parsed);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    if (Theme.of(context).platform == TargetPlatform.iOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 0,
          leading: isLargeScreen
              ? null
              : IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Account",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isLargeScreen) Expanded(child: _navBarItems())
              ],
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('lib/Allimage/logovsphoto.jpg'),
              ),
            ),
          ],
        ),
        drawer: isLargeScreen ? null : _drawer(),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 417,
                height: 230,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.transparent,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.account_circle,
                              size: 120,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${accs!.name}',
                        style: TextStyle(fontSize: 28),
                      ),
                      Column(
                        children: [
                          Container(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditProFilePage()));
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 31, 31, 31))),
                              child: Text('Edit Profile'),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    // mainAxisExtent: 390,
                    childAspectRatio: 0.48
                    // MediaQuery.of(context).size.width/(MediaQuery.of(context).size.height / 4),
                    ),
                itemCount: imgs!.imgs.isEmpty ? 0 : imgs!.imgs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Image.memory(base64Decode(imgs!.imgs[index].image)),
                  );
                },
              ))
              // Expanded(
              //   child: StaggeredGridView.count(
              //     crossAxisCount: 2,
              //     crossAxisSpacing: 10,
              //     mainAxisSpacing: 10,
              //     children: [
              //       GridView.builder(
              //         itemCount: accs!.image.isEmpty ? 0 : accs!.image.length,
              //         itemBuilder: (BuildContext context, int index) {
              //           return Image.memory(base64Decode(accs!.image[index]));
              //         },
              //         gridDelegate:
              //             const SliverGridDelegateWithFixedCrossAxisCount(
              //           crossAxisCount: 2,
              //           crossAxisSpacing: 5,
              //           mainAxisSpacing: 5,
              //         ),
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawer() => Drawer(
        child: ListView(
          children: _menuItems
              .map((item) => ListTile(
                    onTap: () {
                      _navigateToPage(context, item);
                      _scaffoldKey.currentState?.openEndDrawer();
                    },
                    title: Text(item),
                  ))
              .toList(),
        ),
      );

  Widget _navBarItems() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _menuItems
            .map(
              (item) => InkWell(
                onTap: () {
                  _navigateToPage(context, item);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 16),
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            )
            .toList(),
      );

  void _navigateToPage(BuildContext context, String item) {
    if (item == 'Sign Out') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
    if (item == 'Settings') {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SettingsPage()));
    }
  }
}

final List<String> _menuItems = <String>[
  'Settings',
  'Sign Out',
];
