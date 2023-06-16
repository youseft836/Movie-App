import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_app/src/features/movies/presentation/manager/movies_manager.dart';
import 'package:movies_app/src/features/movies/presentation/pages/movies_details_page.dart';
import 'package:movies_app/src/features/movies/presentation/widgets/movies_list_card.dart';
import 'package:provider/provider.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  int currentSelected = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MoviesManager>(context, listen: false).getPlayingNow();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff100E2A),
        body: Consumer<MoviesManager>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              provider.getPlayingNow();
                              setState(() {
                                currentSelected = 0;
                              });
                            },
                            child: Text(
                              'Now',
                              style: TextStyle(
                                color: currentSelected == 0
                                    ? Colors.white
                                    : Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          GestureDetector(
                            onTap: () {
                              provider.getPopular();
                              setState(() {
                                currentSelected = 1;
                              });
                            },
                            child: Text(
                              'Popular',
                              style: TextStyle(
                                color: currentSelected == 1
                                    ? Colors.white
                                    : Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Text(
                            'Recently',
                            style: TextStyle(
                              color: currentSelected == 2
                                  ? Colors.white
                                  : Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    provider.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : provider.moviesListResponse == null
                            ? const Center(
                                child: Text("No Data"),
                              )
                            : ListView.separated(
                                clipBehavior: Clip.none,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MoviesDetailsPage(
                                            movieId: provider.moviesListResponse?.movies?[index].id?.toInt() ?? 0,
                                          ),
                                        ),
                                      );
                                    },
                                    child: MoviesListCard(
                                      movie: provider
                                          .moviesListResponse?.movies?[index],
                                    ),
                                  );
                                },
                                itemCount: provider
                                        .moviesListResponse?.movies?.length ??
                                    0,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    height: 55,
                                  );
                                },
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
}
