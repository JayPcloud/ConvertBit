import 'package:converter/data/logic/convert_logic.dart';
import 'package:flutter/material.dart';
import '../data/model/dec-bit_model.dart';

class ToBinaryCalculationWidget extends StatelessWidget {
  const ToBinaryCalculationWidget({super.key, required this.controller});

  final Converter controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.circular(5),
          border: Border.all(color: Colors.blueGrey, width: 0.5)),
      child: Column(
        children: [
          if (controller.inputHasDecimal)
            Text(
              "To avoid the decimal separator, multiply the decimal number with the base "
              "raised to the power of decimals in result:\n"
              "${controller.input.text.trim()}x2⁸ = ${controller.expMultiply(controller.input.text.trim(), 2, 8)}",
              style: TextStyle(fontWeight: FontWeight.w500,height: 1.8),
            ),
          Text(
            "Divide by the base 2 to get the digits from the remainder:",
            style: TextStyle(fontWeight: FontWeight.w500,height: 1.8),
          ),
          SizedBox(
            height: 5,
          ),
          Flex(
            direction: Axis.horizontal,
            children: [
              tableField("Division by 2", flex: 2),
              tableField("Quotient", flex: 2),
              tableField("Remainder", flex: 2),
              tableField("Bit \n#", flex: 1),
            ],
          ),
          Table(
          defaultVerticalAlignment:TableCellVerticalAlignment.bottom,
              children: [
            for (var step in controller.calcSteps.cast<DecToBit>())
              TableRow(children: [
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    tableCell('${step.dividend}/2', flex: 2, isTopCell: step.bit == 0),
                    tableCell('${step.quotient}', flex: 2, isTopCell: step.bit == 0),
                    tableCell('${step.remainder}',
                        flex: 2,
                        color: Colors.grey.withOpacity(0.2),
                        isTopCell: step.bit == 0,
                        border: Border.all(
                          width: 0.5,
                        )),
                    tableCell('${step.bit}', flex: 1, isTopCell: step.bit == 0),
                  ],
                ),
              ])
          ]),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.inputHasDecimal)
                    Text(
                      '= (${controller.binaryAns.replaceAll('.', '')})₂ / 2⁸',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  Text(
                    '= ${controller.binaryAns}',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget tableField(String text, {int? flex}) {
    return Expanded(
      flex: flex ?? 1,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Container(
          padding: EdgeInsets.all(5),
          height: 80,
          decoration: BoxDecoration(color: Colors.grey.withOpacity(0.8)),
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget tableCell(String text,
      {int? flex, Color? color, BoxBorder? border, bool isTopCell = false}) {
    return Expanded(
      flex: flex ?? 1,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Container(
          padding: EdgeInsets.only(top: 5, bottom: 5, left: 8),
          decoration: BoxDecoration(
              color: color,
              border: border ??
                  Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 0.8,
                      ),
                      top: isTopCell
                          ? BorderSide(
                              color: Colors.grey,
                              width: 0.8,
                            )
                          : BorderSide.none)),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
                text.contains('/2')
              ?'${controller.shortenNum(str:text.replaceAll('/2', ''))}/2'
              :controller.shortenNum(str:text),
              style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
