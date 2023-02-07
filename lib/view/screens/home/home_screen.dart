
import 'package:contacts_demo/data/local/database_helper.dart';
import 'package:contacts_demo/data/local/sql_helper.dart';
import 'package:contacts_demo/utils/utils.dart';
import 'package:contacts_demo/view/components/round_button.dart';
import 'package:flutter/material.dart';
import 'package:contacts_demo/res/constrains/string.dart';

import '../../../model/category/category.dart';
import '../../../utils/size_config.dart';
import '../../components/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// List<String> categoryArr = ["Friends", "Family"];

List<Map<String, dynamic>> category = [];

bool isLoading = false;

class _HomeScreenState extends State<HomeScreen> {

  final textEditingController = TextEditingController();
  int? currentId;

  @override
  void initState() {
    textEditingController.addListener(() {
      setState(() {});
    });
    super.initState();
    refreshCategory();
  }



  void refreshCategory() async {
    final data = await SQLHelper.getCategories();
    setState(() {
      category = data;
    });
    // setState(() => isLoading = true);
    // category = await CategoriesDatabase.instance.readAllNotes();
    // print(category);

    setState(() => isLoading = false);
  }

  void deleteCategory(int id) async {
    // CategoriesDatabase.instance.delete(id);
    await SQLHelper.deleteCategory(id);
    refreshCategory();
  }

  void saveCategory(String categoryName, {int? id}) async {
    FocusScope.of(context).unfocus();
    if(categoryName.characters.length > 3) {
      print("got id from saveCategory is $id");
      if (id == null) {
        print("got id from saveCategory is $id is null");
        // CategoriesDatabase.instance.update(Category(name: categoryName));
        final resultId = await SQLHelper.saveCategory(categoryName);
      } else {
        print("got id from saveCategory is $id is not null");
        String newValue = textEditingController.text;
        final resultId = await SQLHelper.updateCategory(id, newValue);
        // CategoriesDatabase.instance.update(Category(name: newValue,id: id));
        currentId = null;
      }
      textEditingController.clear();
      refreshCategory();
    } else {
      Utils.snackBar("Please Enter valid Category", context);
    }
  }

  void updateCategory(String catName, int id) async {
    textEditingController.text = catName;
    currentId = id;
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
    // CategoriesDatabase.instance.close();
    SQLHelper.close();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(createAndStoreCategory),
      ),
      drawer: const AppDrawer(),
      body: SizedBox(
        height: SizeConfig.screenHeight * 0.9,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Add Category",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                ),
                TextField(
                  controller: textEditingController,
                  autocorrect: false,

                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15)),
                  // style: TextStyle(letterSpacing: 2.0),
                  keyboardType: TextInputType.name,
                  onSubmitted: (category) {
                    saveCategory(category,id: currentId);
                    print(currentId);
                  },
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                ),
                RoundButton(
                    title: "Save",
                    onPress: () {
                      final catName = textEditingController.text.trim();
                      print(currentId);
                      saveCategory(catName, id: currentId);
                    }),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                ),
                Container(
                  color: Colors.grey,
                  height: SizeConfig.screenHeight * 0.4,
                  width: SizeConfig.screenWidth * 0.9,
                  child:  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : category.isEmpty
                      ? const Center(
                        child: Text(
                    'No Categories',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                      ) : ListView.builder(
                      itemCount: category.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Text(category[index].name),
                              Text(category[index]['name'] as String),
                              const Spacer(),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        // final categoryId = category[index].id;
                                        // final categoryName = category[index].name;
                                        final categoryId = category[index]['id'] as int;
                                        final categoryName = category[index]['name'] as String;
                                        updateCategory(categoryName, categoryId ?? 0);
                                      },
                                      icon: const Icon(Icons.note_alt_rounded)),
                                  IconButton(
                                      onPressed: () {
                                        // final categoryId = category[index].id;
                                        final categoryId = category[index]['id'] as int;
                                        deleteCategory(categoryId ?? 0);
                                      },
                                      icon: const Icon(Icons.delete)),
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
