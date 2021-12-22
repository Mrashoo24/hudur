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
      companyId,
      pass,
      hoursOfShift,
      reportingTime;
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
    this.companyId,
    this.hoursOfShift,
    this.reportingTime,
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
      companyId: json['companyid'],
      hoursOfShift: json['hours_of_shift'],
      reportingTime: json['reporting_time'],
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
    data['companyid'] = companyId;
    data['hours_of_shift'] = hoursOfShift;
    data['reporting_time'] = reportingTime;

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

class RelatedSitesModel {
  String name;
  String url;

  RelatedSitesModel({
    this.name,
    this.url,
  });

  fromJson(Map<String, dynamic> json) {
    return RelatedSitesModel(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new, prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = name;
    data['url'] = url;

    return data;
  }
}

class CheckInHistoryModel {
  String checkInTime;
  String checkOutTime;
  String refId;
  String date;

  CheckInHistoryModel(
      {this.checkInTime, this.checkOutTime, this.date, this.refId});

  fromJson(Map<String, dynamic> json) {
    return CheckInHistoryModel(
      checkInTime: json['checkin'],
      checkOutTime: json['checkout'],
      date: json['date'],
      refId: json['refid'],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['checkin'] = checkInTime;
    data['checkout'] = checkOutTime;
    data['refid'] = refId;
    data['date'] = date;

    return data;
  }
}

class BenchListModel {
  String userEmpId,
      userName,
      userPhone,
      replacementEmpId,
      replacementName,
      replacementPhone,
      replacementAddress,
      replacementAllotedOffice,
      replacementDesignation,
      replacementEmail,
      replacementManager,
      replacementRefId,
      jobDescription,
      replacementType,
      from,
      to,
      verify,
      companyId,
      benchId;

  BenchListModel({
    this.benchId,
    this.from,
    this.jobDescription,
    this.replacementAddress,
    this.replacementAllotedOffice,
    this.replacementDesignation,
    this.replacementEmail,
    this.replacementEmpId,
    this.replacementManager,
    this.replacementName,
    this.replacementPhone,
    this.replacementRefId,
    this.replacementType,
    this.to,
    this.userEmpId,
    this.userName,
    this.userPhone,
    this.verify,
    this.companyId,
  });

  fromJson(Map<String, dynamic> json) {
    return BenchListModel(
      replacementAddress: json['replacement_address'],
      replacementAllotedOffice: json['replacement_allotedOffice'],
      replacementDesignation: json['replacement_designation'],
      benchId: json['benchid'],
      replacementManager: json['replacement_manager'],
      replacementEmail: json['replacement_email'],
      userName: json['user_name'],
      from: json['from'],
      jobDescription: json['job_description'],
      replacementEmpId: json['replacement_empid'],
      userEmpId: json['user_empid'],
      replacementRefId: json['replacement_refId'],
      replacementName: json['replacement_name'],
      replacementPhone: json['replacement_phone'],
      replacementType: json['replacement_type'],
      to: json['to'],
      userPhone: json['user_phone'],
      verify: json['verify'],
      companyId: json['companyid'],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new, prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['replacement_address'] = replacementAddress;
    data['replacement_allotedOffice'] = replacementAllotedOffice;
    data['replacement_designation'] = replacementDesignation;
    data['benchid'] = benchId;
    data['replacement_manager'] = replacementManager;
    data['replacement_email'] = replacementEmail;
    data['user_name'] = userName;
    data['from'] = from;
    data['job_description'] = jobDescription;
    data['replacement_empid'] = replacementEmpId;
    data['user_empid'] = userEmpId;
    data['replacement_refId'] = replacementRefId;
    data['replacement_name'] = replacementName;
    data['replacement_phone'] = replacementPhone;
    data['replacement_type'] = replacementType;
    data['to'] = to;
    data['user_phone'] = userPhone;
    data['verify'] = verify;
    data['companyid'] = companyId;
    return data;
  }
}

class AdminLeavesModel {
  String refId, companyId, employeeName, days, verify, empId;

  AdminLeavesModel({
    this.companyId,
    this.days,
    this.employeeName,
    this.refId,
    this.verify,
    this.empId,
  });

  fromJson(Map<String, dynamic> json) {
    return AdminLeavesModel(
        companyId: json['companyid'],
        days: json['days'],
        employeeName: json['name'],
        refId: json['refid'],
        verify: json['verify'],
        empId: json['empid']);
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['companyid'] = companyId;
    data['days'] = days;
    data['refid'] = refId;
    data['verify'] = verify;
    data['employee_name'] = employeeName;
    data['empid'] = empId;

    return data;
  }
}
