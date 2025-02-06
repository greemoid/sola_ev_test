import 'dart:convert';

/// id : "station-001"
/// title : "ECO Charge Hub"
/// address : "вул. Хрещатик, 22, Київ, 01001"
/// price : 0.24
/// coordinates : {"latitude":50.447166,"longitude":30.522731}
/// isPublic : true
/// connectors : [{"id":"connector-001","type":"CCS","maxPower":150},{"id":"connector-002","type":"CHAdeMO","maxPower":100}]
/// image_url : "https://images.pexels.com/photos/29653407/pexels-photo-29653407/free-photo-of-electric-vehicle-charging-station-at-flying-j.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"

StationModel stationModelFromJson(String str) =>
    StationModel.fromJson(json.decode(str));

String stationModelToJson(StationModel data) => json.encode(data.toJson());

class StationModel {
  StationModel({
    String? id,
    String? title,
    String? address,
    num? price,
    CoordinatesModel? coordinates,
    bool? isPublic,
    List<ConnectorsModel>? connectors,
    String? imageUrl,
  }) {
    _id = id;
    _title = title;
    _address = address;
    _price = price;
    _coordinates = coordinates;
    _isPublic = isPublic;
    _connectors = connectors;
    _imageUrl = imageUrl;
  }

  StationModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _address = json['address'];
    _price = json['price'];
    _coordinates = json['coordinates'] != null
        ? CoordinatesModel.fromJson(json['coordinates'])
        : null;
    _isPublic = json['isPublic'];
    if (json['connectors'] != null) {
      _connectors = [];
      json['connectors'].forEach((v) {
        _connectors?.add(ConnectorsModel.fromJson(v));
      });
    }
    _imageUrl = json['image_url'];
  }

  String? _id;
  String? _title;
  String? _address;
  num? _price;
  CoordinatesModel? _coordinates;
  bool? _isPublic;
  List<ConnectorsModel>? _connectors;
  String? _imageUrl;

  StationModel copyWith({
    String? id,
    String? title,
    String? address,
    num? price,
    CoordinatesModel? coordinates,
    bool? isPublic,
    List<ConnectorsModel>? connectors,
    String? imageUrl,
  }) =>
      StationModel(
        id: id ?? _id,
        title: title ?? _title,
        address: address ?? _address,
        price: price ?? _price,
        coordinates: coordinates ?? _coordinates,
        isPublic: isPublic ?? _isPublic,
        connectors: connectors ?? _connectors,
        imageUrl: imageUrl ?? _imageUrl,
      );

  String? get id => _id;

  String? get title => _title;

  String? get address => _address;

  num? get price => _price;

  CoordinatesModel? get coordinates => _coordinates;

  bool? get isPublic => _isPublic;

  List<ConnectorsModel>? get connectors => _connectors;

  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['address'] = _address;
    map['price'] = _price;
    if (_coordinates != null) {
      map['coordinates'] = _coordinates?.toJson();
    }
    map['isPublic'] = _isPublic;
    if (_connectors != null) {
      map['connectors'] = _connectors?.map((v) => v.toJson()).toList();
    }
    map['image_url'] = _imageUrl;
    return map;
  }
}

/// id : "connector-001"
/// type : "CCS"
/// maxPower : 150

ConnectorsModel connectorsFromJson(String str) =>
    ConnectorsModel.fromJson(json.decode(str));

String connectorsToJson(ConnectorsModel data) => json.encode(data.toJson());

class ConnectorsModel {
  ConnectorsModel({
    String? id,
    String? type,
    num? maxPower,
  }) {
    _id = id;
    _type = type;
    _maxPower = maxPower;
  }

  ConnectorsModel.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _maxPower = json['maxPower'];
  }

  String? _id;
  String? _type;
  num? _maxPower;

  ConnectorsModel copyWith({
    String? id,
    String? type,
    num? maxPower,
  }) =>
      ConnectorsModel(
        id: id ?? _id,
        type: type ?? _type,
        maxPower: maxPower ?? _maxPower,
      );

  String? get id => _id;

  String? get type => _type;

  num? get maxPower => _maxPower;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['maxPower'] = _maxPower;
    return map;
  }
}

/// latitude : 50.447166
/// longitude : 30.522731

CoordinatesModel coordinatesFromJson(String str) =>
    CoordinatesModel.fromJson(json.decode(str));

String coordinatesToJson(CoordinatesModel data) => json.encode(data.toJson());

class CoordinatesModel {
  CoordinatesModel({
    num? latitude,
    num? longitude,
  }) {
    _latitude = latitude;
    _longitude = longitude;
  }

  CoordinatesModel.fromJson(dynamic json) {
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }

  num? _latitude;
  num? _longitude;

  CoordinatesModel copyWith({
    num? latitude,
    num? longitude,
  }) =>
      CoordinatesModel(
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
      );

  num? get latitude => _latitude;

  num? get longitude => _longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    return map;
  }
}
