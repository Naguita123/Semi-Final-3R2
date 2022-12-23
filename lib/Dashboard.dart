import 'package:flutter/material.dart';
import 'package:written_exam/system.dart';
import 'function.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}
class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Semi Final 3R2"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Information()));
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder<List<Todo>?>(
          future: DbHelper.getAllTodo(),
          builder: (context, AsyncSnapshot<List<Todo>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              if (snapshot != null) {
                return ListView.builder(
                  itemBuilder: (context, index) => Todolist(
                    todo: snapshot.data![index],
                    onTap: () async {
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Information()));
                      setState(() {});
                    },
                    onLongPress: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title:
                              const Text('Are you sure you want to delete?'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () async {
                                    await DbHelper
                                        .deleteTodo(snapshot.data![index]);

                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Yes'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('No'),
                                ),
                              ],
                            );
                          });
                    },
                  ),
                  itemCount: snapshot.data!.length,
                );
              }
              return const Center(
                child: Text('No to do'),
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }
}