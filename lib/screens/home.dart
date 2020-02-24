import 'package:flutter/material.dart';
import 'package:movie_gallery/config.dart';
import 'package:movie_gallery/models/movies.dart';
import 'package:movie_gallery/screens/movie_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:cached_network_image/cached_network_image.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Movies movies;
  int currentMoviePage = 1;
  ScrollController _controller;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    getMovies();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }
  @override
  void dispose(){
    super.dispose();
    _controller.removeListener(_scrollListener);
    _controller.dispose();
  }

  _scrollListener(){
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      print("MAX");
      setState(() {
        currentMoviePage++;
      });
      getExtraMovie();
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      print(movies.results.length);
      if(currentMoviePage > 4){
        setState(() {
          movies.results.removeRange(movies.results.length-(20*(currentMoviePage-4)), movies.results.length);
          currentMoviePage = 4;
        });
      }
      print(movies.results.length);
    }
  }
  getExtraMovie() async{
    setState(() {
      loading = true;
    });
    var response = await http.get(MOVIES+ currentMoviePage.toString());
    if(response.statusCode == 200){
      print("SUCCESSFULL");
      setState(() {
        movies.results += Movies.fromJson(convert.jsonDecode(response.body)).results;
      });
    }
    setState(() {
      loading = false;
    });
  }
  getMovies() async{
    var response = await http.get(MOVIES+ currentMoviePage.toString());
    if(response.statusCode == 200){
      print("SUCCESSFULL");
      setState(() {
        movies = Movies.fromJson(convert.jsonDecode(response.body));
      });
      return movies;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies+"),
      ),
      body: movies == null ? Center(child: CircularProgressIndicator()):
        movieGrid()
    );
  }


  movieGrid(){
    return Stack(
      children: <Widget>[
        OrientationBuilder(
          builder: (context, orientation){
            return GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: orientation == Orientation.portrait ? 2:3,
              controller: _controller,
              // Generate 100 widgets that display their index in the List.
              children: List.generate(movies.results.length, (index) {
                return Hero(
                  tag: movies.results[index].id,
                  child: GestureDetector(
                    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> MoviePage(movie: movies.results[index]))),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(IMAGE_BASE_URL+POSTER_SIZE+movies.results[index].posterPath),
                            fit: BoxFit.fill
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
        loading ? Center(child: CircularProgressIndicator(),): Text(""),
      ],
    );
  }
}