import 'dart:io';

import 'package:contacts_demo/view/components/app_drawer.dart';
import 'package:contacts_demo/view/components/round_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/local/sql_helper.dart';
import '../../../utils/utils.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({Key? key}) : super(key: key);

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

String dropDownValue = "Select Category";

List<Map<String, dynamic>> category = [];
List<CategoryValue> categoryList = [];

class _AddContactScreenState extends State<AddContactScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshCategory();
  }

  void refreshCategory() async {
    final data = await SQLHelper.getCategories();
    debugPrint(data[0]['name']);

    setState(() {
      category = data;
      categoryList = List<CategoryValue>.from(
          category.map((i){
            return CategoryValue.fromJSON(i);
          })
      );
    });
  }

  void pickImage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            child: Wrap(
              children: [
                ListTile(
                  title: Text("Camera"),
                  leading: Icon(Icons.camera_alt),
                  onTap: () {
                    getImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  title: Text("Gallery"),
                  leading: Icon(Icons.image),
                  onTap: () {
                    getImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  final ImagePicker _picker = ImagePicker();

  File? _image;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fNameController.dispose();
    lNameController.dispose();
    mobileNumberController.dispose();
    emailIDController.dispose();
  }

  Future getImage(ImageSource source) async {
    try {
      final image = await _picker.pickImage(source: source, imageQuality: 10);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        _image = imageTemp;
      });
    } catch (e) {
      Utils.snackBar(e.toString(),context);
    }
  }

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailIDController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  saveContact() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      String fname = fNameController.text;
      String lname = lNameController.text;
      String mobileNum = mobileNumberController.text;
      String emailID = emailIDController.text;
      saveContactFromSave(fname, lname, mobileNum, emailID, dropValue, _image?.path ?? "no image");
      fNameController.clear();
      lNameController.clear();
      mobileNumberController.clear();
      emailIDController.clear();
      _image = null;
      dropValue = "1";
    }
  }

  String dropValue = "1";

  //serialize city-list json data to object model.

  void saveContactFromSave(String fName, String lName, String mobileNumber, String emailID, String categoryID, String imagePath, {int? id}) async {
    FocusScope.of(context).unfocus();
      if (id == null) {
        print("got id from saveCategory is $id is null");
        // CategoriesDatabase.instance.update(Category(name: categoryName));
        final resultId = await SQLHelper.saveContact(fName, lName, mobileNumber, emailID, categoryID, imagePath);
        debugPrint("Contact saved successfully $resultId");
         Utils.snackBar("Contact saved successfully $resultId", context);
      } else {
        print("got id from saveCategory is $id is not null");
        // String newValue = textEditingController.text;
        // final resultId = await SQLHelper.updateCategory(id, newValue);
        // CategoriesDatabase.instance.update(Category(name: newValue,id: id));

      }
  }

  @override
  Widget build(BuildContext context) {

    debugPrint(categoryList.length.toString());

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Add Contact"),
      ),
      drawer: const AppDrawer(),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 150,
                width: 150,
                child: InkWell(
                    onTap: () {
                      pickImage(context);
                    },
                    child:ClipRRect(
                       borderRadius: BorderRadius.circular(100),
                      child: _image != null
                              ? Image.file(_image!, fit: BoxFit.cover,)
                              : Image.asset("assets/images/add_image.png"),
                    ),
                  ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: fNameController,
                      decoration: const InputDecoration(hintText: "First Name"),
                      validator: (val) =>
                      val?.length == 0 ? "Enter FirstName" : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: lNameController,
                      decoration: const InputDecoration(hintText: "Last Name"),
                      validator: (val) =>
                      val?.length == 0 ? "Enter LastName" : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: mobileNumberController,
                      decoration:
                          const InputDecoration(hintText: "Mobile Number"),
                      validator: (val) =>
                      val?.length == 0 ? "Enter Mobile Number" : null,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailIDController,
                      decoration: const InputDecoration(hintText: "Email"),
                      validator: (val) =>
                      val?.length == 0 ? "Enter ValidEmail" : null,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 1)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              value: dropValue,
                              hint: const Text("Select Category"),
                              onChanged: (newValue){
                                  if(newValue != null){
                                    setState(() {
                                      dropValue = newValue;
                                    });
                                    debugPrint(newValue);
                                  }
                              },
                              items: categoryList.map((item) {
                                return DropdownMenuItem<String>(value: item.id.toString() ,child: Text(item.name),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                        /* DropdownButton<String>(
                          value: "dropValue",
                          // value: dropValue.isNotEmpty ? dropValue : null,
                          borderRadius: BorderRadius.circular(15),
                          hint: const Text("Select Category"),
                          isExpanded: true,
                          items: categoryList.map((categoryOne){
                            return DropdownMenuItem<String>(
                              value: "${categoryOne.id}",
                              child: Text(categoryOne.name),
                            );
                          }).toList(),
                          onChanged: (String? newValue){
                            if (newValue != null) {
                              setState(() {
                                dropValue = newValue;
                              });
                            }

                            print("Selected Category id is $newValue");
                          },
                        ),*/
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //TODO: when we save contact it should save in database and also save in user's mobiles contact list
              RoundButton(title: "Save", onPress: () {
                saveContact();
              }),
            ],
          ),
        ),
      ),
    );
  }
}


class CategoryValue{
  int id;
  String name;
  CategoryValue({required this.id, required this.name});

  factory CategoryValue.fromJSON(Map<String, dynamic> json){
    return CategoryValue(
        id:json["id"],
        name: json["name"],
    );
  }
}
