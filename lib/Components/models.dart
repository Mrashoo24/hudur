class UserModel {
  String address,
      name,
      phoneNumber,
      uid,
      uuid,
      allotedOffice,
      designation,
      leaves,
      manager,
      notificationToken,
      pass;

  UserModel({
    required this.address,
    required this.allotedOffice,
    required this.designation,
    required this.leaves,
    required this.manager,
    required this.name,
    required this.notificationToken,
    required this.pass,
    required this.phoneNumber,
    required this.uid,
    required this.uuid,
  });

  fromJson(Map<String, dynamic> json) {
    return UserModel(
      address: json['Address'],
      allotedOffice: json['allotted_office'],
      designation: json['designation'],
      leaves: json['leaves'],
      manager: json['manager'],
      name: json['Name'],
      notificationToken: json['notificationToken'],
      pass: json['pass'],
      phoneNumber: json['PhoneNumber'],
      uid: json['UID'],
      uuid: json['UUID'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['Address'] = address;
    data['allotted_office'] = allotedOffice;
    data['designation'] = designation;
    data['leaves'] = leaves;
    data['manager'] = manager;
    data['Name'] = name;
    data['notificationToken'] = notificationToken;
    data['pass'] = pass;
    data['PhoneNumber'] = phoneNumber;
    data['UID'] = uid;
    data['UUID'] = uuid;

    return data;
  }
}
