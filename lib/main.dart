import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:listas/Estudiante.dart';
import 'package:listas/EstudianteService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

EstudianteService estudianteService = EstudianteService();

List<Estudiante> estu = [
  new Estudiante("brandon", "ugalde", "21"),
  new Estudiante("brayan", "ugalde", "21"),
  new Estudiante("axel", "bejarano", "21"),
];

List<String> list = ["brandon", "brayan", "axel"];

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas'),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                child: Text("Listas estaticas"),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => buildA()));
                },
                color: Colors.lightBlue,
              ),
              FlatButton(
                child: Text("Lista dinamica con datos primitivos"),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => buildB(list)));
                },
                color: Colors.lightBlue,
              ),
              FlatButton(
                child: Text("Lista dinamica con objetos"),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => buildC(estu)));
                },
                color: Colors.lightBlue,
              ),
              FlatButton(
                child: Text("Lista dinamica con firebase"),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => buildD()));
                },
                color: Colors.lightBlue,
              ),
              FlatButton(
                child: Text("Lista dinamica con firebase Y GridView"),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => buildE()));
                },
                color: Colors.lightBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildA() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            color: Colors.lightBlue,
            child: ListTile(
              title: Text('linea 1'),
            ),
          ),
          Card(
            color: Colors.lightBlue,
            child: ListTile(
              title: Text('linea 1'),
            ),
          ),
          Card(
            color: Colors.lightBlue,
            child: ListTile(
              title: Text('linea 1'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildB(List<String> list) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas dinamicas'),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.lightBlue,
            child: ListTile(
              title: Text(list[index]),
            ),
          );
        },
      ),
    );
  }

  Widget buildC(List<Estudiante> estu) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas dinamicas'),
      ),
      body: ListView.builder(
        itemCount: estu.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.lightBlue,
            child: ListTile(
              title: Text(estu[index].nombre + ' ' + estu[index].apellido),
              subtitle: Text(estu[index].edad),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildD() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estudiantes'),
      ),
      body: Center(
        child: FutureBuilder<List<Estudiante>>(
          future: estudianteService.get(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Estudiante>> snapshot) {
            if (snapshot.hasError) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    )
                  ]);
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: CircularProgressIndicator(),
                        width: 60,
                        height: 60,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Cargando'),
                      )
                    ]);
              default:
                final estudiante = snapshot.data;
                return ListView.builder(
                  itemCount: estudiante.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.lightBlue,
                      child: ListTile(
                        title: Text(estudiante[index].nombre +
                            ' ' +
                            estudiante[index].apellido),
                        subtitle: Text(estudiante[index].edad),
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget buildE() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas E'),
      ),
      body: Center(
        child: FutureBuilder<List<Estudiante>>(
          future: estudianteService.get(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Estudiante>> snapshot) {
            if (snapshot.hasError) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    )
                  ]);
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: CircularProgressIndicator(),
                        width: 60,
                        height: 60,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      )
                    ]);
              default:
                final estudiante = snapshot.data;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: estudiante.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        color: Colors.lightBlue,
                        child: ListTile(
                          title: Text(estudiante[index].nombre +
                              ' ' +
                              estudiante[index].apellido),
                          subtitle: Text(estudiante[index].edad),
                        ),
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
