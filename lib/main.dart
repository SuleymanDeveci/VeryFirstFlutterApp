import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demirbaş Sorgulama',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        cardTheme: const CardThemeData(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade100,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.indigo, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
        ),
      ),
      home: const DemirbasSorgulamaPage(),
    );
  }
}

class DemirbasSorgulamaPage extends StatefulWidget {
  const DemirbasSorgulamaPage({super.key});

  @override
  State<DemirbasSorgulamaPage> createState() => _DemirbasSorgulamaPageState();
}
enum SearchType { pgm, ip, both }
class _DemirbasSorgulamaPageState extends State<DemirbasSorgulamaPage> {
  final _formKey = GlobalKey<FormState>();
  final _pgmController = TextEditingController();
  final _ipController = TextEditingController();
  

  SearchType _searchType = SearchType.pgm;
  
  // Örnek cihaz bilgileri (gerçek uygulamada API'den gelecek)
  Map<String, dynamic>? _cihazBilgileri;

  void _sorgula() {
    if (_formKey.currentState!.validate()) {
      // Gerçek uygulamada burada API çağrısı yapılacak
      // SearchDemirbasRequest oluşturulacak
      setState(() {
        _cihazBilgileri = {
          'id': 12345,
          'demirbas_num': _pgmController.text.isNotEmpty ? _pgmController.text : 'PGM-1001',
          'ip_address': _ipController.text.isNotEmpty ? _ipController.text : '192.168.1.100',
          'os': 'Windows 10 Pro',
          'hardware_info': 'Dell XPS 13, Intel i7, 16GB RAM, 512GB SSD',
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demirbaş Sorgulama'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo.shade50, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Arama Tipi',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // SegmentedButton yerine daha uyumlu bir alternatif kullanıyoruz
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<SearchType>(
                                  title: const Text('PGM'),
                                  value: SearchType.pgm,
                                  groupValue: _searchType,
                                  onChanged: (SearchType? value) {
                                    setState(() {
                                      _searchType = value!;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<SearchType>(
                                  title: const Text('IP'),
                                  value: SearchType.ip,
                                  groupValue: _searchType,
                                  onChanged: (SearchType? value) {
                                    setState(() {
                                      _searchType = value!;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<SearchType>(
                                  title: const Text('İkisi'),
                                  value: SearchType.both,
                                  groupValue: _searchType,
                                  onChanged: (SearchType? value) {
                                    setState(() {
                                      _searchType = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          if (_searchType == SearchType.pgm || _searchType == SearchType.both) ...[
                            TextFormField(
                              controller: _pgmController,
                              decoration: const InputDecoration(
                                labelText: 'PGM Numarası',
                                hintText: 'Örn. PGM-1001',
                                prefixIcon: Icon(Icons.numbers),
                              ),
                              validator: (value) {
                                if (_searchType == SearchType.pgm && (value == null || value.isEmpty)) {
                                  return 'Lütfen PGM numarası giriniz';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                          if (_searchType == SearchType.ip || _searchType == SearchType.both) ...[
                            TextFormField(
                              controller: _ipController,
                              decoration: const InputDecoration(
                                labelText: 'IP Adresi',
                                hintText: 'Örn. 192.168.1.100',
                                prefixIcon: Icon(Icons.lan),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (_searchType == SearchType.ip && (value == null || value.isEmpty)) {
                                  return 'Lütfen IP adresi giriniz';
                                }
                                return null;
                              },
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _sorgula,
                    icon: const Icon(Icons.search),
                    label: const Text('SORGULA'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (_cihazBilgileri != null) ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.computer,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Cihaz Bilgileri',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 24),
                            _buildInfoRow(context, 'ID', _cihazBilgileri!['id'].toString()),
                            _buildInfoRow(context, 'Demirbaş No', _cihazBilgileri!['demirbas_num']),
                            _buildInfoRow(context, 'IP Adresi', _cihazBilgileri!['ip_address']),
                            _buildInfoRow(context, 'İşletim Sistemi', _cihazBilgileri!['os']),
                            _buildInfoRow(context, 'Donanım Bilgisi', _cihazBilgileri!['hardware_info']),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pgmController.dispose();
    _ipController.dispose();
    super.dispose();
  }
}