import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tpro/Services.dart';
import 'package:tpro/menu/comment_page.dart';
import 'package:tpro/menu/edit_post_page.dart';
import 'package:tpro/menu/login_page.dart';
import 'package:tpro/menu/setting_page.dart';
import 'package:tpro/models/accounts.dart';
import 'package:tpro/models/imgs.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Imgs? imgs;
  Accounts? accs;
  String? title;
  bool isLoading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    isLoading = true;
    title = 'Loading Images...';
    imgs = Imgs();
    accs = Accounts();

    Services.getAccounts().then((accsFromServer) {
      setState(() {
        accs = accsFromServer;
        print(accs);
        isLoading = false;
      });
    });

    Services.getImgs().then((imgsFromServer) {
      setState(() {
        imgs = imgsFromServer;
        // print(imgs);
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;
    // bool _isActive = false;

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
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "VSPHOTO",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                if (isLargeScreen) Expanded(child: _navBarItems())
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        drawer: isLargeScreen ? null : _drawer(),
        body: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  itemCount: imgs!.imgs.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final item = imgs!.imgs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.account_circle,
                            size: 50,
                          ),
                          const SizedBox(width: 26),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: item.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                              color: Colors.white),
                                        ),
                                      ]),
                                    )),
                                    // Text('· 5m',
                                    //     style:
                                    //         Theme.of(context).textTheme.subtitle1),
                                    Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: PopupMenuButton<Menu>(
                                            icon: const Icon(Icons.settings),
                                            offset: const Offset(0, 40),
                                            onSelected: (Menu item) {
                                              if (item == Menu.itemOne) {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditPostPage()));
                                              }
                                              if (item == Menu.itemTwo) {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditPostPage()));
                                              }
                                            },
                                            itemBuilder:
                                                (BuildContext context) =>
                                                    <PopupMenuEntry<Menu>>[
                                                      const PopupMenuItem<Menu>(
                                                        value: Menu.itemOne,
                                                        child: Text('Edit'),
                                                      ),
                                                      const PopupMenuItem<Menu>(
                                                        value: Menu.itemTwo,
                                                        child: Text('Delete'),
                                                      ),
                                                    ]))
                                  ],
                                ),
                                if (item.detail.isNotEmpty) Text(item.detail),
                                if (item.url.isNotEmpty)
                                  Container(
                                    height: 200,
                                    margin: const EdgeInsets.only(top: 8.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: MemoryImage(
                                              base64Decode(item.url)),
                                        )),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CommentPage()));
                                        },
                                        icon: Stack(
                                          children: [
                                            Icon(Icons.comment),
                                            Positioned(
                                              top:
                                                  6, // ปรับตำแหน่งของจำนวนความคิดเห็น
                                              right:
                                                  0, // ปรับตำแหน่งของจำนวนความคิดเห็น
                                              child: Container(
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors
                                                      .red, // สีพื้นหลังข้อความจำนวนความคิดเห็น
                                                ),
                                                child: Text(
                                                  "${item.count_comment}", // จำนวนความคิดเห็น (ค่าคงที่หรือตัวแปรที่คุณต้องการแสดง)
                                                  style: TextStyle(
                                                    color: Colors
                                                        .white, // สีข้อความจำนวนความคิดเห็น
                                                    fontSize:
                                                        12, // ขนาดตัวอักษรของจำนวนความคิดเห็น
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Stack(
                                          children: [
                                            Icon(Icons.favorite_border),
                                            Positioned(
                                              top:
                                                  6, // ปรับตำแหน่งของจำนวนความคิดเห็น
                                              right:
                                                  0, // ปรับตำแหน่งของจำนวนความคิดเห็น
                                              child: Container(
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors
                                                      .red, // สีพื้นหลังข้อความจำนวนความคิดเห็น
                                                ),
                                                child: Text(
                                                  "${item.count_like}", // จำนวนความคิดเห็น (ค่าคงที่หรือตัวแปรที่คุณต้องการแสดง)
                                                  style: TextStyle(
                                                    color: Colors
                                                        .white, // สีข้อความจำนวนความคิดเห็น
                                                    fontSize:
                                                        12, // ขนาดตัวอักษรของจำนวนความคิดเห็น
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
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
            .map((item) => InkWell(
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
                ))
            .toList(),
      );

  void _navigateToPage(BuildContext context, String item) {
    if (item == 'Sign Out') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
    if (item == 'Settings') {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SettingsPage()));
    }
  }
}

enum Menu { itemOne, itemTwo }

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = ["Cat", "Dog", "Sea", "Water"];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}

final List<String> _menuItems = <String>[
  'Settings',
  'Sign Out',
];

class _Homepage extends StatelessWidget {
  final String url;

  const _Homepage(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: NetworkImage(url))),
    );
  }
}
