import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/shared/components/cubit/app_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultFormField(
        {@required TextEditingController controller,
        @required TextInputType type,
        Function onSubmit,
        Function onChange,
        bool isPassword = false,
        @required Function validate,
        @required String label,
        @required IconData prefix,
        IconData suffix,
        Function ontap,
        bool isClickable = true}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: ontap,
      enabled: isClickable,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? Icon(
                suffix,
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget taskItem(Map model,context) => Dismissible(
  key:Key(model['id'].toString()) ,
  child:   Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              child: Text('${model['time']}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
  
            IconButton(
                icon: Icon(
                  Icons.check_circle,
                  color: Colors.green[700],
                ),
                onPressed: () {
                  AppCubit.get(context).updateData(status: 'done', id: model['id']);
                }),
            IconButton(
                icon: Icon(
                  Icons.archive,
                  color: Colors.black38,
                ),
                onPressed: () {
                  AppCubit.get(context).updateData(status: 'archive', id: model['id']);
  
                })
          ],
        ),
      ),
  onDismissed: (direction){
    AppCubit.get(context).deleteData(id: model['id']);
  },
);

Widget tasksBuilder ({@required List<Map>tasks})=>ConditionalBuilder(
  condition: tasks.length > 0,
  builder: (context) => ListView.separated(
      itemBuilder: (context, index) =>
          taskItem(tasks[index], context),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey,
        ),
      ),
      itemCount: tasks.length),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: AssetImage('assets/images/inbox.png'),
          width: 200,
          height: 200,
        ),
        SizedBox(height: 15,),
        Text(
          'No Tasks Yet, Please Add New Tasks',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        )
      ],
    ),
  ),
);

Widget cutomAppBar({ Color color, @required title})=>AppBar(
  title: Text(title),backgroundColor: color,
);

Widget raisedinfobutton ({
  @required  context,
  @required String title,
  @required Color color,
  @required AssetImage asset,
  @required String URL,
})=>SizedBox(
  width:MediaQuery.of(context).size.width/2 ,
  child: ElevatedButton(onPressed: (){
    launch(URL);
  },
    style: ElevatedButton.styleFrom(
        primary: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6)
        )
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: asset,width: 20,height: 20,),
        SizedBox(width: 15,),
        Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
      ],
    ),),
);