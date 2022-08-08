class SlotsHolder {
  bool? status;
  String? successNumber;
  String? message;
  List<Slots>? slots;

  SlotsHolder({this.status, this.successNumber, this.message, this.slots});

  SlotsHolder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    successNumber = json['successNumber'];
    message = json['message'];
    if (json['Slots'] != null) {
      slots = <Slots>[];
      json['Slots'].forEach((v) {
        slots!.add(new Slots.fromJson(v));
      });
    }else{
      slots = <Slots>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['successNumber'] = this.successNumber;
    data['message'] = this.message;
    if (this.slots != null) {
      data['Slots'] = this.slots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Slots {
  int? id;
  String? start;
  String? end;

  Slots({this.id, this.start, this.end});

  Slots.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start'] = this.start;
    data['end'] = this.end;
    return data;
  }
}

