import 'package:expencesmanagers/ShowDetails.dart';
import 'package:flutter/material.dart';
import ' helpers/DatabaseHelpers.dart';
class ManagersRegistered extends StatefulWidget {
  @override
  State<ManagersRegistered> createState() => _ManagersRegisteredState();
}
class _ManagersRegisteredState extends State<ManagersRegistered> {
  TextEditingController _txtdate = TextEditingController();
  TextEditingController _txttitle = TextEditingController();
  TextEditingController _tremarks = TextEditingController();
  TextEditingController _tamt = TextEditingController();
  var expvalue = "Income";
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _txtdate.text = selectedDate.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Registered")),
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
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Type in your text",
                  fillColor: Colors.white70),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: _tamt,
                keyboardType: TextInputType.number,
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
                      DatabaseHelpers sub = new DatabaseHelpers();
                      var id = await sub .managers(title,remark,amt,type,date);
                      print("Record Inserted : "+id.toString());
                      _txttitle.text="";
                      _tremarks.text="";
                      _tamt.text="";
                      _txtdate.text="";
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>ShowDetails())
                      );
                    },
                    child: Text("ADD"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}