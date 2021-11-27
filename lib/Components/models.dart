class UserModel {
  String address,
      email,
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
  Map<String, dynamic> location;
  bool allowCheckin;

  UserModel({
    this.address,
    this.allotedOffice,
    this.designation,
    this.leaves,
    this.email,
    this.manager,
    this.name,
    this.notificationToken,
    this.pass,
    this.phoneNumber,
    this.uid,
    this.uuid,
    this.location,
    this.allowCheckin,
  });

  fromJson(Map<String, dynamic> json) {
    return UserModel(
      address: json['Address'],
      allotedOffice: json['allotted_office'],
      designation: json['designation'],
      leaves: json['leaves'],
      manager: json['manager'],
      email: json['email'],
      name: json['Name'],
      notificationToken: json['notificationToken'],
      pass: json['pass'],
      phoneNumber: json['PhoneNumber'],
      uid: json['UID'],
      uuid: json['UUID'],
      allowCheckin: json['allow_checkin'],
      location: json['location'],
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
    data['email'] = email;
    data['PhoneNumber'] = phoneNumber;
    data['UID'] = uid;
    data['UUID'] = uuid;
    data['allow_checkin'] = allowCheckin;
    data['location'] = location;

    return data;
  }
}
