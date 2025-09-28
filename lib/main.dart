import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  var _counter = 0.0;
  var myFontSize = 30.0;
  var passValue;
  var fileToShow = "images/question-mark.png";
  late TextEditingController _controllerlogin;
  late TextEditingController _controllerpass;

  @override
  void initState() {
    super.initState();
    _controllerlogin = TextEditingController();
    _controllerpass = TextEditingController();
    Future.delayed(Duration.zero,  () async {
      var prefs = EncryptedSharedPreferences();//await SharedPreferences.getInstance();


      //Encrypted, this is async:
      var str = await prefs.getString("MyUserString"); //Use the same variable as in setString()
      var str2 = await prefs.getString("MyPasswordString");
      //put back onto page:
      if(str != null && str2 != null) {
        _controllerlogin.text = str;
        _controllerpass.text = str2;
      }
      //this is the snackbar:
      var snackBar = SnackBar(
          content: Text('the previous login name and passwords have been loaded'),

      );

      //this line shows it: context is the page
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    });
  }

  @override
  void dispose() {
    _controllerlogin.dispose();
    _controllerpass.dispose();
    super.dispose();
  }

  void buttonClicked() {
    setState(() {
      passValue = _controllerpass.value.text;
    }
    );
    setState(() {
      if (passValue == "QWERTY123") {
        fileToShow = "images/idea.png";
      }
      else
        fileToShow = "images/stop.png";
    });
    showDialog<String>(context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Alert!!"),
              content: Text(
                  "Do you really want to save your username and password?"),
              actions: [
                OutlinedButton(child: Text("Yes"), onPressed:
                    () async
                {
                  var prefs = EncryptedSharedPreferences(); //await SharedPreferences.getInstance(); //async, we must wait
                  //Key is the variable name ,     //what the user typed:

                  await prefs.setString(
                      "MyUserString", _controllerlogin.value.text);
                  await prefs.setString(
                      "MyPasswordString", _controllerpass.value.text);
                  Navigator.pop(context); //hide the dialog
                }),
                OutlinedButton(child: Text("No"), onPressed: () {
                  var prefs = EncryptedSharedPreferences();

                  prefs.clear();
                  Navigator.pop(context);
                }),
                OutlinedButton(child: Text("Clear data"), onPressed: () {
                  var prefs = EncryptedSharedPreferences();

                  prefs.clear(); //deletes all data

                  Navigator.pop(context);
                }),

              ]);
        });
  }
    void _incrementCounter() {
      setState(() {
        if (myFontSize < 99.0)
          myFontSize++;
      });
    }
    void setNewValue(double newValue) {
      setState(() {
        myFontSize = newValue;
      });
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(

          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[


              TextField(controller: _controllerlogin,
                  decoration: InputDecoration(
                    hintText: "Login",
                    border: OutlineInputBorder(),

                  )),
              TextField(controller: _controllerpass,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(),

                  )),
              ElevatedButton(
                  onPressed: buttonClicked, style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
              ), child: Text("Login",)),
              Semantics(label: "question mark or bulb mark or stop mark ,",
                  child: Image.asset(fileToShow, width: 200, height: 200))
            ],

          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    }
  }
