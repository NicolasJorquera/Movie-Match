import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectPlatformView extends StatefulWidget {
  int selectedIndex;
  int previousSelectedIndex;
  Function setSelectedIndex;
  SelectPlatformView(
      {super.key,
      required this.setSelectedIndex,
      required this.selectedIndex,
      required this.previousSelectedIndex});
  @override
  // ignore: no_logic_in_create_state
  State<SelectPlatformView> createState() => _SelectPlatformViewState(
      setSelectedIndex, selectedIndex, previousSelectedIndex);
}

class _SelectPlatformViewState extends State<SelectPlatformView> {
  String searchValue = '';

  List<bool> PlatformsToggle = List<bool>.generate(50, (index) => false);
  Function setSelectedIndex;
  int selectedIndex;
  int previousSelectedIndex;
  _SelectPlatformViewState(
      this.setSelectedIndex, this.selectedIndex, this.previousSelectedIndex);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Padding(
        padding: EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Select your streaming services',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 50,
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
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
                    SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    TextButton(
                        style: const ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.white24, width: 2),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))))),
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Subscription',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        style: const ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.white24, width: 2),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))))),
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Rent/Buy',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        style: const ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.white24, width: 2),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))))),
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Free',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ],
                ),
                TextButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ))
              ],
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              color: Colors.white24,
                              child: SizedBox(
                                height: 40,
                                width: 40,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Netflix',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                PlatformsToggle[index] =
                                    !PlatformsToggle[index];
                              });
                            },
                            child: PlatformsToggle[index]
                                ? const Icon(
                                    Icons.check_box,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.check_box_outline_blank,
                                    color: Colors.white,
                                  ))
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: 20),
            )),
          ],
        ),
      ),
      onWillPop: () async {
        widget.setSelectedIndex();
        return false;
      },
    );
  }
}
