import 'package:flutter/material.dart';

void main() {
  runApp(MyBankApp());
}

class MyBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplicação Bancária',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: BankTransactionPage(),
    );
  }
}

class BankTransactionPage extends StatefulWidget {
  @override
  _BankTransactionPageState createState() => _BankTransactionPageState();
}

class _BankTransactionPageState extends State<BankTransactionPage> {
  final List<Map<String, dynamic>> _transactions = []; 
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void _addTransaction() {
    if (_typeController.text.isNotEmpty && _amountController.text.isNotEmpty) {
      setState(() {
        _transactions.add({
          'type': _typeController.text,
          'amount': double.tryParse(_amountController.text),
        });
      });
      _typeController.clear();
      _amountController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transações Bancárias'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
       
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _typeController,
              decoration: InputDecoration(
                labelText: 'Tipo de Transação (Depósito/Retirada)',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Valor',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          ElevatedButton(
            onPressed: _addTransaction,
            child: const Text('Adicionar Transação'),
          ),
          const SizedBox(height: 20),
          const Text(
            'Transações Realizadas:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
       
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _transactions.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  title: Text('Tipo: ${_transactions[index]['type']}'),
                  subtitle: Text('Valor: R\$ ${_transactions[index]['amount']?.toStringAsFixed(2)}'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
