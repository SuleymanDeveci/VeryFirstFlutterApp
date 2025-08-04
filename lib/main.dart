import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const PGMCihazSorgulamaPage(),
    );
  }
}

class PGMCihazSorgulamaPage extends StatefulWidget {
  const PGMCihazSorgulamaPage({super.key});

  @override
  State<PGMCihazSorgulamaPage> createState() => _PGMCihazSorgulamaPageState();
}

class _PGMCihazSorgulamaPageState extends State<PGMCihazSorgulamaPage> {
  final _formKey = GlobalKey<FormState>();
  final _pgmController = TextEditingController();
  
  // Örnek cihaz bilgileri (gerçek uygulamada API'den gelecek)
  Map<String, String>? _cihazBilgileri;

  void _sorgula() {
    if (_formKey.currentState!.validate()) {
      // Gerçek uygulamada burada API çağrısı yapılacak
      setState(() {
        _cihazBilgileri = {
          'IP': '192.168.1.100',
          'Bina': 'A Blok',
          'Müdürlük': 'Bilgi İşlem Müdürlüğü',
          'Cihaz Tipi': 'Yazıcı'
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PGM Cihaz Sorgulama'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _pgmController,
                decoration: InputDecoration(
                  labelText: 'PGM Numarası',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen PGM numarası giriniz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _sorgula,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Sorgula'),
              ),
              const SizedBox(height: 24),
              if (_cihazBilgileri != null) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cihaz Bilgileri',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Divider(),
                        ..._cihazBilgileri!.entries.map((entry) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Text(
                                '${entry.key}:',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 8),
                              Text(entry.value),
                            ],
                          ),
                        )).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pgmController.dispose();
    super.dispose();
  }
}