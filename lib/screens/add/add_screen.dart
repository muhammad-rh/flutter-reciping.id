import 'package:flutter/material.dart';
import 'package:flutter_mini_project/models/create_recipe.dart';
import 'package:flutter_mini_project/utils/db_manager.dart';
import 'package:flutter_mini_project/widgets/bottom_navbar.dart';
import 'package:flutter_mini_project/widgets/notch_navbar.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatefulWidget {
  final CreateRecipe? recipe;
  const AddScreen({
    Key? key,
    this.recipe,
  }) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _titleController = TextEditingController();
  final _servingsController = TextEditingController();
  final _timesController = TextEditingController();
  final _dificultyController = TextEditingController();
  final _descController = TextEditingController();
  bool _isUpdate = false;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() {
      if (widget.recipe != null) {
        _titleController.text = widget.recipe!.title!;
        _servingsController.text = widget.recipe!.servings!;
        _timesController.text = widget.recipe!.times!;
        _dificultyController.text = widget.recipe!.dificulty!;
        _descController.text = widget.recipe!.desc!;
        _isUpdate = true;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Recipe'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          buildNameField(),
          const SizedBox(height: 20),
          buildButton(),
        ],
      ),
      floatingActionButton: const NotchNavBar(isAdd: true),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavBar(
        isHome: false,
        isSearch: false,
        isBookmark: false,
        isProfil: false,
      ),
    );
  }

  Widget buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Title',
        ),
        TextFormField(
          controller: _titleController,
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            hintText: 'Opor Ayam',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
        const Text(
          'Desc',
        ),
        TextFormField(
          controller: _descController,
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            hintText: 'Lorem ipsum',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
        const Text(
          'Servings',
        ),
        TextFormField(
          controller: _servingsController,
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            hintText: '3 Portion',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
        const Text(
          'Times',
        ),
        TextFormField(
          controller: _timesController,
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            hintText: '1 jam',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
        const Text(
          'Difficulty',
        ),
        TextFormField(
          controller: _dificultyController,
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            hintText: 'Pemula',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButton() {
    return ElevatedButton(
      onPressed: () {
        if (!_isUpdate) {
          final recipe = CreateRecipe(
            title: _titleController.text,
            haveThumb: false,
            thumb: null,
            servings: _servingsController.text,
            times: _timesController.text,
            dificulty: _dificultyController.text,
            desc: _dificultyController.text,
            datePublished: null,
            ingredient: null,
            step: null,
          );
          Provider.of<DbManager>(context, listen: false).addRecipe(recipe);
        } else {
          final recipe = CreateRecipe(
            id: widget.recipe!.id,
            title: _titleController.text,
            haveThumb: false,
            thumb: null,
            servings: _servingsController.text,
            times: _timesController.text,
            dificulty: _dificultyController.text,
            desc: _dificultyController.text,
            datePublished: null,
            ingredient: null,
            step: null,
          );
          Provider.of<DbManager>(context, listen: false).updateRecipe(recipe);
        }
        Navigator.pop(context);
      },
      child: const Text(
        'Post Recipe',
      ),
    );
  }
}
