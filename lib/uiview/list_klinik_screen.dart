import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/klinik_model.dart';
import 'detail_klinik_screen.dart';
import 'edit_klinik_screen.dart';
import 'tambah_klinik_screen.dart';

class ListKlinikScreen extends StatefulWidget {
  @override
  _ListKlinikScreenState createState() => _ListKlinikScreenState();
}

class _ListKlinikScreenState extends State<ListKlinikScreen> {
  List<Klinik> listKlinik = [];

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.43.228:8000/api/klinik'),
      );

      print("Status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;

        setState(() {
          listKlinik = data.map((json) => Klinik.fromJson(json)).toList();
        });
      } else {
        print("❌ Gagal ambil data, status: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Error fetchData: $e");
    }
  }

  Future<void> deleteData(int id) async {
    final response = await http.delete(
      Uri.parse('http://192.168.43.228:8000/api/klinik/$id'),
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("✅ Data berhasil dihapus")));
      fetchData();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daftar Klinik",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body:
          listKlinik.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Expanded(
                      child: ListView.builder(
                        itemCount: listKlinik.length,
                        itemBuilder: (context, index) {
                          final klinik = listKlinik[index];
                          return Card(
                            elevation: 4,
                            margin: EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.teal,
                                child: Icon(Icons.school, color: Colors.white),
                              ),
                              title: Text(
                                klinik.namaKlinik,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(klinik.noTelpon),
                              trailing: Wrap(
                                spacing: 0,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blueAccent,
                                    ),
                                    onPressed: () async {
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (_) => EditKlinikScreen(
                                                klinik: klinik,
                                              ),
                                        ),
                                      );
                                      if (result == true) fetchData();
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder:
                                            (ctx) => AlertDialog(
                                              title: Text('Konfirmasi'),
                                              content: Text(
                                                'Anda yakin ingin menghapus data?',
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: Text('Batal'),
                                                  onPressed:
                                                      () =>
                                                          Navigator.of(
                                                            ctx,
                                                          ).pop(),
                                                ),
                                                TextButton(
                                                  child: Text('Hapus'),
                                                  onPressed: () async {
                                                    Navigator.of(ctx).pop();
                                                    await deleteData(
                                                      klinik.id!,
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) =>
                                            DetailKlinikScreen(klinik: klinik),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TambahKlinikScreen()),
          );
          if (result == true) fetchData();
        },
      ),
    );
  }
}
