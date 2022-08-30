import 'package:expencesmanagers/%20helpers/DatabaseHelpers.dart';
import 'package:expencesmanagers/ShowDetails.dart';
import 'package:flutter/material.dart';
class UpdateDataProject extends StatefulWidget {
  var savedb = "";
  UpdateDataProject({this.savedb});
  @override
  State<UpdateDataProject> createState() => _UpdateDataProjectState();
}
class _UpdateDataProjectState extends State<UpdateDataProject> {
  TextEditingController _txtdate = TextEditingController();
  TextEditingController _txttitle = TextEditingController();
  TextEditingController _tremarks = TextEditingController();
  TextEditingController _tamt = TextEditingController();
  var expvalue = "E";
  DateTime selectedDate = DateTime.now();
  getdata() async
  {
    DatabaseHelpers obj = new DatabaseHelpers();
    var data = await obj.updatemanager(widget.savedb);
    _txttitle.text = data[0]["title"].toString();
    _tremarks.text = data[0]["remark"].toString();
    _tamt.text = data[0]["amt"].toString();
    _txtdate.text = data[0]["date"].toString();
    setState(() {
      expvalue = data[0]["type"].toString();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _txtdate.text = selectedDate.toString();
    getdata();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("UPDATE")),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text("Title"),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: _txttitle,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.yellow,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1,color: Colors.yellow),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text("Remarks"),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: _tremarks,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.yellow,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1,color: Colors.yellow),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text("Amount"),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: _tamt,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.yellow,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1,color: Colors.yellow),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 18.0),
              child: Row(
                children: [
                  Text("Income"),
                  Radio(
                    value: "Income",
                    groupValue: expvalue,
                    onChanged: (val)
                    {
                      setState(() {
                        expvalue = val;
                      });
                    },
                  ),
                  Text("Expences"),
                  Radio(
                    value: "Expences",
                    groupValue: expvalue,
                    onChanged: (val)
                    {
                      setState(() {
                        expvalue = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      controller: _txtdate,
                      keyboardType: TextInputType.text
                      ,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.yellow,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1,color: Colors.yellow),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(onPressed: () async{
                  final DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101));
                  if (picked != null && picked != selectedDate) {
                    setState(() {
                      selectedDate = picked;
                      _txtdate.text = selectedDate.toString();
                    });
                  }
                }, icon: Icon(Icons.calendar_today)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 45.0,bottom: 58.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () async{
                    var title = _txttitle.text.toString();
                    var remark = _tremarks.text.toString();
                    var amt = _tamt.text.toString();
                    var type = expvalue.toString();
                    var date = _txtdate.text.toString();
                    DatabaseHelpers obj = new DatabaseHelpers();
                    var status = await obj.savaexpences(title,remark,amt,type,date,widget.savedb);
                   // print(status);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>ShowDetails())
                    );
                  },
                  child: Text("Save"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
