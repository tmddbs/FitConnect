import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostListPage(),
    );
  }
}

class Post {
  String title;
  String content;

  Post(this.title, this.content);

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
      };

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      json['title'],
      json['content'],
    );
  }
}

class PostListPage extends StatefulWidget {
  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? postsString = prefs.getString('posts');
    if (postsString != null) {
      List<dynamic> postList = jsonDecode(postsString);
      setState(() {
        posts = postList.map((post) => Post.fromJson(post)).toList();
      });
    }
  }

  Future<void> _savePosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> postList =
        posts.map((post) => jsonEncode(post.toJson())).toList();
    await prefs.setString('posts', jsonEncode(postList));
  }

  Future<void> _clearPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('posts');
    setState(() {
      posts.clear();
    });
  }

  void _addPost(Post post) {
    setState(() {
      posts.add(post);
    });
    _savePosts();
  }

  void _navigateToPostForm() async {
    final newPost = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostFormPage()),
    );
    if (newPost != null) {
      _addPost(newPost);
    }
  }

  void _navigateToPostDetail(Post post) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostDetailPage(post: post)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community App'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _clearPosts,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(posts[index].title),
            subtitle: Text(posts[index].content),
            onTap: () => _navigateToPostDetail(posts[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToPostForm,
        child: Icon(Icons.add),
      ),
    );
  }
}

class PostFormPage extends StatefulWidget {
  @override
  _PostFormPageState createState() => _PostFormPageState();
}

class _PostFormPageState extends State<PostFormPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _submitPost() {
    final String title = _titleController.text;
    final String content = _contentController.text;

    if (title.isNotEmpty && content.isNotEmpty) {
      final newPost = Post(title, content);
      Navigator.pop(context, newPost);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('글쓰기'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: '제목'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: '내용'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitPost,
              child: Text('등록'),
            ),
          ],
        ),
      ),
    );
  }
}

class PostDetailPage extends StatelessWidget {
  final Post post;

  PostDetailPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(post.content),
          ],
        ),
      ),
    );
  }
}
