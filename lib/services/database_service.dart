import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modelo_ar/models/QR.dart';
import 'package:modelo_ar/models/articulos.dart';
import 'package:modelo_ar/models/articulos_usuarios.dart';
import 'package:modelo_ar/models/categorias.dart';
import 'package:modelo_ar/models/usuarios.dart';

const String USUARIOS_COLLECTION_REF = 'usuarios';
const String ARTICULOS_COLLECTION_REF = 'articulos';
const String CATEGORIAS_COLLECTION_REF = 'categorias';
const String ARTICULOS_USUARIOS_COLLECTION_REF = 'articulos_usuarios';
const String QRS_COLLECTION_REF = 'qrs';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late final CollectionReference<Usuarios> _usuariosRef;
  late final CollectionReference<Articulos> _articulosRef;
  late final CollectionReference<categoriaArt> _categoriasRef;
  late final CollectionReference<ArticulosUsuarios> _articulosUsuariosRef;
  late final CollectionReference<QR> _qrsRef;

  DatabaseService() {
    _usuariosRef = _firestore.collection(USUARIOS_COLLECTION_REF).withConverter<Usuarios>(
      fromFirestore: (snapshot, _) => Usuarios.fromJson(snapshot.data()!),
      toFirestore: (usuario, _) => usuario.toJson(),
    );

    _articulosRef = _firestore.collection(ARTICULOS_COLLECTION_REF).withConverter<Articulos>(
      fromFirestore: (snapshot, _) => Articulos.fromJson(snapshot.data()!),
      toFirestore: (articulo, _) => articulo.toJson(),
    );

    _categoriasRef = _firestore.collection(CATEGORIAS_COLLECTION_REF).withConverter<categoriaArt>(
      fromFirestore: (snapshot, _) => categoriaArt.fromJson(snapshot.data()!),
      toFirestore: (categoria, _) => categoria.toJson(),
    );

    _articulosUsuariosRef = _firestore.collection(ARTICULOS_USUARIOS_COLLECTION_REF).withConverter<ArticulosUsuarios>(
      fromFirestore: (snapshot, _) => ArticulosUsuarios.fromJson(snapshot.data()!),
      toFirestore: (articulosUsuarios, _) => articulosUsuarios.toJson(),
    );

    _qrsRef = _firestore.collection(QRS_COLLECTION_REF).withConverter<QR>(
      fromFirestore: (snapshot, _) => QR.fromJson(snapshot.data()!),
      toFirestore: (qr, _) => qr.toJson(),
    );
  }

  Stream<List<Usuarios>> usuariosStream() {
    return _usuariosRef.snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }

  Stream<List<Articulos>> articulosStream() {
    return _articulosRef.snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }

  Stream<List<categoriaArt>> categoriasStream() {
    return _categoriasRef.snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }

  Stream<List<ArticulosUsuarios>> articulosUsuariosStream() {
    return _articulosUsuariosRef.snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }

  Future<DocumentReference<Usuarios>> addUsuario(Usuarios usuario) async {
    return await _usuariosRef.add(usuario);
  }

  Future<DocumentReference<Articulos>> addArticulo(Articulos articulo) async {
    return await _articulosRef.add(articulo);
  }

  Future<DocumentReference<categoriaArt>> addCategoria(categoriaArt categoria) async {
    return await _categoriasRef.add(categoria);
  }

  Future<DocumentReference<ArticulosUsuarios>> addArticuloUsuario(ArticulosUsuarios articuloUsuario) async {
    return await _articulosUsuariosRef.add(articuloUsuario);
  }

  Future<DocumentReference<QR>> createQrForArticulo(String articuloId) async {
    final qr = QR(articuloId: articuloId);
    return await _qrsRef.add(qr);
  }

  Future<QR?> getQrById(String documentId) async {
    final snapshot = await _qrsRef.doc(documentId).get();
    return snapshot.data();
  }

  Future<Articulos?> getArticuloById(String documentId) async {
    final snapshot = await _articulosRef.doc(documentId).get();
    return snapshot.data();
  }

  Future<Usuarios?> getUsuarioById(String documentId) async {
    final snapshot = await _usuariosRef.doc(documentId).get();
    return snapshot.data();
  }

  static const String qrPrefix = 'modelo_ar://articulo/';

  static String getQrContentForArticulo(String articuloId) {
    return '$qrPrefix$articuloId';
  }

  static String? articuloIdFromQr(String code) {
    if (code.startsWith(qrPrefix)) {
      return code.substring(qrPrefix.length);
    }
    if (code.startsWith('articulo:')) {
      return code.substring('articulo:'.length);
    }
    return null;
  }

  void updateUsuario(String documentId, Usuarios usuario) {
    _usuariosRef.doc(documentId).update(usuario.toJson());
  }

  void updateArticulo(String documentId, Articulos articulo) {
    _articulosRef.doc(documentId).update(articulo.toJson());
  }

  void updateCategoria(String documentId, categoriaArt categoria) {
    _categoriasRef.doc(documentId).update(categoria.toJson());
  }
}
