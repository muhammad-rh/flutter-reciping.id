import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/screens/home/home_view_model.dart';
import 'package:flutter_mini_project/widgets/new_recipe_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Provider.of<HomeViewModel>(context, listen: false).getRecipeList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        Provider.of<HomeViewModel>(context, listen: false).getRecipeList();
      },
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 4),
                title: Text(
                  'Hello, Your Name',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'What do you want cook today?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: CircleAvatar(
                  child: Text('A'),
                  radius: 24,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 23, 47, 69),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    labelText: 'Search any recipes...',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 248, 249, 253),
                    ),
                    suffixIcon: Icon(
                      Icons.display_settings_rounded,
                      color: Color.fromARGB(255, 248, 249, 253),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              const Text(
                'New Recipes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: Consumer<HomeViewModel>(
                  builder: (context, value, child) {
                    if (value.dataState == DataState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (value.dataState == DataState.error) {
                      return const Center(
                        child: Text('Something went wrong'),
                      );
                    }

                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return NewRecipeCard(
                          title: value.recipeList[index].title ?? 'Untitle',
                          thumb: value.recipeList[index].thumb ?? '',
                          keys: value.recipeList[index].key ?? '',
                          times: value.recipeList[index].times ?? '',
                          portion: value.recipeList[index].portion ?? '',
                          dificulty: value.recipeList[index].dificulty ?? '',
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 8.0,
                        );
                      },
                      itemCount: 6,
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
