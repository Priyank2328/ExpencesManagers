import 'package:expencesmanagers/ManagersRegistered.dart';
import 'package:expencesmanagers/UpdateDataProject.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import ' helpers/DatabaseHelpers.dart';
class ShowDetails extends StatefulWidget {
  @override
  State<ShowDetails> createState() => _ShowDetailsState();
}
class _ShowDetailsState extends State<ShowDetails> {
  Future<List> alldata;

  Future<List> getdata() async
  {
    DatabaseHelpers obj = new DatabaseHelpers();
    var data = await obj.expencesview();
    return data;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      alldata = getdata();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Expences Details")),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>ManagersRegistered())
            );
          },
          label: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: alldata,
        builder: (context,snapshot)
        {
          if(snapshot.hasData)
          {
            if(snapshot.data.length<=0)
            {
              return Center(child: Text("No Data"));
            }
            else
            {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context,index)
                {
                  return Container(
                    margin: EdgeInsets.all(15.0),
                    child: Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(snapshot.data[index]["title"].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                          ),
                          SizedBox(height: 20.0,),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(snapshot.data[index]["remark"].toString(),style: TextStyle(color: Colors.grey,fontSize: 20.0),),
                          ),
                          SizedBox(height: 20.0,),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(snapshot.data[index]["date"].toString(),style: TextStyle(fontSize: 20.0),),
                          ),
                          SizedBox(height: 20.0,),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(snapshot.data[index]["amt"].toString(),style: TextStyle(fontSize: 20.0),),
                          ),
                          SizedBox(height: 20.0,),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(snapshot.data[index]["type"].toString(),style: TextStyle(fontSize: 20.0),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 28.0),
                            child: ElevatedButton(
                                onPressed: (){
                                  AlertDialog alert = new AlertDialog(
                                    title: Text("Warning!",style: TextStyle(color: Colors.white),),
                                    backgroundColor: Colors.red,
                                    content: Text("Are you sure you want to delete record?",style: TextStyle(color: Colors.white),),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.of(context).pop();
                                      }, child: Text("Cancel",style: TextStyle(color: Colors.white),)),
                                      TextButton(onPressed: () async{
                                        var tid = snapshot.data[index]["tid"].toString();
                                        DatabaseHelpers obj = new DatabaseHelpers();
                                        var status = await obj.recorddelect(tid);
                                        Fluttertoast.showToast(
                                            msg: "YOUR DATA IS CLEAR",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                        setState(() {
                                          alldata = getdata();
                                        });
                                        Navigator.of(context).pop();
                                      }, child: Text("Delete",style: TextStyle(color: Colors.white),)),
                                    ],
                                  );
                                  showDialog(context: context, builder: (BuildContext context){
                                    return alert;
                                  });
                                },
                                child: Text("DELETE"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 28.0),
                            child: ElevatedButton(
                              onPressed: (){
                                var tid = snapshot.data[index]["tid"].toString();
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context)=>UpdateDataProject(savedb: tid,))
                                );
                              },
                              child: Text("EDIT"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }
          else
          {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
