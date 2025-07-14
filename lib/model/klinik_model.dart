class Klinik {
  final int? id;
  final String namaKlinik;
  final String alamatLengkap;
  final String noTelpon;
  final String jenisKlinik;
  final double latitude;
  final double longitude;

  Klinik({
    this.id,
    required this.namaKlinik,
    required this.alamatLengkap,
    required this.noTelpon,
    required this.jenisKlinik,
    required this.latitude,
    required this.longitude,
  });

  factory Klinik.fromJson(Map<String, dynamic> json) {
    return Klinik(
      id: json['id'],
      namaKlinik: json['nama_klinik'],
      alamatLengkap: json['alamat_lengkap'],
      noTelpon: json['no_telpon'],
      jenisKlinik: json['jenis_klinik'],
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_klinik': namaKlinik,
      'alamat_lengkap': alamatLengkap,
      'no_telpon': noTelpon,
      'jenis_klinik': jenisKlinik,
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
    };
  }
}
