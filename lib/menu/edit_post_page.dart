import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tpro/menu/buttonBar.dart';

class EditPostPage extends StatefulWidget {
  @override
  _EditPostPageState createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  List<CommentItem> comments = [
    CommentItem(
      username: 'username1',
      comment: 'This is a great post!',
      timeAgo: '2 minutes ago',
    ),
    CommentItem(
      username: 'username2',
      comment: 'Awesome picture!',
      timeAgo: '5 minutes ago',
    ),
    // Add more CommentItems as needed
  ];

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
                "EditPost",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          )),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Image :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Image.network(
              'https://scontent.fkkc3-1.fna.fbcdn.net/v/t39.30808-6/281209364_3114730208815835_6514867847790588562_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=5f2048&_nc_ohc=WzS3t2av1RwAX8Ows2J&_nc_ht=scontent.fkkc3-1.fna&oh=00_AfB7a7yQyxkri7zL3f2WBAu1I6O4Y4IA2cZrEMsBReWx0Q&oe=65447BFE', // URL ของรูปภาพที่คุณต้องการแก้ไข
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Detail :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Enter Detail',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 31, 31, 31),
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(4)),
              ),
              onPressed: () {
                // ส่งข้อมูลการแก้ไขไปยัง Instagram API
                // คุณควรเขียนโค้ดเพื่อเชื่อมต่อกับ Instagram API
                // และส่งข้อมูลการแก้ไขและรูปภาพไปยัง API
                // ในตัวอย่างนี้เราใช้ข้อมูลจำลองแทน
                final simulatedResponse = {
                  'status': 'success',
                  'message': 'แก้ไขโพสต์สำเร็จ'
                };

                if (simulatedResponse['status'] == 'success') {
                  // แก้ไขโพสต์สำเร็จ
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'แก้ไขโพสต์สำเร็จ: ${simulatedResponse['message']}'),
                  ));
                } else {
                  // แก้ไขโพสต์ล้มเหลว
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'ล้มเหลวในการแก้ไขโพสต์: ${simulatedResponse['message']}'),
                  ));
                }
              },
              child: Text('Summit'),
            ),
          ],
        ),
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
