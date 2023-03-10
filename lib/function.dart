import 'package:flutter/material.dart';
import 'package:written_exam/system.dart';

class Todolist extends StatelessWidget {
  final Todo todo;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const Todolist({Key? key, required this.todo, required this.onTap, required this.onLongPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
        child: Card(
          elevation: 2,
          child:Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    todo.title,
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12)
                ),
                Text(todo.description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class Information extends StatelessWidget {
  final Todo? todo;
  const Information({Key? key,
    this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    if(todo != null){
      titleController.text = todo!.title;
      descController.text = todo!.description;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(todo == null ?'Add to do': 'Update to do'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
              ),
            ),
            TextFormField(
              controller: descController,
              decoration: const InputDecoration(
                hintText: 'Description',
              ),
              keyboardType: TextInputType.multiline,
              onChanged: (str){},
              maxLines: 5,
            ),
            const SizedBox(height: 40,),
            SizedBox(
              child: ElevatedButton(
                onPressed: () async {
                  final title = titleController.text;
                  final description = descController.text;
                  if(title.isEmpty || description.isEmpty){
                    return;
                  }
                  Navigator.pop(context);
                  final Todo model = Todo(title: title, description: description, id: todo?.id);
                  if(todo == null){
                    await DbHelper.addTodo(model);
                  }else{
                    await DbHelper.updateTodo(model);
                  }
                },
                child: Text(todo == null ? 'Save to do': 'Edit to do'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
