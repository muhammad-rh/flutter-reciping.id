import 'package:flutter/material.dart';
import 'package:flutter_mini_project/models/create_recipe.dart';

class CreateRecipeCard extends StatelessWidget {
  final CreateRecipe recipe;
  final Function() onPressed;
  const CreateRecipeCard({
    Key? key,
    required this.recipe,
    required this.onPressed,
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
                  recipe.thumb!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15.0),
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
                              recipe.times!,
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
                              recipe.servings!,
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
                              recipe.dificulty!,
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
              recipe.title!,
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
