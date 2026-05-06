import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Workshop Kampus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HalamanUtama(),
    );
  }
}

// Data model sederhana buat workshop
class Workshop {
  final String judul;
  final String tanggal;
  final String lokasi;
  final int kuota;

  Workshop({
    required this.judul,
    required this.tanggal,
    required this.lokasi,
    required this.kuota,
  });
}

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  // Data dummy workshop
  final List<Workshop> daftarWorkshop = const [
    // Nggak bisa pakai const di sini karena Workshop bukan const constructor,
    // tapi bisa langsung list biasa
  ];

  @override
  Widget build(BuildContext context) {
    // Data workshop dummy
    final workshops = [
      Workshop(
        judul: 'Workshop Flutter untuk Pemula',
        tanggal: '12 Mei 2025',
        lokasi: 'Aula Gedung B, Lt. 2',
        kuota: 30,
      ),
      Workshop(
        judul: 'UI/UX Design dengan Figma',
        tanggal: '19 Mei 2025',
        lokasi: 'Lab Komputer 3',
        kuota: 25,
      ),
      Workshop(
        judul: 'Machine Learning Dasar',
        tanggal: '26 Mei 2025',
        lokasi: 'Ruang Seminar A',
        kuota: 40,
      ),
      Workshop(
        judul: 'Backend dengan Node.js',
        tanggal: '2 Juni 2025',
        lokasi: 'Lab Komputer 1',
        kuota: 20,
      ),
    ];

    return Scaffold(
      // Widget 1: AppBar
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Workshop Kampus',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      // Widget 2: ListView — biar bisa scroll kalau workshopnya banyak
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: workshops.length,
        itemBuilder: (context, index) {
          return KartuWorkshop(workshop: workshops[index]);
        },
      ),
    );
  }
}

// Widget terpisah buat kartu workshop — biar kodenya rapi
class KartuWorkshop extends StatelessWidget {
  final Workshop workshop;

  const KartuWorkshop({super.key, required this.workshop});

  @override
  Widget build(BuildContext context) {
    return Card(
      // Widget 3: Card
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),

        // Widget 4: Column — susun konten dari atas ke bawah
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul workshop
            Text(
              workshop.judul,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Baris info: tanggal, lokasi, kuota
            // Widget 5: Row — icon + teks sejajar
            _bariInfo(Icons.calendar_today, workshop.tanggal),
            const SizedBox(height: 6),
            _bariInfo(Icons.location_on, workshop.lokasi),
            const SizedBox(height: 6),
            _bariInfo(Icons.people, 'Kuota: ${workshop.kuota} orang'),
            const SizedBox(height: 14),

            // Tombol daftar — di-align ke kanan
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                // Widget 6: ElevatedButton
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Berhasil daftar: ${workshop.judul}'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Daftar Sekarang'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper buat baris icon + teks, biar nggak ngulang kode
  Widget _bariInfo(IconData icon, String teks) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            teks,
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }
}
