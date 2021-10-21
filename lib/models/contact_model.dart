const String tbl_contact='tbl_contact';
const String tbl_contact_col_id='contact_id';
const String tbl_contact_col_name='contact_name';
const String tbl_contact_col_email='contact_email';
const String tbl_contact_col_website='contact_website';
const String tbl_contact_col_mobile='contact_mobile';
const String tbl_contact_col_address='contact_address';
const String tbl_contact_col_image='contact_image';
const String tbl_contact_col_favourite='contact_favourite';
class ContactModel{
  int? id;
 late String name;
 late String mobile;
  String? email;
  String? website;
  String? image;
  String? streetAddress;
  late bool favourite;

  ContactModel(
      {required this.name,
      required this.mobile,
      this.id,
      this.email,
      this.website,
      this.streetAddress,
      this.image='https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg',
      this.favourite= false}
      );
     Map<String, dynamic> toMap(){
       var map = <String, dynamic>{
         tbl_contact_col_name: name,
         tbl_contact_col_mobile: mobile,
         tbl_contact_col_email: email,
         tbl_contact_col_address: streetAddress,
         tbl_contact_col_website: website,
         tbl_contact_col_favourite: favourite? 1 : 0,
         tbl_contact_col_image: image
       };
       if(id!=null){
         map[tbl_contact_col_id]=id;
       }
       return map;
     }
     ContactModel.fromMap(Map <String, dynamic>map){
       id=map[tbl_contact_col_id];
       name=map[tbl_contact_col_name];
       mobile=map[tbl_contact_col_mobile];
       email=map[tbl_contact_col_email];
       streetAddress=map[tbl_contact_col_address];
       website=map[tbl_contact_col_website];
       favourite=map[tbl_contact_col_favourite]==0 ? false : true;
       image=map[tbl_contact_col_image];

     }

  @override
  String toString() {
    return 'ContactModel{'
        'id: $id,'
        'name: $name, '
        'mobile: $mobile, '
        'email: $email, '
        'website: $website, '
        'image: $image, '
        'streetAddress: $streetAddress, '
        'Favourite: $favourite}';
  }
}