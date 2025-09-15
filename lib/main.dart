import 'package:flutter/material.dart';

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
  }

  @override
  void dispose() {
    _controllerlogin.dispose();
    _controllerpass.dispose();
    super.dispose();
  }

  void buttonClicked(){
    setState(() {
      passValue = _controllerpass.value.text;
    }
    );
    setState(() {
      if (passValue == "QWERTY123") {
        fileToShow = "images/idea.png";
      }
      else fileToShow = "images/stop.png";
    });;

  }
  void _incrementCounter() {
    setState(() {
      if (myFontSize <99.0)
      myFontSize++;
    });
  }
  void setNewValue(double newValue)
  {
    setState(() {

       myFontSize = newValue;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            TextField(controller: _controllerlogin,
                decoration: InputDecoration(
                    hintText:"Login",
                    border: OutlineInputBorder(),

                )),
            TextField(controller: _controllerpass,
                obscureText: true,
                decoration: InputDecoration(
                    hintText:"Password",
                    border: OutlineInputBorder(),

                )),
            ElevatedButton( onPressed: buttonClicked,style: ElevatedButton.styleFrom(
              foregroundColor: Colors.blue,
            ), child:  Text("Login",)  ),
           Semantics( label: "question mark or bulb mark or stop mark ,", child: Image.asset(fileToShow, width: 200, height:200)) ],

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
