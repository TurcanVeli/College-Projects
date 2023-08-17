import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FirstPage(),
        routes: {
          FirstPage.routename: (ctx) => FirstPage(),
          secondPage.routename: (ctx) => secondPage(),
        });
  }
}

class FirstPage extends StatefulWidget {
  static const routename = "/first_page";

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<String> catogoryTitle = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Categories"),
        elevation: 5,
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: catogoryTitle.length,
        itemBuilder: ((context, index) {
          return InkWell(
              onTap: (() {
                Navigator.pushNamed(context, secondPage.routename,
                    arguments: {'catname': catogoryTitle[index]});
              }),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 70,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Container(
                          color: Colors.red,
                          width: 70,
                          height: 70,
                          child: Icon(Icons.newspaper_outlined,
                              color: Colors.white),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                            child: Text(
                          catogoryTitle[index],
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(fontWeight: FontWeight.bold),
                        )),
                        Icon(Icons.arrow_forward_ios, color: Colors.blue),
                      ],
                    ),
                  ),
                ),
              ));
        }),
      ),
    );
  }
}

class secondPage extends StatefulWidget {
  const secondPage({super.key});
  static const routename = "second_page";

  @override
  State<secondPage> createState() => _secondPageState();
}

class _secondPageState extends State<secondPage> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    getInfo api = getInfo(Categoryname: arguments["catname"]);

    return FutureBuilder(
      future: api.Get(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          return Scaffold(
              backgroundColor: Colors.grey,
              appBar: AppBar(
                  title: Text(arguments["catname"],
                      style: TextStyle(color: Colors.white)),
                  elevation: 5,
                  backgroundColor: Colors.black),
              body: ListView.builder(
                  itemCount: data?.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      margin: EdgeInsets.all(30),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: new LinearGradient(
                          colors: [
                            Color(0xFFFF422C),
                            Color(0xFFFF9003),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.25, 0.90],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF101012),
                            offset: Offset(-12, 12),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      alignment: Alignment.centerLeft, //to align its child
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text("${index}. ${data![index]['title'] ??  "No Info"}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 15,
                          ),
                          Image.network(data![index]['urlToImage'] ?? "null"),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            data![index]['description']?? "No Info",
                            style: Theme.of(context).textTheme.headline5,
                          )
                        ],
                      ),
                    );
                  })));
        }
        return CircularProgressIndicator();
      }),
    );
  }
}

class getInfo {
  String Categoryname;
  getInfo({required this.Categoryname});
  String id = "849bd3aabb734eac96453c09c149d1f2";
  String url = "https://newsapi.org/v2/top-headlines?country=us&category=";

  Future<List> Get() async {
    List catInfos = [];

    final responde =
        await http.get(Uri.parse("${url + Categoryname}&apikey=${id}"));
    final jsonModal = json.decode(responde.body);

    jsonModal.forEach((k, v) {
      if (k.toString() == "articles") {
        for (int i = 0; i < v.length; i++) {
          catInfos.add(v[i] as Map<String, dynamic>);
        }

        return catInfos;
      }
    });

    return catInfos;
  }
}
