import 'package:flutter/material.dart';
import 'package:flutter_practical/controller/category_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AddCategory extends StatefulWidget {
  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  CategoryController categoryController = Get.put(CategoryController());
  final _form = GlobalKey<FormState>();
  String _categotyName = '';

  void _submit() async {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      try {
        await categoryController.addCategory(_categotyName);
        Get.back();
      } catch (error) {
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Category"),
      ),
      body: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.10,
                  ),
                  TextFormField(
                    key: ValueKey('categoryname'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter category name";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      hintText: 'Category Name',
                      icon: FaIcon(FontAwesomeIcons.itunes),
                    ),
                    onSaved: (value) {
                      _categotyName = value!;
                    },
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  SizedBox(
                    width: Get.width * 0.75,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(0.0)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80)))),
                      onPressed: () {
                        _submit();
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.purple, Color(0xffcc3399)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Container(
                          constraints: const BoxConstraints(
                              maxWidth: double.infinity, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Submit",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
