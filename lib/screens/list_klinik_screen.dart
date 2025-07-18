import 'package:flutter/material.dart';
import '../models/klinik.dart';
import '../services/klinik_services.dart';
import 'klinik_detail_screen.dart';
import 'form_screen.dart';

class KlinikListScreen extends StatefulWidget {
  @override
  _KlinikListScreenState createState() => _KlinikListScreenState();
}

class _KlinikListScreenState extends State<KlinikListScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Klinik>> kliniks;

  @override
  void initState() {
    super.initState();
    kliniks = apiService.fetchKliniks();
  }

  void refresh() {
    setState(() {
      kliniks = apiService.fetchKliniks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Klinik'),
        backgroundColor: Colors.blue[900],
      ),
      body: FutureBuilder<List<Klinik>>(
        future: kliniks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (!snapshot.hasData || snapshot.data!.isEmpty)
            return Center(child: Text('Tidak ada data'));
          return ListView.separated(
            padding: EdgeInsets.all(16),
            separatorBuilder: (context, i) => SizedBox(height: 12),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, i) {
              final klinik = snapshot.data![i];
              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue[50],
                    child: Icon(Icons.local_hospital, color: Colors.blue[900]),
                  ),
                  title: Text(
                    klinik.namaKlinik,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2),
                      Text(
                        klinik.jenisKlinik,
                        style: TextStyle(color: Colors.blueGrey[700]),
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 16, color: Colors.blue[300]),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              klinik.alamatLengkap,
                              style: TextStyle(fontSize: 12, color: Colors.blueGrey[400]),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => KlinikDetailScreen(klinik: klinik)),
                    );
                    refresh();
                  },
                  trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.blue[200]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => KlinikFormScreen()),
          );
          refresh();
        },
      ),
    );
  }
}