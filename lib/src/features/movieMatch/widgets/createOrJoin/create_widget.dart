import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class CreateWidget extends StatefulWidget {
  int selectedIndex;
  Function setSelectedIndex;
  CreateWidget(
      {super.key, required this.setSelectedIndex, required this.selectedIndex});

  @override
  State<CreateWidget> createState() =>
      _CreateWidgetState(this.setSelectedIndex, this.selectedIndex);
}

class _CreateWidgetState extends State<CreateWidget> {
  int currentStep = 0;
  Function setSelectedIndex;
  int selectedIndex;
  Map sessionData = {
    'Country': 'Chile',
    'Platforms': [''],
    'MovieOrSerie': 'Movie',
    'Genres': ['']
  };
  _CreateWidgetState(this.setSelectedIndex, this.selectedIndex);

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
                      child: Text(
                        currentStep == getSteps().length - 1
                            ? 'Start'
                            : 'Continue',
                        style: const TextStyle(color: Colors.white),
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
                        'Back',
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
              'Country',
              style: TextStyle(color: Colors.white),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select your country ', style: TextStyle(color: Colors.white,)),
                Container(
                  padding: const EdgeInsets.only(top: 15),
                  child: DropdownSearch<String>(
                    onChanged: (value) {
                      setState(() {
                        sessionData['Country'] = value;
                      });
                    },
                    selectedItem: 'Chile',
                    popupProps: PopupProps.menu(
                        // showSearchBox: true,

                        itemBuilder: (context, item, isSelected) {
                          return Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                item,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ));
                        },
                        // searchFieldProps: const TextFieldProps(
                        //     style: TextStyle(color: Colors.white),
                        //     cursorColor: Colors.white,
                        //     decoration: InputDecoration(
                        //         labelStyle: TextStyle(color: Colors.white))),
                        menuProps: MenuProps(
                            backgroundColor: Colors.black,
                            shape:
                                Border.all(width: 0.2, color: Colors.white))),
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                        baseStyle: TextStyle(color: Colors.white),
                        dropdownSearchDecoration: InputDecoration(
                            floatingLabelStyle:
                                TextStyle(color: Color.fromRGBO(180, 0, 0, 1)),
                            label: Text('Country'),
                            suffixIconColor: Colors.white,
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 0.2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 0.2)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 0.2)))),
                    items: const [
                      "Brazil",
                      "Italia",
                      "Tunisia",
                      'Canada',
                      'Chile',
                      "Brazil",
                      "Italia",
                      "Tunisia",
                      'Canada',
                      'Chile',
                      "Brazil",
                      "Italia",
                      "Tunisia",
                      'Canada',
                      'Chile',
                      "Brazil",
                      "Italia",
                      "Tunisia",
                      'Canada',
                      'Chile'
                    ],
                  ),
                )
              ],
            )),
        Step(
            isActive: currentStep >= 1,
            title:
                const Text('Platforms', style: TextStyle(color: Colors.white)),
            content: Container(
              padding: const EdgeInsets.only(top: 5),
              child: DropdownSearch<String>.multiSelection(
                selectedItems: sessionData['Platforms'],
                dropdownBuilder: (context, selectedItems) {
                  return Wrap(
                    children: selectedItems
                        .map((e) =>
                            defaultItemMultiSelectionMode(e, selectedItems))
                        .toList(),
                  );
                },
                popupProps: PopupPropsMultiSelection.menu(
                    selectionWidget: (context, item, isSelected) {
                      return Checkbox(
                        value: isSelected,
                        onChanged: (value) {},
                        activeColor: const Color.fromRGBO(180, 0, 0, 1),
                      );
                    },
                    itemBuilder: (context, item, isSelected) {
                      return Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            item,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ));
                    },
                    menuProps: MenuProps(
                        backgroundColor: Colors.black,
                        shape: Border.all(width: 0.2, color: Colors.white))),
                dropdownDecoratorProps: const DropDownDecoratorProps(
                    baseStyle: TextStyle(color: Colors.white),
                    dropdownSearchDecoration: InputDecoration(
                        // floatingLabelStyle:
                        //     TextStyle(color: Color.fromRGBO(180, 0, 0, 1)),
                        // label: Text('Platforms'),
                        suffixIconColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.2)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.2)),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.2)))),
                items: const [
                  "Netflix",
                  "Disney Plus",
                  "Movistar",
                  'Prime Video',
                  'HBO',
                  "FOX",
                  "Netflix",
                  "Disney Plus",
                  "Movistar",
                  'Prime Video',
                  'HBO',
                  "FOX",
                  "Netflix",
                  "Disney Plus",
                  "Movistar",
                  'Prime Video',
                  'HBO',
                  "FOX",
                ],
              ),
            )),
        Step(
            isActive: currentStep >= 2,
            title: const Text(
              'Movies or Series',
              style: TextStyle(color: Colors.white),
            ),
            content: Container(
              padding: const EdgeInsets.only(top: 5),
              child: DropdownSearch<String>(
                onChanged: (value) {
                  setState(() {
                    sessionData['MovieOrSeries'] = value;
                  });
                },
                selectedItem: 'Movie',
                popupProps: PopupProps.menu(
                    // showSearchBox: true,

                    itemBuilder: (context, item, isSelected) {
                      return Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            item,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ));
                    },
                    // searchFieldProps: const TextFieldProps(
                    //     style: TextStyle(color: Colors.white),
                    //     cursorColor: Colors.white,
                    //     decoration: InputDecoration(
                    //         labelStyle: TextStyle(color: Colors.white))),
                    menuProps: MenuProps(
                        backgroundColor: Colors.black,
                        shape: Border.all(width: 0.2, color: Colors.white))),
                dropdownDecoratorProps: const DropDownDecoratorProps(
                    baseStyle: TextStyle(color: Colors.white),
                    dropdownSearchDecoration: InputDecoration(
                        floatingLabelStyle:
                            TextStyle(color: Color.fromRGBO(180, 0, 0, 1)),
                        label: Text('Country'),
                        suffixIconColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.2)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.2)),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.2)))),
                items: const [
                  "Movies",
                  "Series",
                ],
              ),
            )),
        Step(
            isActive: currentStep >= 3,
            title: const Text('Genres', style: TextStyle(color: Colors.white)),
            content: Container(
              padding: const EdgeInsets.only(top: 5),
              child: DropdownSearch<String>.multiSelection(
                dropdownBuilder: (context, selectedItems) {
                  return Wrap(
                    children: selectedItems
                        .map((e) =>
                            defaultItemMultiSelectionMode(e, selectedItems))
                        .toList(),
                  );
                },
                popupProps: PopupPropsMultiSelection.menu(
                    selectionWidget: (context, item, isSelected) {
                      return Checkbox(
                        value: isSelected,
                        onChanged: (value) {},
                        activeColor: const Color.fromRGBO(180, 0, 0, 1),
                      );
                    },
                    itemBuilder: (context, item, isSelected) {
                      return Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            item,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ));
                    },
                    // searchFieldProps: const TextFieldProps(
                    //     style: TextStyle(color: Colors.white),
                    //     cursorColor: Colors.white,
                    //     decoration: InputDecoration(
                    //         labelStyle: TextStyle(color: Colors.white))),
                    menuProps: MenuProps(
                        backgroundColor: Colors.black,
                        shape: Border.all(width: 0.2, color: Colors.white))),
                dropdownDecoratorProps: const DropDownDecoratorProps(
                    baseStyle: TextStyle(color: Colors.white),
                    dropdownSearchDecoration: InputDecoration(
                        // floatingLabelStyle:
                        //     TextStyle(color: Color.fromRGBO(180, 0, 0, 1)),
                        // label: Text('Platforms'),
                        suffixIconColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.2)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.2)),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.2)))),
                items: const [
                  "Action",
                  "Adventure",
                  "Fiction",
                  'Anime',
                  'Cartoon',
                  "Drama",
                  "Romance",
                  "Action",
                  "Adventure",
                  "Fiction",
                  'Anime',
                  'Cartoon',
                  "Drama",
                  "Romance",
                  "Action",
                  "Adventure",
                  "Fiction",
                  'Anime',
                  'Cartoon',
                  "Drama",
                  "Romance",
                ],
              ),
            )),
        Step(
          isActive: currentStep >= 4,
          title:
              const Text('Share Link', style: TextStyle(color: Colors.white)),
          content: Container(
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: Colors.white)),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: SelectableText(
                                'Session ID',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.ios_share,
                              color: Color.fromRGBO(180, 0, 0, 1),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Session data',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Country:  ' + sessionData['Country'],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Platforms: ',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                              height: 40,
                              width: 200,
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Image.asset(
                                        'assets/logos/primelogo.png',
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      width: 0.1,
                                    );
                                  },
                                  itemCount: 50)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        sessionData['MovieOrSerie'] +
                            's of ' +
                            sessionData['Genres'].toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              )),
        )
      ];

  Widget defaultItemMultiSelectionMode(
      String item, List<String> selectedItems) {
    return Container(
      height: 32,
      padding: const EdgeInsets.only(left: 8, right: 1),
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(180, 0, 0, 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              item.toString(),
              style: const TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          MaterialButton(
            height: 20,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(0),
            minWidth: 20,
            onPressed: () {
              setState(() {
                selectedItems.remove(item);
              });
            },
            child: const Icon(
              Icons.close_outlined,
              color: Colors.white,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
