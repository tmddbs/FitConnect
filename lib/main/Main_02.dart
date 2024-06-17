import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:ksy_0522/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'Main_02_pop_range.dart';
import '../Profile.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Main_02(),
    );
  }
}

class Post {
  String title;
  String content;
  List<String> tags;

  Post(this.title, this.content, this.tags);

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'tags': tags,
      };

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      json['title'],
      json['content'],
      List<String>.from(json['tags']),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // 좌우로 꽉 차게 확장
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                post.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 100,
              height: 400,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                post.content,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: post.tags.map((tag) {
                  return Chip(
                    label: Text(tag),
                    backgroundColor: Theme.of(context).primaryColorLight,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Main_02 extends StatefulWidget {
  const Main_02({super.key});

  @override
  State<Main_02> createState() => _Main_02State();
}

class _Main_02State extends State<Main_02> {
  List<Post> posts = [];
  List<Post> filteredPosts = [];
  TextEditingController searchController = TextEditingController();
  List<String> selectedTags = [];
  List<String> availableTags = ['Tag1', 'Tag2', 'Tag3']; // Example tags

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _clearPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('posts');
    setState(() {
      posts.clear();
      filteredPosts.clear();
    });
  }

  Future<void> _loadPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? postsString = prefs.getString('posts');
    if (postsString != null) {
      List<dynamic> postList = jsonDecode(postsString);
      setState(() {
        posts =
            postList.map((post) => Post.fromJson(jsonDecode(post))).toList();
        filteredPosts = posts;
      });
    }
  }

  Future<void> _savePosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> postList =
        posts.map((post) => jsonEncode(post.toJson())).toList();
    await prefs.setString('posts', jsonEncode(postList));
  }

  void _addPost(Post post) {
    setState(() {
      posts.add(post);
      filteredPosts = posts;
    });
    _savePosts();
  }

  void _removePost(int index) {
    setState(() {
      posts.removeAt(index);
      filteredPosts = posts;
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

  void _filterPosts(String query) {
    List<Post> results = [];
    if (query.isEmpty && selectedTags.isEmpty) {
      results = posts;
    } else {
      results = posts.where((post) {
        final matchesQuery =
            post.title.toLowerCase().contains(query.toLowerCase()) ||
                post.content.toLowerCase().contains(query.toLowerCase());
        final matchesTags = selectedTags.isEmpty ||
            selectedTags.every((tag) => post.tags.contains(tag));
        return matchesQuery && matchesTags;
      }).toList();
    }

    setState(() {
      filteredPosts = results;
    });
  }

  void _showTagSelection() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('태그 선택',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: availableTags.map((tag) {
                      return FilterChip(
                        label: Text(tag),
                        selected: selectedTags.contains(tag),
                        onSelected: (isSelected) {
                          setState(() {
                            if (isSelected) {
                              selectedTags.add(tag);
                            } else {
                              selectedTags.remove(tag);
                            }
                          });
                        },
                        selectedColor: Colors.blueAccent,
                        checkmarkColor: Colors.white,
                        backgroundColor: Colors.grey[200],
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _filterPosts(searchController.text);
                      },
                      child: Text('완료'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      )),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    range(context);
                  },
                  child: Text(
                    globalMyData.address, //address 필요
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showPopup(context, globalMyData);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 65.0,
                      height: 65.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/marker/' +
                              globalMyData.profileImage), // 경로는 실제 이미지 경로로 변경
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: _showTagSelection,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  ),
                  child: Text('카테고리', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: '검색어를 입력하세요',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search, color: Colors.grey[600]),
                        onPressed: () {
                          _filterPosts(searchController.text);
                        },
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    onChanged: (value) {
                      _filterPosts(value);
                    },
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPosts.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      filteredPosts[index].title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          filteredPosts[index].content,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        Wrap(
                          children: filteredPosts[index].tags.map((tag) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Chip(
                                label: Text(tag),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removePost(index),
                    ),
                    onTap: () => _navigateToPostDetail(filteredPosts[index]),
                  ),
                );
              },
            ),
          ),
        ],
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
  List<String> selectedTags = [];

  void _submitPost() {
    final String title = _titleController.text;
    final String content = _contentController.text;

    if (title.isNotEmpty && content.isNotEmpty) {
      final newPost = Post(title, content, selectedTags);
      Navigator.pop(context, newPost);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('글쓰기')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: '제목',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: '내용',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 8,
              children: ['Tag1', 'Tag2', 'Tag3'].map((tag) {
                return FilterChip(
                  label: Text(tag),
                  selected: selectedTags.contains(tag),
                  onSelected: (isSelected) {
                    setState(() {
                      if (isSelected) {
                        selectedTags.add(tag);
                      } else {
                        selectedTags.remove(tag);
                      }
                    });
                  },
                  backgroundColor: Colors.grey[200],
                  selectedColor: Colors.blueAccent,
                  checkmarkColor: Colors.white,
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitPost,
              child: Text('등록'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
