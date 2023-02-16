import 'package:flutter/material.dart';
import 'package:med_task/model/get_table_model.dart';
import 'package:med_task/utils/ui_helper.dart';
import 'package:med_task/widgets/custom_button.dart';
import '../utils/globals.dart';
import '../utils/styles.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<GetTableModel> getTable = [];
  List<GetTable> tableCp = [];
  bool? isDrag= false;
  final TextEditingController _textCtl = TextEditingController();
  final TextEditingController _searchTextCtl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose(){
    _textCtl.dispose();
    _searchTextCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Globals.primary,
          title: Text('Trello Board',
          style: Styles.headingStyle4(
            isBold: true,
            color: Colors.white
          )),
          actions: [
            if(getTable.length >= 2)
            IconButton(
                onPressed: (){
                  for(int i = 0; i < getTable.length;i++){
                    for(int j = 0;j<getTable[i].list!.length;j++){
                      setState(() {
                        tableCp.add(getTable[i].list![j]);
                      });
                    }
                    setState(() {
                      getTable[i].list = [];
                    });
                  }
                  for(int i = 0; i < getTable.length;i++){
                    for(int j = 0;j < tableCp.length;j++){
                      setState(() {
                        if(getTable[i].tableId == tableCp[j].id){
                          getTable[i].list!.add(tableCp[j]);
                        }
                      });
                    }
                  }
                  setState(() {
                    tableCp = [];
                  });
                },
                icon: const Icon(Icons.refresh,
                size: 25,
                color: Colors.white)
            )
          ],
        ),
        body: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: getTable.length + 1,
          itemBuilder: (context, index) {
            if (index == getTable.length) {
              return addTableWidget(context);
            } else {
              return tableWidget(context, index);
            }
          },
        )
    );
  }

  Widget addTableWidget(context) {
    var kWidth = UiHelper.getSize(context).width;
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            showPopup(isCard: true);
          },
          child: Container(
            width: kWidth * 0.7,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    blurRadius: 8,
                    offset: Offset(0, 0),
                    color: Color.fromRGBO(127, 140, 141, 0.5),
                    spreadRadius: 2)
              ],
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.add,
                ),
                SizedBox(
                  width: kWidth * 0.04,
                ),
                Text("Add Table",
                style: Styles.headingStyle5(
                  isBold: true
                )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  showPopup({bool? isCard,int? index}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    isCard! ? "Add Table Title" : "Add Table Item",
                    style: Styles.headingStyle3(),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _textCtl,
                      decoration: Styles.requestFormFieldStyle(
                        labelText: isCard ? "Enter Table Title" :"Enter Table Item Name",
                      ),
                      validator: (value) {
                        return value!.isNotEmpty ? null
                            : isCard
                            ? "Invalid Table Title!"
                            : "Invalid Table Item Name!";
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                CustomButton(
                  padding: 70,
                  text: "SUBMIT",
                  onTap: (){
                    if (_formKey.currentState!.validate()) {
                      if(isCard == true){
                        setState(() {
                          getTable.add(
                              GetTableModel(tableId: getTable.length + 1,title: _textCtl.text.trim(),list: [])
                          );
                          _textCtl.text = "";
                        });
                      }else{
                        setState(() {
                          getTable[index!].list!.add(
                              GetTable(id: index + 1,name: _textCtl.text.trim())
                          );
                          _textCtl.text = "";
                        });
                      }
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Widget tableWidget(BuildContext context, int index) {
    var kHeight = UiHelper.getSize(context).height;
    var kWidth = UiHelper.getSize(context).width;
    return DragTarget<GetTable>(
      builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected){
        return Container(
          width: 300.0,
          height: kHeight ,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  blurRadius: 8,
                  offset: Offset(0, 0),
                  color: Color.fromRGBO(127, 140, 141, 0.5),
                  spreadRadius: 1)
            ],
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          margin: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getTable[index].title!,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                        onTap: (){
                          setState(() {
                            setState(() {
                              getTable.remove(getTable[index]);
                            });
                          });
                        },
                        child: const Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                          size: 20,
                        ))
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
                color: Colors.blueGrey,
              ),
              if(getTable[index].list!.length >= 2)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                child: TextFormField(
                  controller: _searchTextCtl,
                  decoration: Styles.requestFormFieldStyle(
                    labelText:  "Search items",
                  ),
                  onChanged: (value){
                    setState(() {
                      getTable[index].list = getTable[index].list!.where((e) {
                         return e.name!.toLowerCase().contains(value.toLowerCase());
                      }
                      ).toList();
                    });
                  },
                ),
              ),
              Flexible(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: getTable[index].list!.length,
                      itemBuilder: (context , i){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Draggable<GetTable>(
                            childWhenDragging: const SizedBox(height: 0),
                            data: getTable[index].list![i],
                            onDragStarted: () {
                              setState(() {});
                            },
                            onDraggableCanceled: (velocity, offset) {
                              setState(() {});
                            },
                            onDragCompleted: (){
                              setState(() {
                                getTable[index].list!.remove(getTable[index].list![i]);
                              });
                            },
                            feedback: Stack(
                              children: [
                                SizedBox(
                                  width : kWidth * 0.6,
                                  child: Card(
                                    color: Colors.grey.shade200,
                                    elevation : 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(getTable[index].list![i].name!),
                                          const Icon(Icons.delete,color:Colors.red,size: 18,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                SizedBox(
                                  width : kWidth * 0.6,
                                  child: Card(
                                    color: Colors.grey.shade200,
                                    elevation : 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(getTable[index].list![i].name!),
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                getTable[index].list!.remove(getTable[index].list![i]);
                                              });
                                            },
                                           child: const Icon(Icons.delete,color:Colors.red,size: 18,))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      showPopup(isCard: false,index: index);
                    },
                    child: Row(
                      children:  <Widget>[
                        const Icon(
                          Icons.add,
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Text("Add Table Items",
                            style: Styles.headingStyle5(
                                isBold: true
                            )),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
      onAccept: (data) {
        setState(() {
          getTable[index].list!.add(data);
        });
        isDrag = false;
        setState(() {
        });
      },
    );
  }
}