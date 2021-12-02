class UserModel {
  String address,
      email,
      name,
      phoneNumber,
      empId,
      refId,
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
    this.empId,
    this.refId,
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
      empId: json['empid'],
      refId: json['refid'],
      allowCheckin: json['allow_checkin'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new, prefer_collection_literals
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
    data['empid'] = empId;
    data['refid'] = refId;
    data['allow_checkin'] = allowCheckin;
    data['location'] = location;

    return data;
  }
}

class CoursesModel {
  String title;
  String date;

  CoursesModel({
    this.date,
    this.title,
  });

  fromJson(Map<String, dynamic> json) {
    return CoursesModel(
      title: json['title'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new, prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['title'] = title;
    data['date'] = date;

    return data;
  }
}

class LeaveRequestsModel {
  String title;
  String subtitle;
  List details;

  LeaveRequestsModel({
    this.title,
    this.subtitle,
    this.details,
  });

  fromJson(Map<String, dynamic> json) {
    return LeaveRequestsModel(
        title: json['title'],
        subtitle: json['subtitle'],
        details: json['details']);
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new, prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['title'] = title;
    data['subtitle'] = subtitle;
    data['details'] = details;
    return data;
  }
}
