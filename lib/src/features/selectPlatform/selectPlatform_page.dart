import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectPlatformView extends StatefulWidget {
  List<dynamic> providers;
  List<dynamic> platformsSelected;
  Function setPlatformsSelected;
  Function setProviders;
  SelectPlatformView(
      {super.key,
      required this.providers,
      required this.platformsSelected,
      required this.setPlatformsSelected,
      required this.setProviders});
  @override
  // ignore: no_logic_in_create_state
  State<SelectPlatformView> createState() => _SelectPlatformViewState(
      this.providers,
      this.platformsSelected,
      this.setPlatformsSelected,
      this.setProviders);
}

class _SelectPlatformViewState extends State<SelectPlatformView> {
  static const url_image = 'https://image.tmdb.org/t/p/w500';
  bool isSearching = false;
  List<dynamic> providers = [];
  _SelectPlatformViewState(this.providers, this.platformsSelected,
      this.setPlatformsSelected, this.setProviders);
  List<bool> platformsToggle = [];
  List<dynamic> searchProviders = [];
  List<dynamic> platformsSelected = [];
  Function setPlatformsSelected;
  Function setProviders;

  @override
  void initState() {
    super.initState();
    setState(() {
      searchProviders = widget.providers;
    });
    setState(() {
      platformsToggle =
          List<bool>.generate(searchProviders.length, (index) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          int offset = 0;
          for (var i = 0; i < platformsToggle.length; i++) {
            if (platformsToggle[i]) {
              setState(() {
                providers.remove(searchProviders[i - offset]);
              });
              offset++;
            }
          }

          return true;
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: const [
                  BackButton(
                    color: Colors.white,
                  ),
                  Text(
                    'Streaming services',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ]),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Select your streaming services',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 50,
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Card(
                                color: Colors.transparent,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Image.network(
                                  url_image +
                                      widget.platformsSelected[index]
                                          ['logo_path'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                  bottom: 17,
                                  left: 17,
                                  child: IconButton(
                                      onPressed: () {
                                        if (!widget.providers.contains(widget.platformsSelected[index])) {
                                          setState(() {
                                          widget.setProviders('add',
                                              widget.platformsSelected[index]);
                                        });
                                        }
                                        
                                        setState(() {
                                          setPlatformsSelected('remove',
                                              widget.platformsSelected[index]);
                                        });
                                        setState(() {
                                          searchProviders = widget.providers;
                                        });
                                        setState(() {
                                          platformsToggle = List<bool>.generate(
                                              searchProviders.length,
                                              (index) => false);
                                        });

                                        setState(() {
                                          searchProviders.sort((a, b) =>
                                              a['provider_name']
                                                  .toString()
                                                  .compareTo(b['provider_name']
                                                      .toString()));
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.cancel,
                                        color: Color.fromRGBO(180, 0, 0, 1),
                                        shadows: <Shadow>[
                                          Shadow(
                                              color: Colors.black,
                                              blurRadius: 15.0)
                                        ],
                                        size: 20,
                                      )))
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 0.1,
                          );
                        },
                        itemCount: widget.platformsSelected.length)),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    isSearching
                        ? Expanded(
                            child: TextField(
                            autofocus: true,
                            onChanged: (value) {
                              setState(() {
                                searchProviders = widget.providers
                                    .where((element) => element['provider_name']
                                        .toString()
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                              });
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                border: OutlineInputBorder(),
                                labelText: 'Search platform',
                                labelStyle: TextStyle(color: Colors.white24)),
                          ))
                        : Row(
                            children: [
                              TextButton(
                                  style: const ButtonStyle(
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: Colors.white24,
                                                  width: 2),
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
                                                  color: Colors.white24,
                                                  width: 2),
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
                                                  color: Colors.white24,
                                                  width: 2),
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
                        onPressed: () {
                          isSearching
                              ? {
                                  setState(() {
                                    isSearching = false;
                                  }),
                                  setState(() {
                                    searchProviders = widget.providers
                                        .where((element) =>
                                            element['provider_name']
                                                .toString()
                                                .toLowerCase()
                                                .contains(''.toLowerCase()))
                                        .toList();
                                  })
                                }
                              : setState(() {
                                  isSearching = true;
                                });
                        },
                        child: isSearching
                            ? const Icon(
                                Icons.cancel_outlined,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.search,
                                color: Colors.white,
                              ))
                  ],
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Card(
                                  color: Colors.transparent,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Image.network(
                                      url_image +
                                          searchProviders[index]['logo_path'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  searchProviders[index]['provider_name'],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    platformsToggle[index] =
                                        !platformsToggle[index];
                                  });
                                  if (platformsToggle[index]) {
                                    setState(() {
                                      searchProviders[index]['enable'] = true;
                                    });
                                    widget.setPlatformsSelected(
                                        'add', searchProviders[index]);
                                    // setState(() {
                                    //   widget.platformsSelected
                                    //       .add(searchProviders[index]);
                                    // });
                                    print(widget.platformsSelected);
                                  } else {
                                    setState(() {
                                      searchProviders[index]['enable'] = false;
                                    });
                                    widget.setPlatformsSelected(
                                        'remove', searchProviders[index]);
                                    // setState(() {
                                    //   widget.platformsSelected
                                    //       .remove(searchProviders[index]);
                                    // });
                                  }
                                },
                                child: platformsToggle[index]
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
                      itemCount: searchProviders.length),
                )),
              ],
            ),
          ),
        ));
  }
}
