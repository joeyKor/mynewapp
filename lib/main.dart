import 'package:flutter/material.dart';
import 'style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
  runApp( MaterialApp(
      theme: style.theme,
      home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var tab = 0;
  var data =[];

  getData() async{
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    var result2 = jsonDecode(result.body);
    setState((){
      data = result2;
    });
    print(data);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('joystagram'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add_box_outlined),
          iconSize: 30,)
        ],
      ),
      body: [Home(data: data), Text('shop'), Text('box')][tab],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i){
          setState(() {
            tab = i;
          });
        },
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'home'),
        BottomNavigationBarItem(icon: Icon(Icons.shop_rounded), label: 'shop'),
        BottomNavigationBarItem(icon: Icon(Icons.account_box_outlined), label:'box')
      ],),

    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key, this.data}) : super(key: key);
  final data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder( itemCount: 3, itemBuilder: (c,i){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(data[i]['image']),
          Text((data[i]['date'])),
          Text(('likes' + data[i]['likes'].toString()))
        ],
      );
    });
  }
}

