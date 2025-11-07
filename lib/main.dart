import 'package:flutter/material.dart';
import 'Item.dart';
import 'ItemDAO.dart';
import 'ItemDatabase.dart';

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
  List<Item> list1 = [];
  bool hasAdd = false;
  var list2 = <String>[];
  late TextEditingController _controllerType;
  late TextEditingController _controllerNum;
  late ItemDAO itemDAO;

  @override
  void initState() {
    super.initState();
    _controllerType = TextEditingController();
    _controllerNum = TextEditingController();//doing your promise to initialize
    //want to load any existing data into the arraylist
    //to open the database:

    $FloorItemDatabase.databaseBuilder('ItemFile.db').build()
        .then( (database){
      itemDAO = database.myDAO;

      //query all data:
      itemDAO.getAllItems().then( (listOfItems ) {
        setState(() { //redraw the GUI
          list1.addAll(listOfItems);
          //put the items in the list:
        });
      });
    }  );
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
      body: ListPage(),


    );
  }
  Widget ListPage()
  {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row( mainAxisAlignment: MainAxisAlignment.spaceAround, children:[
            Flexible( flex:4, child:TextField(controller: _controllerType,
              decoration: InputDecoration(
                hintText: "Type the item here",
                border: OutlineInputBorder(),
              ) ,
            )
            ),
            Flexible( flex:4, child:TextField(controller: _controllerNum,
            decoration: InputDecoration(
              hintText: "Type the quantity here",
              border: OutlineInputBorder(),
            ),)),
            Flexible(
                flex:2,
                child: ElevatedButton( child:Text("Click here"), onPressed:() async{
                  Item newItem = Item(Item.ID++, _controllerType.value.text, int.parse(_controllerNum.value.text));

                  await itemDAO.insertItem(newItem);//insert to database
                  setState(() {

                    list1.add(newItem);
                    _controllerType.text = "";

                    _controllerNum.text = "";
                    hasAdd = true;

                  });
                } )

            ),


          ])
         ,

          Expanded(child:
            list1.isEmpty
            ?(hasAdd
            ?Center(child: Text("There are no items in the list"))
                : Container())

          :ListView.builder(
              itemCount: list1.length,
              itemBuilder:(context, rowNum) =>
                  GestureDetector(child:Container(
                    alignment: Alignment.center,
                    child: Text("${rowNum+1} ${list1[rowNum].name} quantity: ${list1[rowNum].quantity}") ,
                    ),
                      onLongPress: () {


                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Delete this?'),
                                content: const Text('are you sure?'),
                                actions: <Widget>[
                                  FilledButton(child:Text("Yes"), onPressed:() async{
                                    Item targetItem = list1[rowNum];
                                    await itemDAO.deleteItem(targetItem);//delete to database
                                    setState(() {
                                      list1.removeAt(rowNum);


                                    });

                                    Navigator.pop(context);
                                  }),
                                  FilledButton(child:Text("No"), onPressed:() {
                                    Navigator.pop(context);

                                  }),
                                ],
                              )
                          );

                      })
          )
          )
        ]);
  }
}
