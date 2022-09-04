import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Scaffold(
    body: ListaTransferencia(),
    appBar: AppBar(title: Text('Transferências'),),
    floatingActionButton: FloatingActionButton(
      onPressed: () {  },
      child: Icon(Icons.add),
    ),
  ),
));

class ListaTransferencia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemTrasnferencia(Transferencia(100.0,1000)),
        ItemTrasnferencia(Transferencia(200.0,2000)),
        ItemTrasnferencia(Transferencia(300.0,3000)),
        ItemTrasnferencia(Transferencia(400.0,4000)),
        ItemTrasnferencia(Transferencia(500.0,5000)),
        ItemTrasnferencia(Transferencia(600.0,6000)),
        ItemTrasnferencia(Transferencia(700.0,7000)),
      ],
    );
  }
}

class ItemTrasnferencia extends StatelessWidget{

  final Transferencia _transferencia;


  ItemTrasnferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
          leading: Icon(Icons.monetization_on),
          title: Text(_transferencia.valor.toString()),
          subtitle: Text(_transferencia.numeroConta.toString()),
        )
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);
}
