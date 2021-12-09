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
    data['UID'] = uid;
    data['UUID'] = uuid;
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

class AnnounceModel {
  String image;
  String name;
  String text;

  AnnounceModel({
    this.image,
    this.name,
    this.text,
  });

  fromJson(Map<String, dynamic> json) {
    return AnnounceModel(
      image: json['image'],
      name: json['name'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new, prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = image;
    data['name'] = name;
    data['text'] = text;

    return data;
  }
}

class ServiceModel {
  String refid;
  String certid;
  String date;

  ServiceModel({
    this.refid,
    this.certid,
    this.date,
  });

  fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      refid: json['refid'],
      certid: json['certid'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new, prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refid'] = refid;
    data['certid'] = certid;
    data['date'] = date;

    return data;
  }
}

class EnquiryModel {
  String email;
  String subject;
  String message;

  EnquiryModel({
    this.email,
    this.subject,
    this.message,
  });

  fromJson(Map<String, dynamic> json) {
    return EnquiryModel(
      email: json['email'],
      subject: json['subject'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new, prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['subject'] = subject;
    data['message'] = message;

    return data;
  }
}

