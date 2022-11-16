import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calcule o seu IMC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(centerTitle: true),
      ),
      home: const MyHomePage(title: 'Calcule o seu IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _form = GlobalKey<FormState>();
  final _altura = TextEditingController();
  final _peso = TextEditingController();
  final _circunferencia = TextEditingController();
  late var imc;

  late int peso = 0;

  calcular() {
    if (_form.currentState!.validate()) {
      imc = double.parse(_peso.text) /
          double.parse(_altura.text) *
          double.parse(_altura.text);

      //Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: imc),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  'Índice de massa corporal (IMC)',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'O índice de massa corporal é uma medida internacional usada para calcular se uma pessoa está no peso ideal.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Text(
                  'A circunferência abdominal é outra medida importante para indicar possíveis problemas de saúde enfrentados por um indivíduo.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _altura,
                          style: TextStyle(fontSize: 22),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Altura',
                            prefixIcon: Icon(Icons.height),
                            suffix: Text(
                              'metros',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe sua altura';
                            } else if (double.parse(value) > 0) {
                              return 'Digite um valor maior que 0';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: TextFormField(
                            controller: _peso,
                            style: TextStyle(fontSize: 22),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Peso',
                              prefixIcon: Icon(Icons.scale),
                              suffix: Text(
                                'kg',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe seu peso';
                              } else if (peso > 0) {
                                return 'Digite um valor maior que 0';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                peso = value as int;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: TextFormField(
                            controller: _circunferencia,
                            style: TextStyle(fontSize: 22),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Circunferência da Cintura',
                              prefixIcon: Icon(Icons.person_pin),
                              suffix: Text(
                                'cm',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe a medida da circunferência abdominal';
                              } else if (double.parse(value) > 0.0) {
                                return 'Digite um valor maior que 0';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.only(top: 24),
                          child: ElevatedButton(
                            onPressed: calcular,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.calculate),
                                Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    'Calcular',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
