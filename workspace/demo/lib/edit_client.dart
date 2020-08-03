import 'package:flutter/material.dart';
import 'package:demo/database.dart';
import 'package:demo/client.dart';

class EditClient extends StatefulWidget {
  final bool edit;
  final Client client;

  EditClient(this.edit, {this.client}) : assert(edit == true || client == null);

  @override
  _EditClientState createState() => _EditClientState();
}

class _EditClientState extends State<EditClient> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController directionEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.edit == true) {
      nameEditingController.text = widget.client.name;
      directionEditingController.text = widget.client.direction;
      emailEditingController.text = widget.client.email;
      phoneEditingController.text = widget.client.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.edit ? "Editar Clienta" : "Añadir Cliente"),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlutterLogo(
                    size: 300,
                  ),
                  textFormField(
                      nameEditingController,
                      "Nombre",
                      "Ingresa tu nombre",
                      Icons.person,
                      widget.edit ? widget.client.name : "s"),
                  textFormField(
                      directionEditingController,
                      "Direccion",
                      "Ingresa direccion",
                      Icons.place,
                      widget.edit ? widget.client.direction : "jk"),
                  textFormField(
                      emailEditingController,
                      "Email",
                      "Ingresa email",
                      Icons.email,
                      widget.edit ? widget.client.email : "jk"),
                  textFormField(
                      phoneEditingController,
                      "Telefono",
                      "Añade telefono",
                      Icons.phone,
                      widget.edit ? widget.client.phone : "jk"),
                  RaisedButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Guardar",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (!_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Procesando data')));
                      } else if (widget.edit == true) {
                        ClientDatabaseProvider.db.updateClient(new Client(
                            name: nameEditingController.text,
                            direction: directionEditingController.text,
                            email: emailEditingController.text,
                            phone: phoneEditingController.text,
                            id: widget.client.id));
                        Navigator.pop(context);
                      } else {
                        await ClientDatabaseProvider.db
                            .addClientToDatabase(new Client(
                          name: nameEditingController.text,
                          direction: directionEditingController.text,
                          email: emailEditingController.text,
                          phone: phoneEditingController.text,
                        ));
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }

  textFormField(TextEditingController t, String label, String hint,
      IconData iconData, String initialValue) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Ingresa algun texto';
          }
        },
        controller: t,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            prefixIcon: Icon(iconData),
            hintText: hint,
            labelText: label,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
