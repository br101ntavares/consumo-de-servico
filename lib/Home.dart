import 'package:consumo_de_servico_avancado/Post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _urlBase = "https://jsonplaceholder.typicode.com";

  Future<List<Post>> _recuperarPostagens() async{

    http.Response response = await http.get (_urlBase + "/posts" );

    var dadosJson = json.decode (response.body);

    List<Post> postagens = List();
    for (var post in dadosJson) {
      print("post: " + post ["title"]);
      Post p = Post (post["_userId"],post["id"], post["title"], post["body"]);
      postagens.add (p);
    }
   return postagens;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de Serviço Avançado"),

      ),
      body: FutureBuilder <List<Post>> (

        future:  _recuperarPostagens(),
        builder: (context, snapshot){

    switch(snapshot.connectionState) {
    case ConnectionState.none:
    case ConnectionState.waiting:
    return CircularProgressIndicator();

    break;
    case ConnectionState.active:
    case ConnectionState.done:
    if (snapshot.hasError) {
    print ("lista: Erro ao Carregar...");

    } else {
    print ("lista:  Carregou");
    return ListView.builder(
    itemCount: snapshot.data.length,
    itemBuilder: (context, index){

      List<Post> lista = snapshot.data;
      Post post = lista [index];


    return ListTile(
    title: Text(post.title),
    subtitle: Text(post.id.toString()),

    );
    });}
    }
    }));
    }
    }

