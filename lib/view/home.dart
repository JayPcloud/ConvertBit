import 'package:converter/data/logic/convert_logic.dart';
import 'package:converter/data/model/dec-bit_model.dart';
import 'package:flutter/material.dart';
import '../components/action_button.dart';
import '../components/toBinary_calc_widget.dart';
import '../components/dropDownField.dart';

class HomePg extends StatefulWidget {
  const HomePg({super.key});

  @override
  State<HomePg> createState() => _HomePgState();
}

final controller = Converter();

class _HomePgState extends State<HomePg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ConvertBit',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 0.5,
                height: 0.5,
              ),
              // Row(children: [
              //   Icon(Icons.arrow_forward_ios_rounded, size: 17,),
              //   Text()
              // ],)
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.yellow.withOpacity(
                      0.1,
                    ),
                    borderRadius: BorderRadiusDirectional.circular(5)),
                child: Column(
                  spacing: 15,
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        Expanded(
                          child: DropDownField(
                            title: "From",
                            value: controller.isDecToBit ? 1 : 2,
                            onChanged: (newValue) {
                              setState(() {
                                controller.swap(
                                    changed: newValue !=
                                        (controller.isDecToBit ? 1 : 2));
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: DropDownField(
                            title: "To",
                            value: controller.isDecToBit ? 2 : 1,
                            onChanged: (newValue) {
                              setState(() {
                                controller.swap(
                                    changed: newValue !=
                                        (controller.isDecToBit ? 2 : 1));
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.isDecToBit
                              ? "Enter decimal number"
                              : "Enter binary number",
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Form(
                                key: controller.formKey,
                                child: TextFormField(
                                  controller: controller.input,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  keyboardType: TextInputType.number,
                                  validator: (value) =>
                                      controller.inputValidator(),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 0)),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(2)),
                                child: Center(
                                    child: Text(
                                        controller.isDecToBit ? "10" : "2")),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    FittedBox(
                      child: Row(
                        spacing: 10,
                        children: [
                          ActionButton(
                            text: 'Convert (=)',
                            color: Color(0xff189622),
                            onPressed: () {
                              controller.isDecToBit
                                  ? controller.convertToBinary()
                                  : controller.convertToDecimal();
                              setState(() {});
                            },
                          ),
                          ActionButton(
                            text: 'Reset',
                            color: Colors.grey,
                            icon: Icons.close,
                            onPressed: () {
                              setState(() {
                                controller.reset();
                              });
                            },
                          ),
                          ActionButton(
                            text: 'Swap',
                            color: Colors.grey,
                            icon: Icons.swap_vert_rounded,
                            onPressed: () {
                              setState(() {
                                controller.swap(changed: true);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Column(
                      spacing: 7,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.isDecToBit
                              ? "Binary number (${controller.binaryAns.length} digits)"
                              : "Decimal number (${controller.decAns.length} digits)",
                        ),
                        Row(
                          spacing: 2,
                          children: [
                            Expanded(
                              flex: 8,
                              child: TextFormField(
                                readOnly: true,
                                maxLines: 2,
                                style: TextStyle(fontWeight: FontWeight.w500),
                                controller: controller.isDecToBit
                                    ? TextEditingController(
                                        text: controller.binaryAns)
                                    : TextEditingController(
                                        text: controller.decAns),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 73,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(2)),
                                child: Center(
                                    child: Text(
                                        controller.isDecToBit ? "2" : "10")),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        if (controller.calcSteps.isNotEmpty &&
                            controller.isDecToBit)
                          ToBinaryCalculationWidget(controller: controller),
                        if (controller.calcSteps.isNotEmpty &&
                            !controller.isDecToBit)
                          TextFormField(
                            readOnly: true,
                            maxLines: 3,
                            controller: TextEditingController(
                                text: controller
                                    .decimalCalculationStepsTextConstructor()),
                          ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
