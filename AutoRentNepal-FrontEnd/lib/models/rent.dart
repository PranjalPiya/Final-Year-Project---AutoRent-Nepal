///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class RentVehicle {
/*
{
  "id": 1,
  "title": "Hyundai i20",
  "date": "2022-02-12T00:00:00Z",
  "image": "http://192.168.1.66:8000/media/vehiclesImages/Hyundai_i20_Vb6oZom.png",
  "seater": "4",
  "car_Type": "SUV",
  "engine": "Manual",
  "rental_price": 2500,
  "descrition": "Hyundai i20 is a 5 seater Hatchback.  It is available in 24 variants, 3 engine options that are BS6 compliant, and 2 transmission options: Manual & Automatic. Other key specifications of the i20 include a curb weight and boot space of 311 Liters.",
  "Brand": 3
} 
*/

  int? id;
  String? title;
  String? date;
  String? image;
  String? seater;
  String? carType;
  String? engine;
  int? rentalPrice;
  String? descrition;
  int? Brand;

  RentVehicle({
    this.id,
    this.title,
    this.date,
    this.image,
    this.seater,
    this.carType,
    this.engine,
    this.rentalPrice,
    this.descrition,
    this.Brand,
  });
  RentVehicle.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
    date = json['date']?.toString();
    image = json['image']?.toString();
    seater = json['seater']?.toString();
    carType = json['car_Type']?.toString();
    engine = json['engine']?.toString();
    rentalPrice = json['rental_price']?.toInt();
    descrition = json['descrition']?.toString();
    Brand = json['Brand']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['date'] = date;
    data['image'] = image;
    data['seater'] = seater;
    data['car_Type'] = carType;
    data['engine'] = engine;
    data['rental_price'] = rentalPrice;
    data['descrition'] = descrition;
    data['Brand'] = Brand;
    return data;
  }
}

class Rent {
/*
{
  "address": "Kathmandu",
  "id": 1,
  "vehicle": {
    "id": 1,
    "title": "Hyundai i20",
    "date": "2022-02-12T00:00:00Z",
    "image": "http://192.168.1.66:8000/media/vehiclesImages/Hyundai_i20_Vb6oZom.png",
    "seater": "4",
    "car_Type": "SUV",
    "engine": "Manual",
    "rental_price": 2500,
    "descrition": "Hyundai i20 is a 5 seater Hatchback.  It is available in 24 variants, 3 engine options that are BS6 compliant, and 2 transmission options: Manual & Automatic. Other key specifications of the i20 include a curb weight and boot space of 311 Liters.",
    "Brand": 3
  },
  "start_date": "2022-03-31",
  "end_date": "2022-04-01",
  "document_upload": "http://192.168.1.66:8000/media/documents/liscense.png"
} 
*/

  String? address;
  int? id;
  RentVehicle? vehicle;
  String? startDate;
  String? endDate;
  String? documentUpload;

  Rent({
    this.address,
    this.id,
    this.vehicle,
    this.startDate,
    this.endDate,
    this.documentUpload,
  });
  Rent.fromJson(Map<String, dynamic> json) {
    address = json['address']?.toString();
    id = json['id']?.toInt();
    vehicle = (json['vehicle'] != null)
        ? RentVehicle.fromJson(json['vehicle'])
        : null;
    startDate = json['start_date']?.toString();
    endDate = json['end_date']?.toString();
    documentUpload = json['document_upload']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['address'] = address;
    data['id'] = id;
    if (vehicle != null) {
      data['vehicle'] = vehicle!.toJson();
    }
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['document_upload'] = documentUpload;
    return data;
  }
}
