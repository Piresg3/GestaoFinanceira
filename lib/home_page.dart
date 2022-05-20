import 'package:controle_financeiro/widgets/botao.dart';
import 'package:flutter/material.dart';
import 'widgets/despesa.dart';
import 'widgets/receita.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

String totalReceita = "0.00";
String totalDespesa = "0.00";
int totalRowReceita = 0;
int totalRowDespesa = 0;
List<double> valorLinhaReceita = [];
List<double> valorLinhaDespesa = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Row(children: [SizedBox(height: 20,)],),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child:Image.asset('assets/images/fatec.png',
                    height: 170,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(                  
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.48,
                    color: Colors.white38,
                    alignment: Alignment.center,
                    child: Text(
                      "Receita R\$"+totalReceita,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                  ),
                  Container(                  
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.48,
                    color: Colors.white38,
                    alignment: Alignment.center,
                    child: Text(
                      "Despesa R\$"+totalDespesa,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                  ),
                ],
              ),
              Row(children: [SizedBox(height: 10,)],),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.48,
                    height: MediaQuery.of(context).size.height * 0.5,
                    color: Colors.white10,
                    child: ListView(
                      padding: EdgeInsets.all(0.1),
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        for (int i = 0; i < totalRowReceita; ++i)
                        Receita(
                          rowNumber: i,
                          callback: _atualizaValorLinhaReceita,
                          )
                      ]
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.48,
                    height: MediaQuery.of(context).size.height * 0.5,
                    color: Colors.white10,
                    child: ListView(
                      padding: EdgeInsets.all(0.1),
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        for (int i = 0; i < totalRowDespesa; ++i)
                        Despesa(
                          rowNumber: i,
                          callback: _atualizaValorLinhaDespesa,
                          )
                      ]
                    ),
                  )
                ],
              ),
              Row(children: [SizedBox(height: 25,)],),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Botao(
                    icon: Icons.north_rounded,
                    text: "Receita",
                    cor: Colors.green,
                    onPressed: _addRowReceita,
                  ),              
                  Botao(
                    icon: Icons.south_rounded,
                    text: "Gastos",
                    cor: Colors.red,
                    onPressed: _addRowDespesa,               
                  ),
                ]
              ),
              Row(children: [SizedBox(height: 10,)],),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Botao(
                    icon: Icons.delete, 
                    text: "Excluir",
                    cor: Colors.blue,
                    onPressed: deletaLinhaReceita,
                  ),
                  Botao(
                    icon: Icons.delete, 
                    text: "Excluir",
                    cor: Colors.blue,
                    onPressed: deletaLinhaDespesa,
                  )       
                ]
              ),           
            ]    
          ),
        ),
      ),
    );
  }

  void _addRowReceita() {
    setState(() {
      totalRowReceita += 1;
      valorLinhaReceita.add(0);
    });
  }

  void _addRowDespesa() {
    setState(() {
      totalRowDespesa += 1;
      valorLinhaDespesa.add(0);
    });
  }

  void _atualizaTotalReceita() {
    setState(() {
      double somaTotal = valorLinhaReceita.length > 0
          ? valorLinhaReceita.reduce((value, element) => value + element)
          : 0;

      if (somaTotal > 0.0) {
        totalReceita = somaTotal.toStringAsFixed(2);
      } else {
        totalReceita = "0.00";
      }
    });
  }

  void _atualizaTotalDespesa() {
    setState(() {
      double somaTotal = valorLinhaDespesa.length > 0
          ? valorLinhaDespesa.reduce((value, element) => value + element)
          : 0;

      if (somaTotal > 0.0) {
        totalDespesa = somaTotal.toStringAsFixed(2);
      } else {
        totalDespesa = "0.00";
      }
    });
  }  

  void _atualizaValorLinhaReceita(int rowNum, double newVal) {
    setState(() {
      if (valorLinhaReceita.length > rowNum) {
        valorLinhaReceita[rowNum] = newVal;
      }
    });
    _atualizaTotalReceita();
  }

  void _atualizaValorLinhaDespesa(int rowNum, double newVal) {
    setState(() {
      if (valorLinhaDespesa.length > rowNum) {
        valorLinhaDespesa[rowNum] = newVal;
      }
    });
    _atualizaTotalDespesa();
  }

  void deletaLinhaReceita() {
    setState(() {
      int newTotalRow = totalRowReceita - 1;
      totalRowReceita = newTotalRow < 0 ? 0 : newTotalRow;
      if (valorLinhaReceita.isNotEmpty) {
        valorLinhaReceita.removeLast();
      }
    });

    _atualizaTotalReceita();
  }

  void deletaLinhaDespesa() {
    setState(() {
      int newTotalRow = totalRowDespesa - 1;
      totalRowDespesa = newTotalRow < 0 ? 0 : newTotalRow;
      if (valorLinhaDespesa.isNotEmpty) {
        valorLinhaDespesa.removeLast();
      }
    });

    _atualizaTotalDespesa();
  }

}




