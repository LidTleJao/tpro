import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:tpro/menu/buttonBar.dart';

class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final _mybox = Hive.box('mybox');

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
              itemBuilder: (context, index) {
                // return CommentItem(comment: comments[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: 'เขียนคอมเมนต์...'),
                    onChanged: (value) {
                      setState(() {
                        // newComment = value;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
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

class CommentItem extends StatefulWidget {
  final String username;
  final String comment;
  final String timeAgo;

  CommentItem({
    required this.username,
    required this.comment,
    required this.timeAgo,
  });

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(
            'assets/profile_image.jpg'), // Replace with user's profile image
      ),
      title: Row(
        children: [
          Text(widget.username),
          SizedBox(width: 8),
          SvgPicture.asset('assets/verified.svg'), // Use your own verified icon
        ],
      ),
      subtitle: Text(widget.comment),
      trailing: Text(widget.timeAgo),
    );
  }
}
