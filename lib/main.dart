import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controllerFieldNumberAccount =
      TextEditingController();
  final TextEditingController _controllerFieldValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
      ),
      body: Column(children: [
        Editor(
            controller: _controllerFieldNumberAccount,
            rotulo: 'Número da conta',
            format: '0000'),
        Editor(
            controller: _controllerFieldValue,
            rotulo: 'Valor',
            format: '0.00',
            icon: Icons.monetization_on),
        ElevatedButton(
          child: Text('Confirmar'),
          onPressed: () => _criaTransferencia(),
        ),
      ]),
    );
  }

  void _criaTransferencia() {
    final int? numeroConta =
        int.tryParse(_controllerFieldNumberAccount.text);
    final double? campoValor =
        double.tryParse(_controllerFieldValue.text);
    if (numeroConta != null && campoValor != null) {
      final transferenciaCriada =
          Transferencia(campoValor, numeroConta);
      debugPrint('$transferenciaCriada');
    }
  }
}

class Editor extends StatelessWidget {

  final TextEditingController? controller;
  final String? rotulo;
  final String? format;
  final IconData? icon;

  Editor({this.controller, this.rotulo, this.format, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: 20.0,
        ),
        decoration: InputDecoration(
            icon: icon != null ? Icon(icon) : null,
            labelText: rotulo,
            hintText: format),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class TextoBotaoConfirmar {
  final String texto;

  TextoBotaoConfirmar(this.texto);
}

class ListaTransferencia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: Column(
        children: [
          ItemTransferencia(Transferencia(100.0, 1000)),
          ItemTransferencia(Transferencia(200.0, 2000)),
          ItemTransferencia(Transferencia(300.0, 3000)),
          ItemTransferencia(Transferencia(400.0, 4000)),
          ItemTransferencia(Transferencia(500.0, 5000)),
          ItemTransferencia(Transferencia(600.0, 6000)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.numeroConta.toString()),
    ));
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}
