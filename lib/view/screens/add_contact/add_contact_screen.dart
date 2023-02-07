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

class _AddContactScreenState extends State<AddContactScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshCategory();
  }

  void refreshCategory() async {
    final data = await SQLHelper.getCategories();
    setState(() {
      category = data;
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

  String? firstname;
  String? lastname;
  String? emailId;
  String? mobileNo;
  String? categoryName;
  int? categoryId;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  saveContact() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }
  }

  String dropdownvalue = 'Item 11';
  String dvalue = 'meet';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  static const Map<String, Duration> frequencyOptions = {
    "30 seconds": Duration(seconds: 30),
    "1 minute": Duration(minutes: 1),
    "2 minutes": Duration(minutes: 2),
  };

  Duration _frequencyValue = Duration(seconds: 30);

  @override
  Widget build(BuildContext context) {
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
                      decoration: const InputDecoration(hintText: "First Name"),
                      validator: (val) =>
                      val?.length == 0 ? "Enter FirstName" : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: "Last Name"),
                      validator: (val) =>
                      val?.length == 0 ? "Enter LastName" : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
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
                      child: cityList(),
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


Widget cityList(){

  String dropValue = "";

  List<CategoryValue> categoryList = List<CategoryValue>.from(
      category.map((i){
        return CategoryValue.fromJSON(i);
      })
  ); //searilize citylist json data to object model.

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      border: Border.all(width: 1)
    ),
    child: DropdownButton<String>(
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
        onChanged: (String ? newValue){
        dropValue = newValue!;
          print("Selected Category id is $newValue");
        },
    ),
  );
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
