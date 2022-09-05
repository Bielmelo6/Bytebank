import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: TransferList(),
      ),
    );
  }
}

class TransferForm extends StatelessWidget {
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
            lable: 'Número da conta',
            format: '0000'),
        Editor(
            controller: _controllerFieldValue,
            lable: 'Valor',
            format: '0.00',
            icon: Icons.monetization_on),
        ElevatedButton(
          child: Text('Confirmar'),
          onPressed: () => _createTransfer(context),
        ),
      ]),
    );
  }

  void _createTransfer(BuildContext context) {
    final int? numeroConta = int.tryParse(_controllerFieldNumberAccount.text);
    final double? campoValor = double.tryParse(_controllerFieldValue.text);
    if (numeroConta != null && campoValor != null) {
      final transferenciaCriada = Transfer(campoValor, numeroConta);
      Navigator.pop(context, transferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController? controller;
  final String? lable;
  final String? format;
  final IconData? icon;

  Editor({this.controller, this.lable, this.format, this.icon});

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
            labelText: lable,
            hintText: format),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class TransferList extends StatefulWidget {
  final List<Transfer> _transfers = [];

  @override
  State<StatefulWidget> createState() {
    return TransferListState();
  }
}

class TransferListState extends State<TransferList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: ListView.builder(
        itemCount: widget._transfers.length,
        itemBuilder: (context, index) {
          final transferencia = widget._transfers[index];
          return TransferItem(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future future = Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TransferForm()
              ));
          future.then((transferReceived) {
            debugPrint('Entrou');
            debugPrint('$transferReceived');
            setState((){
              widget._transfers.add(transferReceived);
            });
          });
        },
      ),
    );
  }
}

class TransferItem extends StatelessWidget {
  final Transfer _transfer;

  TransferItem(this._transfer);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_transfer.value.toString()),
      subtitle: Text(_transfer.accountNumber.toString()),
    ));
  }
}

class Transfer {
  final double value;
  final int accountNumber;

  Transfer(this.value, this.accountNumber);

  @override
  String toString() {
    return 'Transferencia{valor: $value, numeroConta: $accountNumber}';
  }
}
