class FreeAppointmentSlots {
  String? status;
  Data? data;

  FreeAppointmentSlots({this.status, this.data});

  FreeAppointmentSlots.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  ApprovalRating? approvalRating;
  WorkingHours? workingHours;
  Slots? slots;
  String? sId;
  String? name;
  String? email;
  String? gender;
  int? age;
  int? weight;
  int? phoneNumber;
  String? highestQualification;
  int? experienceYears;
  bool? isInstantAvailable;
  int? fee;
  bool? isVerified;
  List<String>? medicalAreas;
  String? bio;
  String? profileUrl;
  bool? isActiveUser;
  int? iV;

  Data(
      {this.approvalRating,
      this.workingHours,
      this.slots,
      this.sId,
      this.name,
      this.email,
      this.gender,
      this.age,
      this.weight,
      this.phoneNumber,
      this.highestQualification,
      this.experienceYears,
      this.isInstantAvailable,
      this.fee,
      this.isVerified,
      this.medicalAreas,
      this.bio,
      this.profileUrl,
      this.isActiveUser,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    approvalRating = json['approval_rating'] != null
        ? new ApprovalRating.fromJson(json['approval_rating'])
        : null;
    workingHours = json['working_hours'] != null
        ? new WorkingHours.fromJson(json['working_hours'])
        : null;
    slots = json['slots'] != null ? new Slots.fromJson(json['slots']) : null;
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    age = json['age'];
    weight = json['weight'];
    phoneNumber = json['phone_number'];
    highestQualification = json['highest_qualification'];
    experienceYears = json['experience_years'];
    isInstantAvailable = json['is_instant_available'];
    fee = json['fee'];
    isVerified = json['is_verified'];
    medicalAreas = json['medical_areas'].cast<String>();
    bio = json['bio'];
    profileUrl = json['profile_url'];
    isActiveUser = json['is_active_user'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.approvalRating != null) {
      data['approval_rating'] = this.approvalRating!.toJson();
    }
    if (this.workingHours != null) {
      data['working_hours'] = this.workingHours!.toJson();
    }
    if (this.slots != null) {
      data['slots'] = this.slots!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['weight'] = this.weight;
    data['phone_number'] = this.phoneNumber;
    data['highest_qualification'] = this.highestQualification;
    data['experience_years'] = this.experienceYears;
    data['is_instant_available'] = this.isInstantAvailable;
    data['fee'] = this.fee;
    data['is_verified'] = this.isVerified;
    data['medical_areas'] = this.medicalAreas;
    data['bio'] = this.bio;
    data['profile_url'] = this.profileUrl;
    data['is_active_user'] = this.isActiveUser;
    data['__v'] = this.iV;
    return data;
  }
}

class ApprovalRating {
  int? avg;
  int? count;

  ApprovalRating({this.avg, this.count});

  ApprovalRating.fromJson(Map<String, dynamic> json) {
    avg = json['avg'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avg'] = this.avg;
    data['count'] = this.count;
    return data;
  }
}

class WorkingHours {
  Mon? mon;
  Mon? tue;
  Mon? wed;
  Mon? thu;
  Mon? fri;
  Mon? sat;
  Mon? sun;

  WorkingHours({this.mon, this.tue, this.wed, this.thu, this.fri, this.sat, this.sun});

  WorkingHours.fromJson(Map<String, dynamic> json) {
    mon = json['Mon'] != null ? new Mon.fromJson(json['Mon']) : null;
    tue = json['Tue'] != null ? new Mon.fromJson(json['Tue']) : null;
    wed = json['Wed'] != null ? new Mon.fromJson(json['Wed']) : null;
    thu = json['Thu'] != null ? new Mon.fromJson(json['Thu']) : null;
    fri = json['Fri'] != null ? new Mon.fromJson(json['Fri']) : null;
    sat = json['Sat'] != null ? new Mon.fromJson(json['Sat']) : null;
    sun = json['Sun'] != null ? new Mon.fromJson(json['Sun']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mon != null) {
      data['Mon'] = this.mon!.toJson();
    }
    if (this.tue != null) {
      data['Tue'] = this.tue!.toJson();
    }
    if (this.wed != null) {
      data['Wed'] = this.wed!.toJson();
    }
    if (this.thu != null) {
      data['Thu'] = this.thu!.toJson();
    }
    if (this.fri != null) {
      data['Fri'] = this.fri!.toJson();
    }
    if (this.sat != null) {
      data['Sat'] = this.sat!.toJson();
    }
    if (this.sun != null) {
      data['Sun'] = this.sun!.toJson();
    }
    return data;
  }
}

class Mon {
  Mon({
    required this.startTime,
    required this.endTime,
  });
  late final String startTime;
  late final String endTime;

  Mon.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'].toString();
    endTime = json['end_time'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['start_time'] = startTime;
    _data['end_time'] = endTime;
    return _data;
  }
}

class Tue {
  Tue({
    required this.startTime,
    required this.endTime,
  });
  late final String startTime;
  late final String endTime;

  Tue.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'].toString();
    endTime = json['end_time'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['start_time'] = startTime;
    _data['end_time'] = endTime;
    return _data;
  }
}

class Wed {
  Wed({
    required this.startTime,
    required this.endTime,
  });
  late final String startTime;
  late final String endTime;

  Wed.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'].toString();
    endTime = json['end_time'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['start_time'] = startTime;
    _data['end_time'] = endTime;
    return _data;
  }
}

class Thu {
  Thu({
    required this.startTime,
    required this.endTime,
  });
  late final String startTime;
  late final String endTime;

  Thu.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'].toString();
    endTime = json['end_time'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['start_time'] = startTime;
    _data['end_time'] = endTime;
    return _data;
  }
}

class Fri {
  Fri({
    required this.startTime,
    required this.endTime,
  });
  late final String startTime;
  late final String endTime;

  Fri.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'].toString();
    endTime = json['end_time'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['start_time'] = startTime;
    _data['end_time'] = endTime;
    return _data;
  }
}

class Sat {
  Sat({
    required this.startTime,
    required this.endTime,
  });
  late final String startTime;
  late final String endTime;

  Sat.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'].toString();
    endTime = json['end_time'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['start_time'] = startTime;
    _data['end_time'] = endTime;
    return _data;
  }
}

class Sun {
  Sun({
    required this.startTime,
    required this.endTime,
  });
  late final String startTime;
  late final String endTime;

  Sun.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'].toString();
    endTime = json['end_time'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['start_time'] = startTime;
    _data['end_time'] = endTime;
    return _data;
  }
}

class Slots {
  List<Mon1>? mon1;
  List<Tue1>? tue1;
  List<Wed1>? wed1;
  List<Thu1>? thu1;
  List<Fri1>? fri1;
  List<Sat1>? sat1;
  List<Sun1>? sun1;

  Slots({this.mon1, this.tue1, this.wed1, this.thu1, this.fri1, this.sat1, this.sun1});

  Slots.fromJson(Map<String, dynamic> json) {
    if (json['Mon'] != null) {
      mon1 = <Mon1>[];
      json['Mon'].forEach((v) {
        mon1!.add(Mon1.fromJson(v));
      });
    }
    if (json['Tue'] != null) {
      tue1 = <Tue1>[];
      json['Tue'].forEach((v) {
        tue1!.add(Tue1.fromJson(v));
      });
    }
    if (json['Wed'] != null) {
      wed1 = <Wed1>[];
      json['Wed'].forEach((v) {
        wed1!.add(new Wed1.fromJson(v));
      });
    }
    if (json['Thu'] != null) {
      thu1 = <Thu1>[];
      json['Thu'].forEach((v) {
        thu1!.add(new Thu1.fromJson(v));
      });
    }
    if (json['Fri'] != null) {
      fri1 = <Fri1>[];
      json['Fri'].forEach((v) {
        fri1!.add(new Fri1.fromJson(v));
      });
    }
    if (json['Sat'] != null) {
      sat1 = <Sat1>[];
      json['Sat'].forEach((v) {
        sat1!.add(new Sat1.fromJson(v));
      });
    }
    if (json['Sun'] != null) {
      sun1 = <Sun1>[];
      json['Sun'].forEach((v) {
        sun1!.add(new Sun1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mon1 != null) {
      data['Mon'] = this.mon1!.map((v) => v.toJson()).toList();
    }
    if (this.tue1 != null) {
      data['Tue'] = this.tue1!.map((v) => v.toJson()).toList();
    }
    if (this.wed1 != null) {
      data['Wed'] = this.wed1!.map((v) => v.toJson()).toList();
    }
    if (this.thu1 != null) {
      data['Thu'] = this.thu1!.map((v) => v.toJson()).toList();
    }
    if (this.fri1 != null) {
      data['Fri'] = this.fri1!.map((v) => v.toJson()).toList();
    }
    if (this.sat1 != null) {
      data['Sat'] = this.sat1!.map((v) => v.toJson()).toList();
    }
    if (this.sun1 != null) {
      data['Sun'] = this.sun1!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Mon1 {
  Mon1({
    required this.id,
    required this.start_time,
    required this.is_available,
    required this.is_booked,
  });

  late final String id;
  late final String start_time;
  late final bool is_available;
  late final bool is_booked;

  Mon1.fromJson(Map<String, dynamic> json) {
    id = json['_id'].toString();
    start_time = json['start_time'].toString();
    is_available = json['is_available'];
    is_booked = json['is_booked'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['start_time'] = start_time;
    _data['_id'] = id;
    _data['is_available'] = is_available;
    _data['is_booked'] = is_booked;

    return _data;
  }
}

class Tue1 {
  Tue1({
    required this.id,
    required this.start_time,
    required this.is_available,
    required this.is_booked,
  });

  late final String id;
  late final String start_time;
  late final bool is_available;
  late final bool is_booked;

  Tue1.fromJson(Map<String, dynamic> json) {
    id = json['_id'].toString();
    start_time = json['start_time'].toString();
    is_available = json['is_available'];
    is_booked = json['is_booked'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['start_time'] = start_time;
    _data['_id'] = id;
    _data['is_available'] = is_available;
    _data['is_booked'] = is_booked;

    return _data;
  }
}

class Wed1 {
  Wed1({
    required this.id,
    required this.start_time,
    required this.is_available,
    required this.is_booked,
  });

  late final String id;
  late final String start_time;
  late final bool is_available;
  late final bool is_booked;

  Wed1.fromJson(Map<String, dynamic> json) {
    id = json['_id'].toString();
    start_time = json['start_time'].toString();
    is_available = json['is_available'];
    is_booked = json['is_booked'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['start_time'] = start_time;
    _data['_id'] = id;
    _data['is_available'] = is_available;
    _data['is_booked'] = is_booked;

    return _data;
  }
}

class Thu1 {
  Thu1({
    required this.id,
    required this.start_time,
    required this.is_available,
    required this.is_booked,
  });

  late final String id;
  late final String start_time;
  late final bool is_available;
  late final bool is_booked;

  Thu1.fromJson(Map<String, dynamic> json) {
    id = json['_id'].toString();
    start_time = json['start_time'].toString();
    is_available = json['is_available'];
    is_booked = json['is_booked'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['start_time'] = start_time;
    _data['_id'] = id;
    _data['is_available'] = is_available;
    _data['is_booked'] = is_booked;

    return _data;
  }
}

class Fri1 {
  Fri1({
    required this.id,
    required this.start_time,
    required this.is_available,
    required this.is_booked,
  });

  late final String id;
  late final String start_time;
  late final bool is_available;
  late final bool is_booked;

  Fri1.fromJson(Map<String, dynamic> json) {
    id = json['_id'].toString();
    start_time = json['start_time'].toString();
    is_available = json['is_available'];
    is_booked = json['is_booked'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['start_time'] = start_time;
    _data['_id'] = id;
    _data['is_available'] = is_available;
    _data['is_booked'] = is_booked;

    return _data;
  }
}

class Sat1 {
  Sat1({
    required this.id,
    required this.start_time,
    required this.is_available,
    required this.is_booked,
  });

  late final String id;
  late final String start_time;
  late final bool is_available;
  late final bool is_booked;

  Sat1.fromJson(Map<String, dynamic> json) {
    id = json['_id'].toString();
    start_time = json['start_time'].toString();
    is_available = json['is_available'];
    is_booked = json['is_booked'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['start_time'] = start_time;
    _data['_id'] = id;
    _data['is_available'] = is_available;
    _data['is_booked'] = is_booked;

    return _data;
  }
}

class Sun1 {
  Sun1({
    required this.id,
    required this.start_time,
    required this.is_available,
    required this.is_booked,
  });

  late final String id;
  late final String start_time;
  late final bool is_available;
  late final bool is_booked;

  Sun1.fromJson(Map<String, dynamic> json) {
    id = json['_id'].toString();
    start_time = json['start_time'].toString();
    is_available = json['is_available'];
    is_booked = json['is_booked'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['start_time'] = start_time;
    _data['_id'] = id;
    _data['is_available'] = is_available;
    _data['is_booked'] = is_booked;

    return _data;
  }
}
