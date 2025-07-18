class Klinik {
  final int? id;
  final String namaKlinik;
  final String alamatLengkap;
  final String nomorTelepon;
  final String jenisKlinik;
  final double latitude;
  final double longitude;

  Klinik({
    this.id,
    required this.namaKlinik,
    required this.alamatLengkap,
    required this.nomorTelepon,
    required this.jenisKlinik,
    required this.latitude,
    required this.longitude,
  });

  factory Klinik.fromJson(Map<String, dynamic> json) {
    return Klinik(
      id: json['id'],
      namaKlinik: json['nama_klinik'],
      alamatLengkap: json['alamat_lengkap'],
      nomorTelepon: json['nomor_telepon'],
      jenisKlinik: json['jenis_klinik'],
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_klinik': namaKlinik,
      'alamat_lengkap': alamatLengkap,
      'nomor_telepon': nomorTelepon,
      'jenis_klinik': jenisKlinik,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}