import 'package:flutter/material.dart';
import 'package:modelo_ar/services/database_service.dart';
import '../theme/app_theme.dart';
import '../models/articulos.dart';

class AddArticlePage extends StatefulWidget {
  const AddArticlePage({Key? key}) : super(key: key);

  @override
  State<AddArticlePage> createState() => _AddArticlePageState();
}

class _AddArticlePageState extends State<AddArticlePage> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _historiaController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();

  final DatabaseService _databaseService = DatabaseService();

  @override
  void dispose() {
    _nombreController.dispose();
    _categoriaController.dispose();
    _historiaController.dispose();
    _usuarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Artículo'),
        backgroundColor: AppTheme.accent, 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Ingresa los datos del nuevo modelo',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre del artículo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _categoriaController,
              decoration: const InputDecoration(
                labelText: 'Categoría del artículo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _historiaController,
              maxLines: 3, 
              decoration: const InputDecoration(
                labelText: 'Historia del artículo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _usuarioController,
              decoration: const InputDecoration(
                labelText: 'Usuario que agrega el artículo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                if (_nombreController.text.isEmpty || _categoriaController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Por favor llena los campos principales')),
                  );
                  return;
                }

                Articulos articulo = Articulos(
                  articulo: _nombreController.text,
                  categoria: _categoriaController.text,
                  historia: _historiaController.text,
                  imagen: 'https://example.com/image.jpg',
                  url: 'https://example.com',
                  usuario: _usuarioController.text,
                );

                // Guardamos en la base de datos
                await _databaseService.addArticulo(articulo);
                
                // Regresamos a la pantalla de inicio
                if (mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Guardar Artículo',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}