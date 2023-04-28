import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

class JoinWidget extends StatefulWidget {
  int selectedIndex;
  Function setSelectedIndex;
  JoinWidget(
      {super.key, required this.setSelectedIndex, required this.selectedIndex});

  @override
  State<JoinWidget> createState() =>
      _JoinWidgetState(this.setSelectedIndex, this.selectedIndex);
}

class _JoinWidgetState extends State<JoinWidget> {
  int currentStep = 0;
  Function setSelectedIndex;
  int selectedIndex;
  _JoinWidgetState(this.setSelectedIndex, this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
            colorScheme:
                const ColorScheme.light(primary: Color.fromRGBO(180, 0, 0, 1))),
        child: Stepper(
          type: StepperType.vertical,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () {
            final isLastStep = currentStep == getSteps().length - 1;
            if (isLastStep) {
              widget.setSelectedIndex();
            } else {
              setState(() {
                currentStep += 1;
              });
            }
          },
          onStepCancel: () {
            final isFirstStep = currentStep == 0;
            if (isFirstStep) {
            } else {
              setState(() {
                currentStep -= 1;
              });
            }
          },
          onStepTapped: (value) {
            setState(() {
              currentStep = value;
            });
          },
          controlsBuilder: (context, details) {
            return Container(
              margin: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: const Text(
                        'Continue',
                        style: TextStyle(color: Colors.white),
                      )),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll(Colors.black),
                          side: MaterialStateProperty.all(const BorderSide(
                              color: Color.fromRGBO(180, 0, 0, 1),
                              width: 1.0,
                              style: BorderStyle.solid))),
                      onPressed: details.onStepCancel,
                      child: const Text(
                        'Cancel',
                        style: TextStyle(),
                      )),
                ],
              ),
            );
          },
        ));
  }

  List<Step> getSteps() => [
        Step(
            isActive: currentStep >= 0,
            title: const Text(
              'Platforms',
              style: TextStyle(color: Colors.white),
            ),
            content: Container()),
        Step(
            isActive: currentStep >= 1,
            title: const Text('Genres', style: TextStyle(color: Colors.white)),
            content: Container()),
        Step(
            isActive: currentStep >= 2,
            title:
                const Text('Other step', style: TextStyle(color: Colors.white)),
            content: Container()),
      ];
}
