const mockJson = '''
  [
  {
    "id": "station-001",
    "title": "ECO Charge Hub",
    "address": "вул. Хрещатик, 22, Київ, 01001",
    "price": 0.24,
    "coordinates": {
      "latitude": 50.447166,
      "longitude": 30.522731
    },
    "isPublic": true,
    "connectors": [
      {
        "id": "connector-001",
        "type": "CCS",
        "maxPower": 150
      },
      {
        "id": "connector-002",
        "type": "CHAdeMO",
        "maxPower": 100
      }
    ],
    "image_url": "https://images.pexels.com/photos/29653407/pexels-photo-29653407/free-photo-of-electric-vehicle-charging-station-at-flying-j.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
  },
  {
    "id": "station-002",
    "title": "Ocean Plaza Charger",
    "address": "вул. Антоновича, 176, Київ, 03150",
    "price": 0.31,
    "coordinates": {
      "latitude": 50.4116,
      "longitude": 30.5233
    },
    "isPublic": true,
    "connectors": [
      {
        "id": "connector-003",
        "type": "Type2",
        "maxPower": 22
      }
    ],
    "image_url": "https://images.pexels.com/photos/9799701/pexels-photo-9799701.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
  }
  ]
  ''';
