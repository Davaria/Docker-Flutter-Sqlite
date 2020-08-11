import 'package:flutter/material.dart';
import 'package:demo/database.dart';
import 'package:demo/edit_client.dart';
import 'package:demo/client.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cartera de clientes",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  String _searchText = "";

  List names = new List(); //names we get from the STarWars API

  List filteredNames = new List(); // Names filteed by search text

  Icon _searchIcon = new Icon(Icons.search);

  Widget _appBarTitle = new Text('Search Example');

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          // controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Search......'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Search Example');
        filteredNames = names;
        // _filter.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: _searchPressed,
        ),
        title: Text("Cartera de clientes"),
        actions: <Widget>[
          RaisedButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
              ClientDatabaseProvider.db.deleteAllClients();
              setState(() {});
            },
            child: Text(
              "Borrar todo",
              style: TextStyle(color: Colors.yellow),
            ),
          )
        ],
      ),
      body: FutureBuilder<List<Client>>(
        future: ClientDatabaseProvider.db.getAllClients(),
        builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Client item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    ClientDatabaseProvider.db.deleteClientWithId(item.id);
                  },
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text(item.email),
                    leading: CircleAvatar(child: Text(item.id.toString())),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditClient(
                                true,
                                client: item,
                              )));
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditClient(false)));
          }),
    );
  }
}
