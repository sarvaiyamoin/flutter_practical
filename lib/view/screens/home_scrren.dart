import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practical/controller/category_controller.dart';
import 'package:flutter_practical/view/widgets/bottom_navbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          elevation: 10,
          shadowColor: Colors.black,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.settings, color: Colors.grey)),
                    FaIcon(
                      FontAwesomeIcons.solidLightbulb,
                      color: Colors.grey,
                    ),
                    IconButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                        icon: Icon(Icons.logout))
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "wardrobe",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28),
          ),
        ),
        for (int i = 0; i < categoryController.category.length; i++) ...[
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      categoryController.category[i].categoryName.toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
                  ],
                ),
              )
            ],
          )
        ],
      ],
    );
  }
}
