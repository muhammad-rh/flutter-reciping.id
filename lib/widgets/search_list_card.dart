import 'package:flutter/material.dart';

class SearchListCard extends StatelessWidget {
  final String title;
  final String thumb;
  final String keys;
  final String times;
  final String portion;
  final String dificulty;
  const SearchListCard({
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
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: NetworkImage(thumb),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.dstATop,
            ),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade100,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/time.png', height: 18, width: 18),
                      const SizedBox(width: 2),
                      Text(
                        times,
                        style: TextStyle(
                          color: Colors.grey.shade300,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 6),
                  Row(
                    children: [
                      Image.asset('assets/portion.png', height: 18, width: 18),
                      const SizedBox(width: 2),
                      Text(
                        portion,
                        style: TextStyle(
                          color: Colors.grey.shade300,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 6),
                  Row(
                    children: [
                      Image.asset('assets/difficulty.png',
                          height: 18, width: 18),
                      const SizedBox(width: 2),
                      Text(
                        dificulty,
                        style: TextStyle(
                          color: Colors.grey.shade300,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
