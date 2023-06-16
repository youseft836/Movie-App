import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/features/movies/data/models/responses/movie_actor_list_response.dart';

import 'movies_details_page.dart';

class CrewsPage extends StatelessWidget {
  final List<Crew>? cast;
  const CrewsPage({Key? key, this.cast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crew"),
        backgroundColor: const Color(0xff100E2A),
        elevation: 0,
      ),
      backgroundColor: const Color(0xff100E2A),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(getImage(cast?[index].profilePath)),
                    radius: 30,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cast?[index].originalName ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        cast?[index].department ?? '',
                        style: const TextStyle(
                          color: Colors.white38,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          itemCount: cast?.length ?? 0,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 15,
            );
          },
        ),
      ),
    );
  }
}
