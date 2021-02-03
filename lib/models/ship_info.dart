

class ShipInfo{
  final String id;
  final String owner;
  final String shipName;
  final double latitude;
  final double longitude;
  final String regNum;
  final int yearBuilt;
  final String companyName;
  final String address;
  final int contact;
  final String type;

  ShipInfo({this.id,this.owner,this.shipName,this.latitude,this.longitude,this.regNum,
    this.yearBuilt,
    this.companyName,
    this.address,
    this.contact,
    this.type});



  factory ShipInfo.fromDocument(doc){
    return ShipInfo(
      id: doc['id'],
      owner: doc['owner'],
     shipName: doc['shipName'],
      longitude: doc['longitude'],
      latitude: doc['latitude'],
      regNum: doc['registration'],
      yearBuilt: doc['year_built'],
        companyName:doc['company_name'],
        address: doc['address'],
        contact: doc['contact'],
        type: doc['type'],

    );

  }


}