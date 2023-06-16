import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_app/src/features/movies/data/models/responses/movies_list_response.dart';

class MoviesListCard extends StatelessWidget {
  final Movie? movie;

  const MoviesListCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.centerRight,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff171538),
          ),
          width: 340,
          height: 155,
        ),
        Row(
          children: [
            const Expanded(child: SizedBox()),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    movie?.title ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Date : ${movie?.releaseDate ?? ''}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  AbsorbPointer(
                    absorbing: true,
                    child: RatingBar.builder(
                      initialRating: movie?.voteAverage?.toDouble() ?? 0.0,
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
                      onRatingUpdate: (rating) {

                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 15,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: CachedNetworkImage(
              imageUrl: getImage(),
              placeholder: (_, __) {
                return const Center(child: CircularProgressIndicator(),);
              },
              errorWidget: (_, __, ___) {
                return const Center(child: CircularProgressIndicator(),);
              },
              fit: BoxFit.cover,
              height: 170,
              width: 140,
            ),
          ),
        ),
      ],
    );
  }

  String getImage() {
   if(movie?.posterPath != null) {
     return "https://image.tmdb.org/t/p/original/" + (movie?.posterPath?.substring(1) ?? '');
   } else {
     return '';
   }
  }
}
