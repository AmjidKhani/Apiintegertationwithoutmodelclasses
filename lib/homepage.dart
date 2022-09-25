import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm/Users.dart';
class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<Users?> mylist = [];

  Future<List<Users?>> getdata() async {
    String? uri="https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(Uri.parse(uri.toString()));
    var jsonapi = await jsonDecode(response.body);
    if (response.statusCode == 200) {

      for (Map item in jsonapi) {

        mylist.add(Users.fromJson(item)
        );
      }
      return mylist;
    } else {
      return mylist;
    }
  }
  @override
  void initState() {
    getdata();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getdata(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemCount: mylist.length,
              itemBuilder: (c, index) {
                return Card(
                  child: Column(
                    children: [
                  Text(
                  "${mylist[index]!.id}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                      Text(
                        "${mylist[index]!.title}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${mylist[index]!.body}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );


              });
        },
      ),
    );
  }
}
