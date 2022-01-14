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
      managerid,
      notificationToken,
      companyId,
      pass,
      hoursOfShift,
      reportingTime,
      adminLeaves,
      studyPermit,
      maternityPermit,
      hrId,
      hrName,
      image;
  Map<String, dynamic> location;
  bool allow_checkin;

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
    this.allow_checkin,
    this.companyId,
    this.hoursOfShift,
    this.reportingTime,
    this.adminLeaves,
    this.maternityPermit,
    this.studyPermit,
    this.hrId,
    this.hrName,
    this.image,
    this.managerid,
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
        allow_checkin: json['allow_checkin'],
        location: json['location'],
        companyId: json['companyid'],
        hoursOfShift: json['hours_of_shift'],
        reportingTime: json['reporting_time'],
        adminLeaves: json['admin_leaves'],
        maternityPermit: json['maternity_permit'],
        studyPermit: json['study_permit'],
        hrId: json['hrid'],
        hrName: json['hrname'],
        managerid: json['managerid'],
        image: json['image']);
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
    data['allow_checkin'] = allow_checkin;
    data['location'] = location;
    data['companyid'] = companyId;
    data['hours_of_shift'] = hoursOfShift;
    data['reporting_time'] = reportingTime;
    data['admin_leaves'] = adminLeaves;
    data['maternity_permit'] = maternityPermit;
    data['study_permit'] = studyPermit;
    data['hrid'] = hrId;
    data['hrname'] = hrName;

    return data;
  }
}

class CoursesModel {
  String title, date, hrId, companyId, venue, courseId;

  CoursesModel({
    this.date,
    this.title,
    this.companyId,
    this.hrId,
    this.venue,
    this.courseId,
  });

  fromJson(Map<String, dynamic> json) {
    return CoursesModel(
      title: json['title'],
      date: json['date'],
      companyId: json['companyid'],
      hrId: json['hrid'],
      venue: json['venue'],
      courseId: json['courseid'],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new, prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['title'] = title;
    data['date'] = date;
    data['companyid'] = companyId;
    data['hrid'] = hrId;
    data['venue'] = venue;
    data['courseid'] = courseId;

    return data;
  }
}

class LeaveRequestsModel {
  String title;
  String subtitle;
  List details;
  String companyId;
  List attachments;
  String tenure;
  String timebased;
  String countbased;
  String limit;
  String reducedtime;
  String hourslimit;
  String financial_month;

  LeaveRequestsModel(
      {this.title,
      this.subtitle,
      this.details,
      this.companyId,
      this.attachments,
      this.countbased,
      this.hourslimit,
      this.limit,
      this.reducedtime,
      this.tenure,
      this.timebased,
      this.financial_month});

  fromJson(Map<String, dynamic> json) {
    return LeaveRequestsModel(
        title: json['title'],
        subtitle: json['subtitle'],
        details: json['details'],
        attachments: json['attachments'],
        companyId: json['companyid'],
        countbased: json['countbased'],
        hourslimit: json['hourslimit'],
        limit: json['limit'],
        reducedtime: json['reducedtime'],
        tenure: json['tenure'],
        timebased: json['timebased'],
        financial_month: json['financial_month']);
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new, prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['title'] = title;
    data['subtitle'] = subtitle;
    data['details'] = details;
    data['attachments'] = attachments;
    data['companyid'] = companyId;
    return data;
  }
}

class RelatedSitesModel {
  String name;
  String url, companyId, siteId, description;

  RelatedSitesModel({
    this.name,
    this.url,
    this.companyId,
    this.description,
    this.siteId,
  });

  fromJson(Map<String, dynamic> json) {
    return RelatedSitesModel(
      name: json['name'],
      url: json['url'],
      companyId: json['companyid'],
      description: json['description'],
      siteId: json['siteid'],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new, prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = name;
    data['url'] = url;
    data['companyid'] = companyId;
    data['description'] = description;
    data['siteid'] = siteId;

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
    // ignore: unnecessary_new, prefer_collection_literals
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
      benchId,
      timeStamp;

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
    this.timeStamp,
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
      timeStamp: json['timestamp'],
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
    data['timestamp'] = timeStamp;
    return data;
  }
}

class AdminLeavesModel {
  String refId, companyId, employeeName, days, verify, empId, from, to, date;

  AdminLeavesModel({
    this.companyId,
    this.days,
    this.employeeName,
    this.refId,
    this.verify,
    this.empId,
    this.from,
    this.to,
    this.date,
  });

  fromJson(Map<String, dynamic> json) {
    return AdminLeavesModel(
      companyId: json['companyid'],
      days: json['days'],
      employeeName: json['empname'],
      refId: json['refid'],
      verify: json['verify'],
      empId: json['empid'],
      from: json['from'],
      to: json['to'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new, prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['companyid'] = companyId;
    data['days'] = days;
    data['refid'] = refId;
    data['verify'] = verify;
    data['empname'] = employeeName;
    data['empid'] = empId;
    data['from'] = from;
    data['to'] = to;
    data['date'] = date;

    return data;
  }
}

class AttendanceReportModel {
  String empId,
      companyId,
      status,
      checkOutDifference,
      checkInDelayInHours,
      checkInDelayInMinutes,
      timeStamp,
      checkInTime,
      checkOutTime,
      employeeName,
      date,
      workingstatus,
      reason;

  AttendanceReportModel({
    this.checkInDelayInHours,
    this.checkInDelayInMinutes,
    this.checkOutDifference,
    this.companyId,
    this.empId,
    this.status,
    this.timeStamp,
    this.checkInTime,
    this.checkOutTime,
    this.date,
    this.employeeName,
    this.workingstatus,
    this.reason,
  });

  fromJson(Map<String, dynamic> json) {
    return AttendanceReportModel(
      companyId: json['companyid'],
      checkInDelayInHours: json['check_in_delay_in_hours'],
      checkInDelayInMinutes: json['check_in_delay_in_minutes'],
      checkOutDifference: json['check_out_difference'],
      status: json['status'],
      empId: json['empid'],
      timeStamp: json['timestamp'],
      checkInTime: json['checkin'],
      checkOutTime: json['checkout'],
      date: json['date'],
      employeeName: json['empname'],
      workingstatus: json['workingstatus'],
      reason: json['reason'],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new, prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['companyid'] = companyId;
    data['check_in_delay_in_hours'] = checkInDelayInHours;
    data['check_in_delay_in_minutes'] = checkInDelayInMinutes;
    data['check_out_difference'] = checkOutDifference;
    data['status'] = status;
    data['empid'] = empId;
    data['timestamp'] = timeStamp;
    data['checkin'] = checkInTime;
    data['checkout'] = checkOutTime;
    data['date'] = date;
    data['empname'] = employeeName;
    data['reason'] = reason;

    return data;
  }
}

class AnnounceModel {
  String image;
  String name;
  String text;
  String timestamp;
  String companyId;
  String hr;

  AnnounceModel({
    this.image,
    this.name,
    this.text,
    this.timestamp,
    this.companyId,
    this.hr,
  });

  fromJson(Map<String, dynamic> json) {
    return AnnounceModel(
      image: json['image'],
      name: json['name'],
      text: json['text'],
      timestamp: json['timestamp'],
      companyId: json['companyid'],
      hr: json['hr'],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new, prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = image;
    data['name'] = name;
    data['text'] = text;
    data['timestamp'] = timestamp;
    data['companyid'] = companyId;
    data['hr'] = hr;

    return data;
  }
}

class PresentCoursesModel {
  String title;
  String date;
  String companyid;
  String empid;
  String venue;
  String checkIn;
  String checkOut;
  String hrId;
  String empName;
  String empPhone;
  String courseId;

  PresentCoursesModel({
    this.title,
    this.date,
    this.companyid,
    this.empid,
    this.checkIn,
    this.checkOut,
    this.hrId,
    this.venue,
    this.empName,
    this.empPhone,
    this.courseId,
  });

  fromJson(Map<String, dynamic> json) {
    return PresentCoursesModel(
      title: json['title'],
      date: json['date'],
      companyid: json['companyid'],
      empid: json['empid'],
      venue: json['venue'],
      checkIn: json['checkin'],
      checkOut: json['checkout'],
      hrId: json['hrid'],
      empName: json['emp_name'],
      empPhone: json['emp_phone'],
      courseId: json['courseid'],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new, prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = title;
    data['date'] = date;
    data['companyid'] = companyid;
    data['empid'] = empid;
    data['venue'] = venue;
    data['checkin'] = checkIn;
    data['checkout'] = checkOut;
    data['hrid'] = hrId;
    data['emp_name'] = empName;
    data['emp_phone'] = empPhone;
    data['courseid'] = courseId;

    return data;
  }
}

class ServicesModel {
  String refid;
  String certid;
  String date;
  String verify;
  String companyId;
  String certificateName;
  String fileName;

  ServicesModel({
    this.refid,
    this.certid,
    this.date,
    this.verify,
    this.companyId,
    this.certificateName,
    this.fileName,
  });

  fromJson(Map<String, dynamic> json) {
    return ServicesModel(
      refid: json['refid'],
      certid: json['certid'],
      date: json['date'],
      verify: json['verify'],
      companyId: json['companyid'],
      certificateName: json['certificatename'],
      fileName: json['filename'],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new, prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refid'] = refid;
    data['certid'] = certid;
    data['date'] = date;
    data['verify'] = verify;
    data['companyId'] = companyId;
    data['certificatename'] = certificateName;
    data['filename'] = fileName;

    return data;
  }
}

class EmployeeLeaveRequestsModel {
  String title,
      refId,
      date,
      details,
      verify,
      companyId,
      from,
      to,
      requestId,
      fileName;

  EmployeeLeaveRequestsModel({
    this.title,
    this.companyId,
    this.date,
    this.details,
    this.from,
    this.refId,
    this.to,
    this.verify,
    this.requestId,
    this.fileName,
  });

  fromJson(Map<String, dynamic> json) {
    return EmployeeLeaveRequestsModel(
      title: json['title'],
      companyId: json['companyid'],
      date: json['date'],
      details: json['details'],
      from: json['from'],
      refId: json['refid'],
      to: json['to'],
      verify: json['verify'],
      requestId: json['requestid'],
      fileName: json['filename'],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new, prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['title'] = title;
    data['companyid'] = companyId;
    data['details'] = details;
    data['date'] = date;
    data['from'] = from;
    data['refid'] = refId;
    data['to'] = to;
    data['verify'] = verify;
    data['filename'] = fileName;
    data['requestid'] = requestId;
    return data;
  }
}

class EnquiryModel {
  String empName,
      empEmail,
      refId,
      companyId,
      subject,
      description,
      timeStamp,
      hrId,
      hrName;

  EnquiryModel({
    this.companyId,
    this.description,
    this.empEmail,
    this.refId,
    this.empName,
    this.subject,
    this.timeStamp,
    this.hrId,
    this.hrName,
  });

  fromJson(Map<String, dynamic> json) {
    return EnquiryModel(
      companyId: json['companyid'],
      description: json['description'],
      empEmail: json['empemail'],
      refId: json['refid'],
      empName: json['empname'],
      subject: json['subject'],
      timeStamp: json['timestamp'],
      hrId: json['hrid'],
      hrName: json['hrname'],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new, prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['description'] = description;
    data['companyid'] = companyId;
    data['empemail'] = empEmail;
    data['refid'] = refId;
    data['empname'] = empName;
    data['subject'] = subject;
    data['timestamp'] = timeStamp;
    data['hrid'] = hrId;
    data['hrname'] = hrName;
    return data;
  }
}

class ServiceDynamicModel {
  String serviceDynamicId, companyId, name, description;
  List fields;

  ServiceDynamicModel({
    this.companyId,
    this.description,
    this.fields,
    this.name,
    this.serviceDynamicId,
  });

  fromJson(Map<String, dynamic> json) {
    return ServiceDynamicModel(
      companyId: json['companyid'],
      description: json['description'],
      fields: json['fields'],
      name: json['name'],
      serviceDynamicId: json['serdynid'],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new, prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['description'] = description;
    data['companyid'] = companyId;
    data['fields'] = fields;
    data['name'] = name;
    data['serdynid'] = serviceDynamicId;
    return data;
  }
}

class DynamicServiceRequestModel {
  String serviceId,
      companyId,
      empname,
      hrRefId,
      managerRefId,
      date,
      verify,
      refId,
      serdynid,
      fileName;

  DynamicServiceRequestModel({
    this.companyId,
    this.serviceId,
    this.date,
    this.empname,
    this.hrRefId,
    this.managerRefId,
    this.refId,
    this.verify,
    this.serdynid,
    this.fileName,
  });

  fromJson(Map<String, dynamic> json) {
    return DynamicServiceRequestModel(
      companyId: json['companyid'],
      serviceId: json['serviceid'],
      date: json['date'],
      empname: json['empname'],
      hrRefId: json['hr_refid'],
      managerRefId: json['manager_refid'],
      refId: json['refid'],
      verify: json['verify'],
      serdynid: json['serdynid'],
      fileName: json['filename'],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new, prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['companyid'] = companyId;
    data['serviceid'] = serviceId;
    data['date'] = date;
    data['empname'] = empname;
    data['hr_refid'] = hrRefId;
    data['manager_refid'] = managerRefId;
    data['refid'] = refId;
    data['verify'] = verify;
    data['serdynid'] = serdynid;
    data['filename'] = fileName;
    return data;
  }
}
