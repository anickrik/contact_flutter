import 'package:flutter/material.dart';

class ContactRow extends StatelessWidget {
  const ContactRow({Key? key, required this.name, required this.number}) : super(key: key);

  final String name;
  final String number;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 30,
              child: Icon(Icons.person),
            ),
            const SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Text(name),
                 const SizedBox(height: 10,),
                 Text(number),
               ],
            ),
            const Spacer(),
            Row(
              children: [
                IconButton(onPressed: (){}, icon: const Icon(Icons.note_alt)),
                IconButton(onPressed: (){}, icon: const Icon(Icons.delete))
              ],
            )
        ],
    ),
      )
    );
  }
}
