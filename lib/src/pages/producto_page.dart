import 'package:flutter/material.dart';
import 'package:form_validator/src/models/producto_model.dart';
import 'package:form_validator/src/providers/productos_provider.dart';
import 'package:form_validator/src/utils/utils.dart' as util;

class PruductoPage extends StatefulWidget {
  @override
  _PruductoPageState createState() => _PruductoPageState();
}

class _PruductoPageState extends State<PruductoPage> {

  ProductoModel productoModel = new ProductoModel();

  final keyForm = GlobalKey<FormState>();
  final productoProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {

    // obteber los parametros enviados desde la navegación
    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;

    if(prodData != null) {
      productoModel = prodData;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: (){},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: keyForm,
            child: Column(
              children: <Widget>[
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {

    return TextFormField(
      initialValue: productoModel.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
      onSaved: (value) => productoModel.titulo = value,
      validator: (value){
        if(value.length < 3) {
          return 'Ingrese un nombre valido';
        } else {
          return null;
        }
      },
    );

  }

  Widget _crearPrecio() {

    return TextFormField(
      initialValue: productoModel.valor.toString(),
      // keyboardType: TextInputType.number,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      onSaved: (value) => productoModel.valor = double.parse(value),
      validator: (value){
        if (util.isNumeric(value)) {
          return null;
        } else {
          return 'Se admite solo números';
        }
      },
    );

  }

  Widget _crearDisponible() {

    return SwitchListTile(
      value: productoModel.disponible,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState((){
        productoModel.disponible = value;
      }),
    );

  }

  Widget _crearBoton() {

    return RaisedButton.icon(
      icon: Icon(Icons.save),
      onPressed: _submit,
      label: Text('Guardar'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      textColor: Colors.white,
      color: Colors.deepPurple,
    );

  }

  void _submit(){

    if (!keyForm.currentState.validate()) return;

    keyForm.currentState.save();


    if(productoModel.id == null) {
      productoProvider.crearProducto(productoModel);
    } else {
      productoProvider.editarProducto(productoModel);
    }

    print('ok');
    print(productoModel.titulo);
    print(productoModel.valor);
    print(productoModel.disponible);


  }

}