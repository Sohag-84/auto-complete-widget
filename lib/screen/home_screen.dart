// ignore_for_file: prefer_const_constructors

import 'package:auto_complete_widget/model/user_model.dart';
import 'package:auto_complete_widget/service/api_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? userList;

  fetchedUserData() async {
    userList = await ApiServices().getUser();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchedUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Auto complete widget"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Autocomplete<Data>(
              optionsBuilder: (TextEditingValue value) {
                if (value.text.isEmpty) {
                  return List.empty();
                }
                return userList!.data!
                    .where((element) => element.firstName!
                        .toLowerCase()
                        .contains(value.text.toLowerCase()))
                    .toList();
              },
              displayStringForOption: (Data data) => data.firstName!,
              fieldViewBuilder: (BuildContext context,
                  TextEditingController controller,
                  FocusNode node,
                  Function onSubmit) {
                return TextField(
                  controller: controller,
                  focusNode: node,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                );
              },
              onSelected: (value){
                print(value.firstName);
              },
              optionsViewBuilder: (BuildContext context, Function onSelect,
                  Iterable<Data> dataList) {
                return Material(
                  child: ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      Data data = dataList.elementAt(index);
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: InkWell(
                          onTap: ()=>onSelect(data),
                          child: ListTile(
                            title: Text(data.firstName!),
                            leading: Image.network(
                              data.avatar!,
                              height: 50,
                              width: 50,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
