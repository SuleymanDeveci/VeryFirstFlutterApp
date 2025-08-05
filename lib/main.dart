import 'package:flutter/material.dart';
import 'services/grpc_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PGM Cihaz Sorgulama',
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
  
  // gRPC client
  late final _grpcClient = GrpcClient();
  bool _isLoading = false;

  SearchType _searchType = SearchType.pgm;

  // Cihaz bilgileri
  Map<String, dynamic>? _cihazBilgileri;
  List<Map<String, dynamic>> _cihazListesi = [];

  @override
  void initState() {
    super.initState();
    _initializeGrpcClient();
  }

  Future<void> _initializeGrpcClient() async {
    try {
      await _grpcClient.initialize();
    } catch (e) {
      print('gRPC bağlantısı kurulamadı: $e');
      // Kullanıcıya hata mesajı gösterilebilir
    }
  }

  Future<void> _sorgula() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _cihazBilgileri = null;
      });

      try {
        // SearchDemirbasRequest oluştur ve gönder
        final response = await _grpcClient.searchDemirbas(
          ipAddress: _searchType == SearchType.ip || _searchType == SearchType.both 
              ? _ipController.text 
              : "",
          demirbasNum: _searchType == SearchType.pgm || _searchType == SearchType.both 
              ? _pgmController.text 
              : "",
        );

        // Sonuçları işle
        setState(() {
          _cihazListesi.clear();

          if (response.demirbas.isNotEmpty) {
            // Birden fazla cihaz olabilir
            for (var demirbas in response.demirbas) {
              _cihazListesi.add({
                'id': demirbas.id,
                'demirbas_num': demirbas.demirbasNum,
                'ip_address': demirbas.ipAddress,
                'os': demirbas.os,
                'hardware_info': demirbas.hardwareInfo,
              });
            }

            // İlk cihazı seçili olarak göster
            _cihazBilgileri = _cihazListesi.first;
          } else {
            _cihazBilgileri = null;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Eşleşen cihaz bulunamadı')),
            );
          }
          _isLoading = false;
        });
      } catch (e) {
        print('Sorgu hatası: $e');
        setState(() {
          _isLoading = false;
          // Hata durumunda bir mesaj gösterilebilir
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sorgu hatası: $e')),
        );
      }
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
                    onPressed: _isLoading ? null : _sorgula,
                    icon: _isLoading 
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.search),
                    label: Text(_isLoading ? 'SORGULANIYOR...' : 'SORGULA'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Birden fazla cihaz varsa liste görünümü göster
                  if (_cihazListesi.length > 1) ...[                    
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bulunan Cihazlar (${_cihazListesi.length})',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 120,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _cihazListesi.length,
                                itemBuilder: (context, index) {
                                  final cihaz = _cihazListesi[index];
                                  final isSelected = _cihazBilgileri == cihaz;

                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        _cihazBilgileri = cihaz;
                                      });
                                    },
                                    child: Container(
                                      width: 200,
                                      margin: const EdgeInsets.only(right: 12),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: isSelected 
                                            ? Theme.of(context).colorScheme.primary 
                                            : Colors.grey.shade300,
                                          width: isSelected ? 2 : 1,
                                        ),
                                        color: isSelected 
                                          ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
                                          : Colors.white,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            cihaz['demirbas_num'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: isSelected 
                                                ? Theme.of(context).colorScheme.primary 
                                                : Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            cihaz['ip_address'],
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            cihaz['os'],
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
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
    _grpcClient.dispose();
    super.dispose();
  }
}