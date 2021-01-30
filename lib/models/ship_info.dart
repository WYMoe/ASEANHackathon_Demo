

class ShipInfo{
  final String id;
  final String owner;
  final String shipName;
  final double latitude;
  final double longitude;

  ShipInfo({this.id,this.owner,this.shipName,this.latitude,this.longitude});
  factory ShipInfo.fromDocument(doc){
    return ShipInfo(
      id: doc['id'],
      owner: doc['owner'],

      shipName: doc['shipName'],
      longitude: doc['longitude'],
      latitude: doc['latitude']

    );

  }


}