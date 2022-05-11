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
  bool _isUpdate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController.addListener(() {
      if (widget.recipe != null) {
        _titleController.text = widget.recipe!.title!;
        _isUpdate = true;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Recipe'),
      ),
      body: ListView(),
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
          'Task Title',
        ),
        TextField(
          controller: _titleController,
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            hintText: 'E.g study',
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
          );
          Provider.of<DbManager>(context, listen: false).addRecipe(recipe);
        } else {
          final recipe = CreateRecipe(
            id: widget.recipe!.id,
            title: _titleController.text,
          );
          Provider.of<DbManager>(context, listen: false).updateRecipe(recipe);
        }
        Navigator.pop(context);
      },
      child: const Text(
        'Create Task',
      ),
    );
  }
}
