import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      //appBar: AppBar(

        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        //title: Text(widget.title),
      //),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('BROWSE CATEGORIES', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
            Padding( padding: EdgeInsets.all(16),child: Text(
              "Not Sure about exactly which recipe you're looking for? Do a search, or dive into our most popular categories",
              style: TextStyle(fontSize: 15),
            ),),
            Text('BY MEAT', style: TextStyle(fontSize: 30,  fontWeight: FontWeight.bold),),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Stack(alignment:AlignmentDirectional.center,
                children: <Widget>[
                CircleAvatar(backgroundImage: AssetImage('images/beef.jpg'), radius:35),
                  Text("BEEF", style: TextStyle(fontSize: 15.0, color: Colors.white ),),
                ]),
                Stack(alignment:AlignmentDirectional.center,
                    children: <Widget>[
                      CircleAvatar(backgroundImage: AssetImage('images/chicken.jpg'), radius:35),
                      Text("CHICKEN", style: TextStyle(fontSize: 15.0, color: Colors.white ),),
                    ]),
                Stack(alignment:AlignmentDirectional.center,
                    children: <Widget>[
                      CircleAvatar(backgroundImage: AssetImage('images/pork.jpg'), radius:35),
                      Text("PORK", style: TextStyle(fontSize: 15.0, color: Colors.white ),),
                    ]),
                Stack(alignment:AlignmentDirectional.center,
                    children: <Widget>[
                      CircleAvatar(backgroundImage: AssetImage('images/seafood.jpg'), radius:35),
                      Text("SEAFOOD", style: TextStyle(fontSize: 15.0, color: Colors.white ),),
                    ]),

            ],),
            Text('BY COURSE', style: TextStyle(fontSize: 30,  fontWeight: FontWeight.bold),),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                    children: <Widget>[
                      CircleAvatar(backgroundImage: AssetImage('images/maindishes.jpg'), radius:35),
                      Text("Main Dishes", style: TextStyle(fontSize: 15.0, color: Colors.black ),),
                    ]),
                Column(
                    children: <Widget>[
                      CircleAvatar(backgroundImage: AssetImage('images/salad.jpg'), radius:35),
                      Text("Salad Recipes", style: TextStyle(fontSize: 15.0, color: Colors.black ),),
                    ]),
                Column(
                    children: <Widget>[
                      CircleAvatar(backgroundImage: AssetImage('images/sideDishes.jpg'), radius:35),
                      Text("Side Dishes", style: TextStyle(fontSize: 15.0, color: Colors.black ),),
                    ]),
                Column(
                    children: <Widget>[
                      CircleAvatar(backgroundImage: AssetImage('images/crockpot.jpg'), radius:35),
                      Text("Crockpot", style: TextStyle(fontSize: 15.0, color: Colors.black ),),
                    ]),

              ],),
            Text('BY DESSERT', style: TextStyle(fontSize: 30,  fontWeight: FontWeight.bold),),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                    children: <Widget>[
                      CircleAvatar(backgroundImage: AssetImage('images/iceCream.jpg'), radius:35),
                      Text("Ice Cream", style: TextStyle(fontSize: 15.0, color: Colors.black ),),
                    ]),
                Column(
                    children: <Widget>[
                      CircleAvatar(backgroundImage: AssetImage('images/Brownies.jpg'), radius:35),
                      Text("Brownies", style: TextStyle(fontSize: 15.0, color: Colors.black ),),
                    ]),
                Column(
                    children: <Widget>[
                      CircleAvatar(backgroundImage: AssetImage('images/Pies.jpg'), radius:35),
                      Text("Pies", style: TextStyle(fontSize: 15.0, color: Colors.black ),),
                    ]),
                Column(
                    children: <Widget>[
                      CircleAvatar(backgroundImage: AssetImage('images/Cookies.jpg'), radius:35),
                      Text("Cookies", style: TextStyle(fontSize: 15.0, color: Colors.black ),),
                    ]),

              ],),
          ],
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
