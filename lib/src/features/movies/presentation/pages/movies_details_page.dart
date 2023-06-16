import 'package:cached_network_image/cached_network_image.dart';
import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_app/src/features/movies/presentation/manager/movies_manager.dart';
import 'package:movies_app/src/features/movies/presentation/pages/actors_page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'crew_page.dart';

class MoviesDetailsPage extends StatefulWidget {
  final int movieId;
  MoviesDetailsPage({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MoviesDetailsPage> createState() => _MoviesDetailsPageState();
}

class _MoviesDetailsPageState extends State<MoviesDetailsPage> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MoviesManager>(context, listen: false).getMoviesDetails(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff100E2A),
        body: Consumer<MoviesManager>(
          builder: (context, provider, child) {
            return provider.loadDetails
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : provider.movieDetailsResponse == null
                    ? const Center(
                        child: Text("No Data"),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              DeferredPointerHandler(
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    DeferredPointerHandler(
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: getImage(
                                              provider.movieDetailsResponse?.posterPath,
                                            ),
                                            height: MediaQuery.of(context).size.height / 3,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                            left: 10,
                                            right: 10,
                                            top: 10,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black.withOpacity(.15)),
                                                    child: const Center(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(10.0),
                                                        child: Icon(
                                                          Icons.arrow_back_ios_rounded,
                                                          color: Colors.white,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.more_horiz,
                                                  color: Colors.white,
                                                  size: 28,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: (MediaQuery.of(context).size.height / 3) - 50,
                                      left: 5,
                                      right: 5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          DeferredPointerHandler(
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                DeferPointer(
                                                  child: Card(
                                                    color: const Color(0xff171538),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top: 35, left: 10, right: 10, bottom: 15),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            provider.movieDetailsResponse?.title ?? '',
                                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                provider.movieDetailsResponse?.voteAverage?.toStringAsFixed(1) ?? '',
                                                                style: const TextStyle(
                                                                  fontSize: 22,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Colors.amber,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              AbsorbPointer(
                                                                absorbing: true,
                                                                child: RatingBar.builder(
                                                                  initialRating: provider.movieDetailsResponse?.voteAverage?.toDouble() ?? 0.0,
                                                                  minRating: 1,
                                                                  direction: Axis.horizontal,
                                                                  allowHalfRating: true,
                                                                  itemCount: 10,
                                                                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                                  itemBuilder: (context, _) => const Icon(
                                                                    Icons.star,
                                                                    color: Colors.amber,
                                                                  ),
                                                                  itemSize: 12,
                                                                  onRatingUpdate: (rating) {},
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            provider.movieDetailsResponse?.overview ?? '',
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 10,
                                                            style: const TextStyle(fontSize: 14, color: Colors.white24),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 15,
                                                  top: -20,
                                                  child: FloatingActionButton(
                                                    onPressed: () {
                                                      var videoKey = provider.moviesVideosListResponse?.results?[0].key ?? '';
                                                      var uri = Uri.parse('https://www.youtube.com/watch?v=$videoKey');
                                                      _launchUrl(uri);
                                                    },
                                                    backgroundColor: const Color(0xff272DDA),
                                                    child: const Icon(Icons.play_arrow),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: calcHeightFromTop(provider.movieDetailsResponse?.overview),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Card(
                                  color: const Color(0xff171538),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 35, left: 10, right: 10, bottom: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Actor",
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => ActorsPage(cast: provider.movieActorListResponse?.cast),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                "see all",
                                                style: TextStyle(color: Colors.white30),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 100,
                                          child: ListView.separated(
                                            physics: const BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: (provider.movieActorListResponse?.cast?.length ?? 0).clamp(0, 4),
                                            itemBuilder: (context, index) {
                                              return CircleAvatar(
                                                backgroundImage: CachedNetworkImageProvider(getImage(provider.movieActorListResponse?.cast?[index].profilePath)),
                                                radius: 30,
                                              );
                                            },
                                            separatorBuilder: (BuildContext context, int index) {
                                              return const SizedBox(
                                                width: 20,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Card(
                                  color: const Color(0xff171538),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 35, left: 10, right: 10, bottom: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Crew",
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => CrewsPage(cast: provider.movieActorListResponse?.crew),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                "see all",
                                                style: TextStyle(color: Colors.white30),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 100,
                                          child: ListView.separated(
                                            physics: const BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: (provider.movieActorListResponse?.crew?.length ?? 0).clamp(0, 4),
                                            itemBuilder: (context, index) {
                                              return CircleAvatar(
                                                backgroundImage: CachedNetworkImageProvider(getImage(provider.movieActorListResponse?.crew?[index].profilePath)),
                                                radius: 30,
                                              );
                                            },
                                            separatorBuilder: (BuildContext context, int index) {
                                              return const SizedBox(
                                                width: 20,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      );
          },
        ),
      ),
    );
  }

  double calcHeightFromTop(String? overview) {
    double height = 100;
    if (overview == null || overview.isEmpty == true) {
      return height;
    } else {
      for (var element in overview.characters) {
        height += .32;
      }
    }
    return height;
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

String getImage(String? path) {
  if (path != null) {
    return "https://image.tmdb.org/t/p/original/${path.substring(1) ?? ''}";
  } else {
    return '';
  }
}
