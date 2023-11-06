import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:tpro/Services.dart';
import 'package:tpro/menu/buttonBar.dart';
import 'package:tpro/models/account.dart';
import 'package:tpro/models/index.dart';
import 'package:http/http.dart' as http;

class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final _mybox = Hive.box('mybox');
  Account? accs;
  Coms? coms;
  String? title;
  bool isLoading = false;
  num idimg = 0;
  TextEditingController getdescription = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLoading = true;
    title = 'Loading Images...';
    // imgs = Imgs();
    getUser();
    getidimg();
    // print(_mybox.get("account"));
  }

  Future postcom() async {
    final dataa = {
      "id_image": idimg,
      "id_account": accs!.id,
      "description": getdescription.text
    };
    print(dataa);
    String url = "http://192.168.1.20/database_minipro_mobile/list_comment";
    final response = await http.post(Uri.parse(url), body: jsonEncode(dataa));
    print(response.body);
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ButtonBarPage()));
    }
  }

  void getidimg() {
    idimg = _mybox.get("id_image");
    print(idimg);
    Services.getComsByidimg(idimg).then((comsFromServer) {
      setState(() {
        coms = comsFromServer;
        print(coms);
        isLoading = false;
      });
    });
  }

  void getUser() {
    String account = _mybox.get("account");
    accs = parseUser(account);
  }

  static Account parseUser(String responseBody) {
    final Map<String, dynamic> parsed = json.decode(responseBody);
    // print(Account.fromJson(parsed));
    return Account.fromJson(parsed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text('VSPHTO Comments'),
          backgroundColor: Colors.black87,
          title: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ButtonBarPage()));
                  },
                  icon: Icon(Icons.arrow_back)),
              Text(
                "Comment",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          )),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              // itemCount: comments.length,
              itemCount: coms!.coms.isEmpty ? 0 : coms!.coms.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    // Text(coms!.coms[index].name)
                    Row(
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
                                        text: coms!.coms[index].name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                            color: Colors.black),
                                      ),
                                    ]),
                                  )),
                                ],
                              ),
                              if (coms!.coms[index].description.isNotEmpty)
                                Text(
                                  coms!.coms[index].description,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: getdescription,
                    decoration: InputDecoration(hintText: 'Enter Comments...'),
                    onChanged: (value) {
                      // setState(() {
                      //   // newComment = value;
                      // });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    postcom();
                    // if (newComment.isNotEmpty) {
                    //   setState(() {
                    //     // comments.add(newComment);
                    //     // newComment = '';
                    //   });
                    // }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class CommentItem extends StatefulWidget {
//   final String username;
//   final String comment;
//   final String timeAgo;

//   CommentItem({
//     required this.username,
//     required this.comment,
//     required this.timeAgo,
//   });

//   @override
//   _CommentItemState createState() => _CommentItemState();
// }

// class _CommentItemState extends State<CommentItem> {
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: CircleAvatar(
//         backgroundImage: AssetImage(
//             'assets/profile_image.jpg'), // Replace with user's profile image
//       ),
//       title: Row(
//         children: [
//           Text(widget.username),
//           SizedBox(width: 8),
//           SvgPicture.asset('assets/verified.svg'), // Use your own verified icon
//         ],
//       ),
//       subtitle: Text(widget.comment),
//       trailing: Text(widget.timeAgo),
//     );
//   }
// }
