import 'package:flutter/material.dart';

class SearchRecipeCard extends StatelessWidget {
  final String title;
  final String thumb;
  final String keys;
  final String times;
  final String portion;
  final String dificulty;
  const SearchRecipeCard({
    Key? key,
    required this.title,
    required this.thumb,
    required this.keys,
    required this.times,
    required this.portion,
    required this.dificulty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                child: Image.network(
                  thumb,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              Positioned(
                right: 8.0,
                top: 8.0,
                child: SizedBox(
                  child: GestureDetector(
                    onTap: () {
                      print('portion: $portion | dificulty: $dificulty');
                    },
                    child: const Icon(
                      Icons.bookmark_border_outlined,
                      size: 36,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 8.0,
                bottom: 8.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.timer_sharp,
                              size: 20,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              times,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.palette_rounded,
                              size: 20,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              portion,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.https_sharp,
                              size: 20,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              dificulty,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
