import 'package:flutter/material.dart';
import 'package:todoapp/database.dart';

class focustask extends StatefulWidget {
  @override
  _todouiState createState() => _todouiState();
}

class _todouiState extends State<focustask> {
  final dbhelper = Databasehelper.instance;


  bool validated = true;
  String errtext = "";
  String todoedited = "";
  var myitems = List();
  List<Widget> children = new List<Widget>();

  void addtodo() async {
    Map<String, dynamic> row = {
      Databasehelper.columnName: todoedited,
    };
    final id = await dbhelper.insert(row);
    Navigator.pop(context);
    todoedited = "";
    setState(() {
    });
  }

  Future<bool> query() async {
    myitems = [];
    children = [];
    var allrows = await dbhelper.queryall();
    allrows.forEach((row) {
      myitems.add(row.toString());
      children.add(
          Card(
             elevation: 10.0,
             margin: EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 4.0,
             ),
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: ListTile(

            title: Text(
              row['todo'],
              style: TextStyle(
                fontSize: 20.0,

              ),
            ),
            leading: new Icon(Icons.delete, color: Color(0xFF4CB2C6),size: 28.0,
            ),
            onLongPress: () {
              dbhelper.deletedata(row['id']);
              setState(() {});
            },
          ),

        ),
      )
      );
    });
    return Future.value(true);
  }

  void popup() {

    bool value=true;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: Text(
                "ADD TASK",
                style: TextStyle(
                  color:Color(0xFF03989E),
                ),

              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  TextField(
                    onChanged: (_val) {
                      todoedited = _val;
                    },
                    style: TextStyle(
                      fontSize: 23.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            addtodo();
                          },
                          color: Color(0xFF03989E),
                          child: Text(
                              "ADD",
                              style: TextStyle(
                                color:Colors.white,
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snap) {

        {
          if (myitems.length == 0) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: popup,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Color(0xFF03989E),
              ),
              drawer: Drawer(
                child:Column(
                  children: [
                    DrawerHeader(
                      child: Container(
                      color:Color(0xFF4CB2C6),
                    ),
                    ),
                    ListTile(
                      leading: Icon(Icons.account_circle_rounded,color:Colors.black),
                      title:Text('MY PROFIL'),
                    ),
                    ListTile(
                      leading: Icon(Icons.add_alarm,color:Colors.black),
                      title:Text('TIMER'),
                    ),
                  ],
                )
              ),
              appBar: AppBar(
                titleSpacing: 30,
                shadowColor: Colors.white,
                actions: <Widget>[
                  Icon(Icons.mail, size: 30,color:Colors.white),
                ],
                backgroundColor: Color(0xFF03989E),
                centerTitle: true,
                title: Text(
                  " FocusTask ",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              body: Center(
                child: Text(
                  "LET'S ADD TASK",
                  style: TextStyle( fontSize: 20.0,color: Color(0xFF03989E)),
                ),
              ),
            );
          } else {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: popup,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Color(0xFF03989E),
              ),
              drawer: Drawer(
                child:Column(
                  children: [
                    DrawerHeader(
                      child: Container(
                      color:Color(0xFF4CB2C6),
                    ),
                    ),
                    ListTile(
                      leading: Icon(Icons.account_circle_rounded,color:Colors.black),
                      title:Text('MY PROFIL'),
                    ),
                    ListTile(
                      leading: Icon(Icons.add_alarm,color:Colors.black),
                      title:Text('TIMER'),
                    ),
                  ],
                )
              ),
              appBar: AppBar(
                titleSpacing: 30,
                backgroundColor: Color(0xFF03989E),
                centerTitle: true,
                shadowColor: Colors.white,
                actions: <Widget>[

                  Icon(Icons.arrow_forward, size: 30,color:Colors.white),
                ],
                title: Text(
                  " FocusTask ",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              backgroundColor: Color(0xF5F0FFFF),
              body: SingleChildScrollView(
                child: Column(
                  children: children,
                ),
              ),
            );
          }
        }
      },
      future: query(),
    );
  }
}
