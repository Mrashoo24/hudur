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
     this.address,
     this.allotedOffice,
     this.designation,
     this.leaves,
     this.manager,
     this.name,
     this.notificationToken,
     this.pass,
     this.phoneNumber,
     this.uid,
     this.uuid,
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
