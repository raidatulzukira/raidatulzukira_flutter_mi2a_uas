import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../model/klinik_model.dart';
import 'full_maps_screen.dart';

class DetailKlinikScreen extends StatelessWidget {
  final Klinik klinik;
  const DetailKlinikScreen({super.key, required this.klinik});

  Widget buildDetailRow(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final LatLng posisi = LatLng(klinik.latitude, klinik.longitude);

    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text(
          "Detail Klinik",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.teal,
              child: Icon(
                Icons.health_and_safety,
                size: 50,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Informasi Klinik",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 25),
                    buildDetailRow(
                      'Nama Klinik',
                      klinik.namaKlinik,
                      Icons.health_and_safety,
                      Colors.deepPurple,
                    ),
                    Divider(),
                    buildDetailRow(
                      'Alamat Lengkap',
                      klinik.alamatLengkap,
                      Icons.location_on,
                      Colors.orange,
                    ),
                    Divider(),
                    buildDetailRow(
                      'No Telepon',
                      klinik.noTelpon,
                      Icons.phone,
                      Colors.green,
                    ),
                    Divider(),
                    buildDetailRow(
                      'Jenis Klinik',
                      klinik.jenisKlinik,
                      Icons.category,
                      Colors.indigo,
                    ),
                    Divider(),
                    buildDetailRow(
                      'Latitude',
                      klinik.latitude.toString(),
                      Icons.map,
                      Colors.teal,
                    ),
                    buildDetailRow(
                      'Longitude',
                      klinik.longitude.toString(),
                      Icons.map_outlined,
                      Colors.blueGrey,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.teal, width: 2),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FullMapsScreen(klinik: klinik),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: posisi,
                          zoom: 15,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId('klinik-${klinik.id}'),
                            position: posisi,
                            infoWindow: InfoWindow(title: klinik.namaKlinik),
                          ),
                        },
                        zoomControlsEnabled: false,
                        onTap: (_) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FullMapsScreen(klinik: klinik),
                            ),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          color: Colors.black54,
                          padding: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          child: Text(
                            "Lihat di Maps",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
