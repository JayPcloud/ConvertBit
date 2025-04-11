import 'package:converter/data/model/bit-dec_model.dart';
import 'package:converter/data/model/dec-bit_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';

extension SuperScript on int {
   String _superscript (int? value){
     switch (value??this){
       case 1:
         return '¹';
       case 2:
         return '²';
       case 3:
         return '³';
       case 4:
         return '⁴';
       case 5:
         return '⁵';
       case 6:
         return '⁶';
       case 7:
         return '⁷';
       case 8:
         return '⁸';
       case 9:
         return '⁹';
       case 0:
         return '⁰' ;
       default:
         return '-';
     }
   }
   String superscript() {
     if(toString().length == 1) return _superscript(null);
     String value = '';
     for (var digit in toString().characters) {
       try{
         value += _superscript(int.parse(digit));
       } catch(e) {
         if(digit == '-') {
           value += '-';
         }
       }
     }

     return value;
   }
   }



class Converter {

  int conversionType = 1;

  List calcSteps = [];

  TextEditingController input = TextEditingController();

  String binaryAns = '';

  String decAns = '';

  final formKey = GlobalKey<FormState>();

  bool get isDecToBit => conversionType == 1;

  bool get isBinary => RegExp(r'^[01]+(\.[01]+)?$').hasMatch(input.text.trim());

  bool get isDecimal => RegExp(r'^[0-9]+(\.[0-9]+)?$').hasMatch(input.text.trim());

  bool get inputHasDecimal => input.text.contains('.');

  String? inputValidator() {
    if(isDecToBit) {
      if(!isDecimal){
        return "Not a valid decimal number";
      }
      return null;
    }else {
      if(!isBinary) {
        return "Not a valid binary number";
      }
      return null;
    }
  }

  void clearPreviousCalculations() {
    binaryAns = '';
    calcSteps = [];
    binaryAns = '';
    decAns = '';
  }

  void swap({required bool changed}) {
    if(changed) {
      clearPreviousCalculations();
      isDecToBit
          ? conversionType = 2
          : conversionType = 1;
    }
  }

  void reset() {
    clearPreviousCalculations();
    input.text = '';
  }

  void convertToBinary() {
    clearPreviousCalculations();
    if (formKey.currentState!.validate()) {

      late int inputValue;

      if(inputHasDecimal) {
        double decimal = (double.parse(input.text.trim()) * pow( 2, 8));
        inputValue = decimal.toInt();
      }else {
        inputValue = int.parse(input.text.trim());
      }

      int bit = 0;
      List<int> allRemainders = [];
      while (inputValue != 0) {
        final quotient = (inputValue / 2).toInt();
        final remainder = inputValue % 2;
        final decToBit = DecToBit(dividend: inputValue.toInt(),
            quotient: quotient,
            remainder: remainder.toInt(),
            bit: bit,
          hasDecimal: inputHasDecimal?true:false
        );
        calcSteps.add(decToBit);
        allRemainders.add(remainder);
        inputValue = quotient;
        bit += 1;
      }
      if(input.text.contains('.')) {
        binaryAns = insertFromBack(
            originalString: allRemainders.reversed.map((e) => e.toString()).join(),
            character: '.',
            positionFromBack: 8
        );
        return;
      }
      binaryAns = allRemainders.reversed.map((e) => e.toString()).join();
    }
  }

  void convertToDecimal() {
    clearPreviousCalculations();
    if(formKey.currentState!.validate()) {
      double answer = 0;
      List<String> split = input.text.trim().split('.');
      int exp = split[0].length;
      int decExp = 0;

      for (var element in split[0].characters) {
        exp-=1;
        final digit = int.parse(element);
        final decValue = (digit * pow(2, exp)).toInt();
        final bitToDec = BitToDec(binaryDigit: digit, exp: exp, decValue: decValue.toDouble());
        answer += decValue;
        calcSteps.add(bitToDec);
      }
      if(split.length > 1) {
        for (var element in split[1].characters) {
          decExp-=1;
          final digit = int.parse(element);
          final decValue = (digit * pow(2, decExp)).toDouble();
          final bitToDec = BitToDec(binaryDigit: digit, exp: decExp, decValue: decValue);
          answer += decValue;
          calcSteps.add(bitToDec);
        }
      }

      decAns = answer.toString();

    }
  }

  String decimalCalculationStepsTextConstructor() {
    String calculations;
    List<String> rawSteps = [];
    for (var step in calcSteps.cast<BitToDec>()) {
      final eachStep = "(${step.binaryDigit} x 2${step.exp.superscript()}) ";
      rawSteps.add(eachStep) ;
    }
    calculations = '(${input.text.trim()})₂ = ${rawSteps.toString().replaceAll(',', '+').replaceAll('[', '').replaceAll(']', '')} = ($decAns)₁₀';
    return calculations;
  }

  String insertFromBack({
    required String originalString,
    required String character,
    required int positionFromBack
  }) {
    int positionFromFront = originalString.length - positionFromBack;
    return originalString.substring(0, positionFromFront) + character +
    originalString.substring(positionFromFront);
  }

  String shortenNum({int? num, String? str, int limit = 8}) {
    final string = (str??num.toString()).trim();
    if(string.length >= limit) {
      final decimals = string.substring(1,3);
      final shortenedNum = string.replaceRange(1, null, '.${decimals}e${(string.length-1).superscript()}');
      return shortenedNum;
    }
    return string;
  }


  int expMultiply(String num, int base, int exp)=> (double.parse(num) * (pow(base, exp))).toInt();
}