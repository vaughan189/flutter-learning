import 'package:flutter/material.dart';

import '../blocs/movie_detail_bloc_provider.dart';
import '../models/trailer_model.dart';

class MovieDetail extends StatefulWidget {
  final dynamic posterUrl;
  final dynamic description;
  final dynamic releaseDate;
  final dynamic title;
  final dynamic voteAverage;
  final dynamic movieId;

  const MovieDetail({
    Key? key,
    required this.title,
    required this.posterUrl,
    required this.description,
    required this.releaseDate,
    required this.voteAverage,
    required this.movieId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => MovieDetailState();
}

class MovieDetailState extends State<MovieDetail> {
  late MovieDetailBloc bloc;

  MovieDetailState();

  @override
  void didChangeDependencies() {
    bloc = MovieDetailBlocProvider.of(context);
    bloc.fetchTrailersById(widget.movieId);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                  "https://image.tmdb.org/t/p/w500${widget.posterUrl}",
                  fit: BoxFit.cover,
                )),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(margin: const EdgeInsets.only(top: 5.0)),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 1.0, right: 1.0),
                    ),
                    Text(
                      widget.voteAverage,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    ),
                    Text(
                      widget.releaseDate,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                Container(margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Text(widget.description),
                Container(margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                const Text(
                  "Trailer",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                StreamBuilder(
                  stream: bloc.movieTrailers,
                  builder:
                      (context, AsyncSnapshot<Future<TrailerModel>> snapshot) {
                    if (snapshot.hasData) {
                      return FutureBuilder(
                        future: snapshot.data,
                        builder: (context,
                            AsyncSnapshot<TrailerModel> itemSnapShot) {
                          if (itemSnapShot.hasData) {
                            if (itemSnapShot.data!.results.isNotEmpty) {
                              return trailerLayout(itemSnapShot.data);
                            } else {
                              return noTrailer(itemSnapShot.data);
                            }
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget noTrailer(TrailerModel? data) {
    return const Center(
      child: Text("No trailer available"),
    );
  }

  Widget trailerLayout(TrailerModel? data) {
    if (data!.results.length > 1) {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
          trailerItem(data, 1),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
        ],
      );
    }
  }

  trailerItem(TrailerModel data, int index) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(5.0),
            height: 100.0,
            color: Colors.grey,
            child: const Center(child: Icon(Icons.play_circle_filled)),
          ),
          Text(
            data.results[index].name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
