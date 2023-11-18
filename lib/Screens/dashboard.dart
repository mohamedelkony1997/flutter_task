import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task/models/item.dart';
import 'package:flutter_task/riverpods/itemriverpod.dart';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final dashboardViewModel = watch.watch(dashboardViewModelProvider);

        return Scaffold(
          appBar: AppBar(
            title: Text('Dashboard'),
          ),
          body: ListView.builder(
            itemCount: dashboardViewModel.items.length,
            itemBuilder: (context, index) {
              final item = dashboardViewModel.items[index];
              return ListTile(
  title: Text(item.name),
  subtitle: Text('Age: ${item.age}'),
  trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
        _showEditItemDialog(context, dashboardViewModel, index, item);
        },
      ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          dashboardViewModel.deleteItem(index);
        },
      ),
    ],
  ),
);
            },
          ),
          floatingActionButton: Container(
            margin: EdgeInsets.only(bottom: 70),
            child: FloatingActionButton(
              onPressed: () {
                _showAddItemDialog(context, dashboardViewModel);
              },
              child: Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }

  void _showAddItemDialog(BuildContext context, DashboardViewModel viewModel) {
    String name = ''; 
    int age = 0; 

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  name =
                      value; 
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                 
                  age = int.tryParse(value) ?? 0;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
            
                if (name.isNotEmpty && age > 0) {
                  viewModel.addItem(Item(name, age));
                  Navigator.pop(context);
                } else {
                 
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );

  }
 void _showEditItemDialog(
  BuildContext context,
  DashboardViewModel viewModel,
  int index,
  Item item,
) {
  String name = item.name;
  int age = item.age;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
              controller: TextEditingController(text: name),
              onChanged: (value) {
                name = value;
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Age'),
              controller: TextEditingController(text: age.toString()),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                age = int.tryParse(value) ?? 0;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (name.isNotEmpty && age > 0) {
                viewModel.editItem(index, Item(name, age));
                Navigator.pop(context);
              } else {
               
              }
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  );
}


}
