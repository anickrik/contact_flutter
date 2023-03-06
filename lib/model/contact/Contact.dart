const String tableContact = 'contact';

class ContactFields {
  static final List<String> values = [
    id, firstName, lastName, mobileNo, emailId, categoryName, categoryId, imagePath
  ];
  static const String id = 'id';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String mobileNo = 'mobileNo';
  static const String emailId = 'emailId';
  static const String categoryName = 'categoryName';
  static const String categoryId = 'categoryId' ;
  static const String imagePath = 'imagePath';

}

class Contact{
  int? id;
  String firstName;
  String lastName;
  String mobileNo;
  String emailId;
  String categoryName;
  int categoryId;
  String imagePath;

  Contact(this.firstName, this.lastName,this.mobileNo,this.emailId, this.categoryName, this.categoryId, this.imagePath);
}