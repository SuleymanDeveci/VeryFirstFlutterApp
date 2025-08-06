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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          secondary: Colors.amber.shade700,
        ),
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

  // Görünüm durumu
  bool _showWelcomeScreen = true;

  @override
  void initState() {
    super.initState();
    _initializeGrpcClient();

    // 2 saniye sonra hoş geldiniz ekranını kapat
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showWelcomeScreen = false;
        });
      }
    });
  }

  Future<void> _initializeGrpcClient() async {
    try {
      await _grpcClient.initialize();
    } catch (e) {
      print('gRPC bağlantısı kurulamadı: $e');
      // Kullanıcıya hata mesajı gösterilebilir
    }
  }

      Future<void> _showInsertDialog() async {
    final formKey = GlobalKey<FormState>();
    final demirbasController = TextEditingController();
    final ipController = TextEditingController();
    final osController = TextEditingController();
    final hardwareController = TextEditingController();
    bool isLoading = false;

    // Dialog sonucu
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.add_circle, color: Theme.of(context).colorScheme.secondary),
              const SizedBox(width: 8),
              const Text('Yeni Demirbaş Ekle'),
            ],
          ),
          content: Container(
            width: double.maxFinite,
            constraints: const BoxConstraints(maxWidth: 500),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Demirbaş numarası
                    TextFormField(
                      controller: demirbasController,
                      decoration: const InputDecoration(
                        labelText: 'PGM Numarası *',
                        hintText: 'Örn. PGM-1001',
                        prefixIcon: Icon(Icons.numbers),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'PGM numarası zorunludur';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // IP adresi
                    TextFormField(
                      controller: ipController,
                      decoration: const InputDecoration(
                        labelText: 'IP Adresi *',
                        hintText: 'Örn. 192.168.1.100',
                        prefixIcon: Icon(Icons.lan),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'IP adresi zorunludur';
                        }
                        // Basit bir IP doğrulama kontrolü
                        final ipRegex = RegExp(r'^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$');
                        if (!ipRegex.hasMatch(value)) {
                          return 'Geçerli bir IP adresi giriniz';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // İşletim sistemi
                    TextFormField(
                      controller: osController,
                      decoration: const InputDecoration(
                        labelText: 'İşletim Sistemi *',
                        hintText: 'Örn. Windows 11 Pro',
                        prefixIcon: Icon(Icons.computer),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'İşletim sistemi zorunludur';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Donanım bilgisi
                    TextFormField(
                      controller: hardwareController,
                      decoration: const InputDecoration(
                        labelText: 'Donanım Bilgisi *',
                        hintText: 'Örn. Intel i7, 16GB RAM, 512GB SSD',
                        prefixIcon: Icon(Icons.memory),
                      ),
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Donanım bilgisi zorunludur';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: isLoading ? null : () => Navigator.pop(context, false),
              child: const Text('İPTAL'),
            ),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      if (formKey.currentState!.validate()) {
                        setDialogState(() {
                          isLoading = true;
                        });

                        try {
                          final response = await _grpcClient.insertDemirbas(
                            demirbasNum: demirbasController.text,
                            ipAddress: ipController.text,
                            os: osController.text,
                            hardwareInfo: hardwareController.text,
                          );

                          if (response.success) {
                            Navigator.pop(context, true);
                          } else {
                            // Hata durumunda dialog içinde göster
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Hata: ${response.message}')),
                            );
                            setDialogState(() {
                              isLoading = false;
                            });
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Bağlantı hatası: $e')),
                          );
                          setDialogState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('KAYDET'),
            ),
          ],
        ),
      ),
    );

    // Demirbaş başarıyla eklendiyse sorguyu otomatik olarak çalıştır
    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Demirbaş başarıyla eklendi!'),
          backgroundColor: Colors.green,
        ),
      );

      // Yeni eklenen demirbaşı sorgula
      _pgmController.text = demirbasController.text;
      _searchType = SearchType.pgm;
      await _sorgula();
    }

    // Controller'ları temizle
    demirbasController.dispose();
    ipController.dispose();
    osController.dispose();
    hardwareController.dispose();
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
        title: Row(
          children: [
            Icon(
              Icons.inventory_2_rounded, 
              color: Colors.white,
              size: 28,
            ),
            const SizedBox(width: 12),
            const Text('Demirbaş Yönetimi'),
          ],
        ),
        centerTitle: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: 'Yardım',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Yardım sayfası yakında eklenecek!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Hakkında',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Row(
                    children: [
                      Icon(Icons.info, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 8),
                      const Text('Uygulama Hakkında'),
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Icon(Icons.apps, color: Theme.of(context).colorScheme.primary),
                        title: const Text('PGM Demirbaş Yönetim Sistemi'),
                        subtitle: const Text('Sürüm 1.1.0'),
                        contentPadding: EdgeInsets.zero,
                      ),
                      const Divider(),
                      const Text('Bu uygulama demirbaş arama ve ekleme işlemleri için tasarlanmıştır.'),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 14),
                          const SizedBox(width: 4),
                          Text('Güncelleme Tarihi: ${_formatDate(DateTime.now())}'),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('TAMAM'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: AnimatedScale(
        scale: _showWelcomeScreen ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.elasticOut,
        child: FloatingActionButton.extended(
          onPressed: _showInsertDialog,
          icon: const Icon(Icons.add),
          label: const Text('Yeni Ekle'),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _showWelcomeScreen
            ? _buildWelcomeScreen()
            : Container(
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
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.search_rounded,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Arama Kriterleri',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24),
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
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 56,
                    width: _isLoading ? 220 : MediaQuery.of(context).size.width - 32,
                    curve: Curves.easeInOut,
                    child: ElevatedButton.icon(
                      onPressed: _isLoading ? null : _sorgula,
                      icon: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _isLoading 
                          ? SizedBox(
                              key: const ValueKey('loading'),
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.search, key: ValueKey('search')),
                      ),
                      label: Text(_isLoading ? 'SORGULANIYOR...' : 'SORGULA'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Sonuç bulunamadı ekranı
                  if (!_isLoading && _cihazListesi.isEmpty && (_pgmController.text.isNotEmpty || _ipController.text.isNotEmpty)) ...[                    
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Sonuç Bulunamadı',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Arama kriterlerinize uygun demirbaş bulunamadı. Lütfen farklı bir arama yapmayı deneyin veya yeni bir demirbaş ekleyin.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: _showInsertDialog,
                              icon: const Icon(Icons.add),
                              label: const Text('Yeni Demirbaş Ekle'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.secondary,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Genel istatistikleri gösteren kart
                  if (!_isLoading && _cihazListesi.isNotEmpty) ...[                    
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.dashboard,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Genel Durum',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 24),
                            Row(
                              children: [
                                _buildStatisticItem(
                                  context,
                                  'Bulunan Cihaz',
                                  _cihazListesi.length.toString(),
                                  Icons.devices,
                                  Colors.indigo,
                                ),
                                _buildStatisticItem(
                                  context,
                                  'Windows',
                                  _cihazListesi.where((c) => c['os'].toString().toLowerCase().contains('windows')).length.toString(),
                                  Icons.desktop_windows,
                                  Colors.blue,
                                ),
                                _buildStatisticItem(
                                  context,
                                  'MacOS',
                                  _cihazListesi.where((c) => c['os'].toString().toLowerCase().contains('mac')).length.toString(),
                                  Icons.laptop_mac,
                                  Colors.grey,
                                ),
                                _buildStatisticItem(
                                  context,
                                  'Linux',
                                  _cihazListesi.where((c) => c['os'].toString().toLowerCase().contains('linux')).length.toString(),
                                  Icons.laptop,
                                  Colors.orange,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Birden fazla cihaz varsa liste görünümü göster
                  if (_cihazListesi.length > 1) ...[                    
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.device_hub,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Bulunan Cihazlar (${_cihazListesi.length})',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 24),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _cihazListesi.length,
                                itemBuilder: (context, index) {
                                  final cihaz = _cihazListesi[index];
                                  final isSelected = _cihazBilgileri == cihaz;

                                  return Card(
                                    elevation: isSelected ? 4 : 1,
                                    margin: const EdgeInsets.only(right: 16, bottom: 4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                        color: isSelected 
                                          ? Theme.of(context).colorScheme.primary 
                                          : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _cihazBilgileri = cihaz;
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        width: 220,
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.computer,
                                                  size: 18,
                                                  color: isSelected
                                                    ? Theme.of(context).colorScheme.primary
                                                    : Colors.grey.shade700,
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    cihaz['demirbas_num'],
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15,
                                                      color: isSelected 
                                                        ? Theme.of(context).colorScheme.primary 
                                                        : Colors.black,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.lan,
                                                  size: 16,
                                                  color: Colors.grey.shade600,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  cihaz['ip_address'],
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey.shade700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.desktop_windows,
                                                  size: 16,
                                                  color: Colors.grey.shade600,
                                                ),
                                                const SizedBox(width: 4),
                                                Expanded(
                                                  child: Text(
                                                    cihaz['os'],
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey.shade600,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _cihazBilgileri = cihaz;
                                                  });
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: isSelected
                                                    ? Theme.of(context).colorScheme.primary
                                                    : Colors.grey.shade200,
                                                  foregroundColor: isSelected
                                                    ? Colors.white
                                                    : Colors.black87,
                                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                  minimumSize: Size.zero,
                                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                ),
                                                child: Text(
                                                  isSelected ? 'Seçili' : 'Seç',
                                                  style: const TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
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
                    // Bilgisayarın durum göstergesi (örnek amaçlı)
                    // footer: Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Container(
                    //             width: 12,
                    //             height: 12,
                    //             decoration: BoxDecoration(
                    //               color: Colors.green,
                    //               shape: BoxShape.circle,
                    //             ),
                    //           ),
                    //           const SizedBox(width: 8),
                    //           const Text('Aktif'),
                    //         ],
                    //       ),
                    //       Text(
                    //         'Son Güncelleme: ${_formatDate(DateTime.now())}',
                    //         style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(height: 16),
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
            child: Row(
              children: [
                // Her bilgi türü için farklı bir ikon
                Icon(
                  label == 'ID' ? Icons.tag
                  : label == 'Demirbaş No' ? Icons.qr_code
                  : label == 'IP Adresi' ? Icons.lan
                  : label == 'İşletim Sistemi' ? Icons.desktop_windows
                  : Icons.memory,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 4),
                Text(
                  '$label:',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
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

      String _formatDate(DateTime date) {
        return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
      }

      Widget _buildProgressBar(BuildContext context, String label, double value, Color color) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade700)),
                Text('${(value * 100).toInt()}%', style: TextStyle(fontSize: 11, color: Colors.grey.shade700)),
              ],
            ),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: value,
              backgroundColor: color.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              borderRadius: BorderRadius.circular(4),
              minHeight: 6,
            ),
          ],
        );
      }

      Widget _buildStatisticItem(BuildContext context, String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        elevation: 0,
        color: color.withValues(alpha: 0.1),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(height: 8),
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
      }

  Widget _buildWelcomeScreen() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
          ],
        ),
      ),
      child: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Icon(
                    Icons.inventory_2_rounded,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'PGM Demirbaş Yönetimi',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Hoş Geldiniz',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 240,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(8),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Yükleniyor...',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),
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