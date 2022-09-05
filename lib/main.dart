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

  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _controladorCampoNumeroConta,
            style: TextStyle(
              fontSize: 20.0,
            ),
            decoration:
                InputDecoration(labelText: 'Número da conta', hintText: '0000'),
            keyboardType: TextInputType.number,
          ),
        ),
        TextField(
          controller: _controladorCampoValor,
          style: TextStyle(fontSize: 20.0),
          decoration: InputDecoration(
              icon: Icon(Icons.monetization_on),
              labelText: 'Valor',
              hintText: '0.00'),
        ),
        ElevatedButton(
          child: Text('Confirmar'),
          onPressed: () {
            debugPrint('clicou no confirmar');
            final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
            final double? campoValor = double.tryParse(_controladorCampoValor.text);
            if(numeroConta != null && campoValor != null) {
              final transferenciaCriada = Transferencia(campoValor, numeroConta);
              debugPrint('$transferenciaCriada');
            }
          },
        ),
      ]),
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
