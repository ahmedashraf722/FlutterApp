import 'package:flutter/material.dart';
import 'package:new_flutter2/model.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<ModelData> users = [
    ModelData(
      id: 1,
      name: 'Ahmed Ashraf',
      phone: '+206697715691',
    ),
    ModelData(
      id: 2,
      name: 'Ahmed Ali',
      phone: '+206942339713',
    ),
    ModelData(
      id: 3,
      name: 'Omar Ahmed',
      phone: '+201368796409',
    ),
    ModelData(
      id: 4,
      name: 'Ashraf Mostafa',
      phone: '+201463279972',
    ),
    ModelData(
      id: 5,
      name: 'Nada Ahmed',
      phone: '+201399775339',
    ),
    ModelData(
      id: 6,
      name: 'Mona Ali',
      phone: '+206569973392',
    ),
    ModelData(
      id: 7,
      name: 'Mariam Ashraf',
      phone: '+2069763333297',
    ),
    ModelData(
      id: 8,
      name: 'Mariam Ali',
      phone: '+207963136367',
    ),
    ModelData(
      id: 9,
      name: 'Ahmed Ali',
      phone: '+269888777720',
    ),
    ModelData(
      id: 10,
      name: 'John king',
      phone: '+209973333006',
    ),
    ModelData(
      id: 11,
      name: 'Selena Gomez',
      phone: '+201569733997',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Users",
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => buildUsersItem(users[index]),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 20.0,
            end: 20.0,
          ),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[400],
          ),
        ),
        itemCount: users.length,
      ),
    );
  }
}

Widget buildUsersItem(ModelData user) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
           CircleAvatar(
            radius: 25.0,
            child: Text(
            '${user.id}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text(
                user.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Text(
               user.phone,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
