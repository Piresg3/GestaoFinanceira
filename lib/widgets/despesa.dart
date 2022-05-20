import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class Despesa extends StatefulWidget {
  Despesa({Key? key,required this.rowNumber, required this.callback}) : super(key: key);

  int rowNumber;
  Function callback;

  @override
  _DespesaState createState() => _DespesaState();
}

class _DespesaState extends State<Despesa> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.height,
      child: Card(
        color: Colors.red[200],
        child: Padding(
          padding: const EdgeInsets.all(0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(fontSize: 11),
                  keyboardType: TextInputType.text,
                  onChanged: (text) {
                    print(text);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Descrição',
                    labelStyle: TextStyle(fontSize: 10),
                  ),
                ),
              ),
              Text("R\$"),
              Expanded(
                child: TextField(
                  style: TextStyle(fontSize: 11),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    double val = 0.0;
                    try {
                      val = double.parse(text);
                    } catch (e) {
                    }
                    widget.callback(widget.rowNumber, val);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Valor',
                    labelStyle: TextStyle(fontSize: 11),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
