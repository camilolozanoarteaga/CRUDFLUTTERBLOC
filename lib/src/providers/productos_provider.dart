import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:form_validator/src/models/producto_model.dart';

class ProductosProvider {

  final String _url = 'https://flutter-varios-a9126.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto) async {

    // como es con el API defirebase se debe poner Productos.json si es otro NO!
    final url = '$_url/Productos.json';
    final response = await http.post(url, body: productoModelToJson(producto));

    final decodedData = json.decode(response.body);

    print("=====RESPONSE===== $decodedData");

    return true;

  }

  Future<bool> editarProducto(ProductoModel producto) async {

    // como es con el API defirebase se debe poner Productos.json si es otro NO!
    final url = '$_url/Productos/${producto.id}.json';
    final response = await http.put(url, body: productoModelToJson(producto));

    final decodedData = json.decode(response.body);

    print("=====RESPONSE===== $decodedData");

    return true;

  }


  Future<List<ProductoModel>> cargarProductos() async {

    final url = '$_url/Productos.json';
    final response = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(response.body);
    final List<ProductoModel>  productos   = new List();

    if (decodedData==null) return [];

    decodedData.forEach(( id, producto) {
      final prodTemp = ProductoModel.fromJson(producto);
      prodTemp.id = id;

      productos.add(prodTemp);

    });

    // print(productos[0].id);

    return productos;

  }

  Future<int> borrarProducto(String id) async{

    final url      = '$_url/Productos/$id.json';
    final response = await http.delete(url);

    print(json.decode(response.body));

    return 1;

  }

}