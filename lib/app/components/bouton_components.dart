import 'package:flutter/material.dart';
import 'package:fitness_app/utils/colors.dart';


class ButtonComponent extends StatelessWidget{
  String label;
  FontWeight? fontWeight;
  double? size;
  Color? color;

  ButtonComponent({super.key, 
    required this.label,
    this.fontWeight,
    this.size=13,
    this.color=mainColor
});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Center(
        child: Text(label,style: TextStyle(
          color: Colors.white,
          fontFamily: 'PRegular',
          fontWeight: fontWeight,
          fontSize:size
        ),),
      ),
    );
    throw UnimplementedError();
  }
  
}