import 'package:flutter/material.dart';
import '../models/klinik.dart';
import '../services/klinik_services.dart';

class KlinikFormScreen extends StatefulWidget {
  final Klinik? klinik;
  KlinikFormScreen({this.klinik});

  @override
  _KlinikFormScreenState createState() => _KlinikFormScreenState();
}

class _KlinikFormScreenState extends State<KlinikFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String namaKlinik, alamatLengkap, nomorTelepon, jenisKlinik;
  late double latitude, longitude;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    namaKlinik = widget.klinik?.namaKlinik ?? '';
    alamatLengkap = widget.klinik?.alamatLengkap ?? '';
    nomorTelepon = widget.klinik?.nomorTelepon ?? '';
    jenisKlinik = widget.klinik?.jenisKlinik ?? 'Umum';
    latitude = widget.klinik?.latitude ?? 0.0;
    longitude = widget.klinik?.longitude ?? 0.0;
  }

  void save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final klinik = Klinik(
        id: widget.klinik?.id,
        namaKlinik: namaKlinik,
        alamatLengkap: alamatLengkap,
        nomorTelepon: nomorTelepon,
        jenisKlinik: jenisKlinik,
        latitude: latitude,
        longitude: longitude,
      );
      if (widget.klinik == null) {
        await apiService.createKlinik(klinik);
      } else {
        await apiService.updateKlinik(widget.klinik!.id!, klinik);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.klinik == null ? 'Tambah Klinik' : 'Edit Klinik')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: namaKlinik,
                decoration: InputDecoration(labelText: 'Nama Klinik'),
                onSaved: (v) => namaKlinik = v!,
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                initialValue: alamatLengkap,
                decoration: InputDecoration(labelText: 'Alamat Lengkap'),
                onSaved: (v) => alamatLengkap = v!,
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                initialValue: nomorTelepon,
                decoration: InputDecoration(labelText: 'Nomor Telepon'),
                onSaved: (v) => nomorTelepon = v!,
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              DropdownButtonFormField<String>(
                value: jenisKlinik,
                items: ['Umum', 'Spesialis'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setState(() => jenisKlinik = v!),
                onSaved: (v) => jenisKlinik = v!,
                decoration: InputDecoration(labelText: 'Jenis Klinik'),
              ),
              TextFormField(
                initialValue: latitude.toString(),
                decoration: InputDecoration(labelText: 'Latitude'),
                keyboardType: TextInputType.number,
                onSaved: (v) => latitude = double.parse(v!),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                initialValue: longitude.toString(),
                decoration: InputDecoration(labelText: 'Longitude'),
                keyboardType: TextInputType.number,
                onSaved: (v) => longitude = double.parse(v!),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: save,
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}