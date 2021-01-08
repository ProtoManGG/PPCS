class HotSpotModel {
  List<CoronaHotspot> coronaHotspot;
  List<CrowdHotspot> crowdHotspot;

  HotSpotModel({this.coronaHotspot, this.crowdHotspot});

  HotSpotModel.fromJson(Map<String, dynamic> json) {
    if (json['corona_hotspot'] != null) {
      coronaHotspot = <CoronaHotspot>[];
      json['corona_hotspot'].forEach((v) {
        coronaHotspot.add(CoronaHotspot.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['crowd_hotspot'] != null) {
      crowdHotspot = <CrowdHotspot>[];
      json['crowd_hotspot'].forEach((v) {
        crowdHotspot.add(CrowdHotspot.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (coronaHotspot != null) {
      data['corona_hotspot'] = coronaHotspot.map((v) => v.toJson()).toList();
    }
    if (crowdHotspot != null) {
      data['crowd_hotspot'] = crowdHotspot.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CoronaHotspot {
  double lat;
  double long;
  int death;
  int active;
  int recovered;

  CoronaHotspot({this.lat, this.long, this.death, this.active, this.recovered});

  CoronaHotspot.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] as double;
    long = json['long'] as double;
    death = json['death'] as int;
    active = json['active'] as int;
    recovered = json['recovered'] as int;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['long'] = long;
    data['death'] = death;
    data['active'] = active;
    data['recovered'] = recovered;
    return data;
  }
}

class CrowdHotspot {
  double lat;
  double long;

  CrowdHotspot({this.lat, this.long});

  CrowdHotspot.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] as double;
    long = json['long'] as double;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}
