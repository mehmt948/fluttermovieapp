import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_gallery/config.dart';
import 'package:movie_gallery/models/movie.dart';
class MoviePage extends StatelessWidget {
  final Movie movie;
  MoviePage({this.movie});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: OrientationBuilder(
        builder: (context,orientation){
          if(orientation == Orientation.portrait){
            return getPortrait(context);
          }else{
            return getLandscape(context);
          }
        },
      ),
    );
  }
  getPortrait(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top:13),
      child: Hero(
        tag: movie.id,
        child: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 1.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      IMAGE_BASE_URL + POSTER_SIZE + movie.posterPath),
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  movie.voteAverage.toString(),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.purple
                  ),
                ),

                Text(
                  movie.releaseDate,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.teal
                  ),

                ),
              ],
            ),
            SizedBox(height: 20,),
            Text(
              movie.overview,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400
              ),
            ),
          ],
        ),
      ),
    );
  }
  getLandscape(BuildContext context){
      return Container(
        padding: EdgeInsets.only(top:5,right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: movie.id,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/1.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(IMAGE_BASE_URL+POSTER_SIZE+movie.posterPath),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        movie.voteAverage.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.purple
                        ),
                      ),
                      Text(
                        movie.releaseDate,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.teal
                        ),

                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView(
                children: <Widget>[
                  Text(
                    movie.overview,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  }
}
