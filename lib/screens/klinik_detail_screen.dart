import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/klinik.dart';
import '../services/klinik_services.dart';
import 'form_screen.dart';

class KlinikDetailScreen extends StatelessWidget {
  final Klinik klinik;
  final ApiService apiService = ApiService();

  KlinikDetailScreen({required this.klinik});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(klinik.namaKlinik),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => KlinikFormScreen(klinik: klinik)),
              );
              Navigator.pop(context);
            },
          ),
          IconButton(
  icon: Icon(Icons.delete),
  onPressed: () async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi'),
        content: Text('Yakin ingin menghapus klinik ini?'),
        actions: [
          TextButton(
            child: Text('Batal'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          ElevatedButton(
            child: Text('Ya'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await apiService.deleteKlinik(klinik.id!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Klinik berhasil dihapus')),
      );
      Navigator.pop(context);
    }
  },
),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.blue[50],
                    child: Icon(Icons.local_hospital, color: Colors.blue[900], size: 40),
                  ),
                  SizedBox(height: 16),
                  Text(
                    klinik.namaKlinik,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  SizedBox(height: 8),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.location_on, color: Colors.blue[700]),
                    title: Text('Alamat'),
                    subtitle: Text(klinik.alamatLengkap),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone, color: Colors.green[700]),
                    title: Text('Telepon'),
                    subtitle: Text(klinik.nomorTelepon),
                  ),
                  ListTile(
                    leading: Icon(Icons.category, color: Colors.purple[700]),
                    title: Text('Jenis Klinik'),
                    subtitle: Text(klinik.jenisKlinik),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Lokasi Klinik',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 200,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(klinik.latitude, klinik.longitude),
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('klinik'),
                    position: LatLng(klinik.latitude, klinik.longitude),
                    infoWindow: InfoWindow(title: klinik.namaKlinik),
                  ),
                },
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                liteModeEnabled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}