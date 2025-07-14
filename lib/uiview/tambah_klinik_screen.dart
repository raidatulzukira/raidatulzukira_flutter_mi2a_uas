import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahKlinikScreen extends StatefulWidget {
  @override
  _TambahKlinikScreenState createState() => _TambahKlinikScreenState();
}

class _TambahKlinikScreenState extends State<TambahKlinikScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController telponController = TextEditingController();
  final TextEditingController tipeController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  Future<void> submitData() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse('http://192.168.43.228:8000/api/klinik'),
        body: {
          'nama_klinik': namaController.text,
          'alamat_lengkap': alamatController.text,
          'no_telpon': telponController.text,
          'jenis_klinik': tipeController.text,
          'latitude': latitudeController.text,
          'longitude': longitudeController.text,
        },
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('✅ Data berhasil ditambahkan')));
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('❌ Gagal menambahkan data')));
      }
    }
  }

  Widget buildInput(
    TextEditingController controller,
    String label,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType:
            (label.contains('Latitude') || label.contains('Longitude'))
                ? TextInputType.numberWithOptions(decimal: true)
                : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: color),
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[700]),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        validator: (value) => value!.isEmpty ? '$label wajib diisi' : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambah Data Klinik",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18.7),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
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
                  Text(
                    "Input Data Klinik",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 20),
                  buildInput(
                    namaController,
                    'Nama Klinik',
                    Icons.health_and_safety,
                    Colors.pink,
                  ),
                  buildInput(
                    alamatController,
                    'Alamat Lengkap',
                    Icons.location_on,
                    Colors.orange,
                  ),
                  buildInput(
                    telponController,
                    'No Telepon',
                    Icons.phone,
                    Colors.teal,
                  ),
                  buildInput(
                    tipeController,
                    'Jenis Klinik',
                    Icons.category,
                    Colors.indigo,
                  ),
                  buildInput(
                    latitudeController,
                    'Latitude',
                    Icons.map,
                    Colors.green,
                  ),
                  buildInput(
                    longitudeController,
                    'Longitude',
                    Icons.map_outlined,
                    Colors.blueGrey,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: submitData,
                    icon: Icon(Icons.save, color: Colors.white),
                    label: Text(
                      'Simpan Data',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
