import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:customDropdown/models/associateDriver.dart';

class AssociateDriverWithVehicle extends StatefulWidget {
  @override
  _AssociateDriverWithVehicleState createState() =>
      _AssociateDriverWithVehicleState();
}

class _AssociateDriverWithVehicleState
    extends State<AssociateDriverWithVehicle> {
  static List<AssociateDriver> vehicle = [
    AssociateDriver(
      'vl-568935',
      'Naveen Reddy',
    ),
    AssociateDriver(
      'vl-545726',
      'James Thomas',
    ),
    AssociateDriver(
      'vl-458715',
      'Bryne Alter',
    ),
    AssociateDriver(
      'vl-548124',
      'Ramesh Pataudi',
    ),
    AssociateDriver(
      'vl-568215',
      'Vikram Bari',
    ),
    AssociateDriver(
      'vl-154726',
      'Plakar Mans',
    ),
    AssociateDriver(
      'vl-453485',
      'Devid Backster',
    ),
    AssociateDriver(
      'vl-514574',
      'Tommy Maguare',
    ),
  ];

  List<AssociateDriver> filteredVehicle = vehicle;

  /// methodName : search
  /// description :  search the vehicle and the associate driver based on the input value
  /// onSuccess : return AssociateDriver object
  /// onFailure :Null
  /// written : Asiczen
  Future<List<AssociateDriver>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    if (search == 'empty') return [];
    if (search == 'error') throw Error();
    setState(() {
      filteredVehicle = vehicle
          .where((v) =>
              (v.driverName.contains(search)) || v.vehicleNo.contains(search))
          .toList();
    });
    return List.generate(filteredVehicle.length, (index) {
      return AssociateDriver(
        'Vehicle Number : ${filteredVehicle[index].vehicleNo}',
        'Device IMEI : ${filteredVehicle[index].driverName}',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Associate Vehicle'),
        // flexibleSpace: getAppbarGradient(),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                // top: 1.0,
                // left: 1.0,
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: MediaQuery.of(context).size.height * 0.60,
                  child: associateSearchWidget(),
                ),
              ),
              Stack(
                children: [
                  Positioned(
                    // bottom: 10.0,
                    // left: 10.0,
                    // top: 10.0,
                // height: MediaQuery.of(context).size.height*.24,
                child: Container(
                  // color:Colors.blueAccent,
                  child: Column(
                    children: [
                      customDropdownFormVehicleNo(vehicle),
                      customDropdownFormDriver(vehicle),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Material(
                          elevation: 5,
                          child: //RaisedGradientButton(
                              FlatButton(
                            child: Text('Save'),
                            onPressed: () {},
                            // gradient: buttonColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// methodName : associateSearch
  /// description :  implement SearchBar widget
  /// onSuccess : return SearchBar Widget
  /// onFailure :Null
  /// written : Asiczen
  Widget associateSearchWidget() {
    return SearchBar<AssociateDriver>(
      onSearch: search,
      onItemFound: (AssociateDriver assDriver, int index) {
        return ListTile(
          title: Text(assDriver.vehicleNo),
          subtitle: Text(assDriver.driverName),
        );
      },
      cancellationWidget: Text('Okay'),
      debounceDuration: Duration(milliseconds: 800),
      loader: Center(
        child: Text('loading...'),
      ),
      placeHolder: Center(
        child: Text('Vehicle and Driver association'),
      ),
      onError: (error) {
        return Center(
          child: Text('Error occured : $error'),
        );
      },
      emptyWidget: Center(
        child: Text('Empty'),
      ),
    );
  }

  /// methodName : customDropdownFormVehicleNo
  /// description :  DropDown selection for Vehicle number
  /// onSuccess : return FormField Widget
  /// onFailure :Null
  /// written : Asiczen
  Widget customDropdownFormVehicleNo(List<AssociateDriver> item) {
    String dropdownValue;
    return FormField(builder: (FormFieldState state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              // color:Colors.orangeAccent,
              border: Border.all(
                color: Color(0xff218F76),
                width: 2.0,
              ),
            ),
            child: DropdownButton(
              hint: Text('Vehicle Number'),
              value: dropdownValue,
              items: item.map((dynamic value) {
                return DropdownMenuItem(
                  value: value.vehicleNo.toString(),
                  child: Text(value.vehicleNo),
                );
              }).toList(),
              onChanged: ((dynamic newValue) {
                state.didChange(newValue);
                dropdownValue = newValue;
              }),
            ),
          ),
        ],
      );
    });
  }

  /// methodName : customDropdownFormDriver
  /// description :  DropDown selection for Driver name
  /// onSuccess : return FormField Widget
  /// onFailure :Null
  /// written : Asiczen
  Widget customDropdownFormDriver(List<AssociateDriver> item) {
    String dropdownValue1;
    return FormField(builder: (FormFieldState state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              // color:Colors.orangeAccent,
              border: Border.all(
                color: Color(0xff218F76),
                width: 2.0,
              ),
            ),
            child: DropdownButton(
              hint: Text('Driver Name'),
              value: dropdownValue1,
              items: item.map((dynamic value) {
                return DropdownMenuItem(
                  value: value.driverName.toString(),
                  child: Text(value.driverName),
                );
              }).toList(),
              onChanged: ((dynamic newValue) {
                state.didChange(newValue);
                dropdownValue1 = newValue;
              }),
            ),
          ),
        ],
      );
    });
  }
}

// class DropdownFormField extends StatefulWidget {
//   BuildContext context;
//   final String hint;
//   dynamic value;
//   final List<dynamic> items;
//   final Function onChanged;
//   final Function validator;
//   final bool autovalidate;
//   final Function onSaved;
//   dynamic initialValue;
//   final theme;
//   final TextStyle textStyle;

//   DropdownFormField({
//     this.hint,
//     dynamic value,
//     this.items,
//     this.onChanged,
//     this.autovalidate,
//     this.validator,
//     dynamic initialValue,
//     this.theme,
//     this.textStyle,
//     this.onSaved,
//   }) {
//     this.value = items.where((i) => i == value).length > 0 ? value : null;
//     this.initialValue =
//         items.where((i) => i == value).length > 0 ? value : null;
//   }

//   @override
//   State<StatefulWidget> createState() {
//     return _DropdownFormField();
//   }
// }

// class _DropdownFormField extends State<DropdownFormField> {
//   @override
//   Widget build(BuildContext context) {
//     return FormField(
//       initialValue: widget.initialValue,
//       onSaved: (val) => (dynamic newValue) => widget.onSaved(newValue),
//       autovalidate: widget.autovalidate,
//       validator: widget.validator,
//       builder: (FormFieldState state) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             DropdownButtonHideUnderline(
//               child: Theme(
//                 data: Theme.of(context).copyWith(
//                     brightness: widget.theme == 'dark'
//                         ? Brightness.dark
//                         : Brightness.light,
//                     canvasColor:
//                         widget.theme == 'dark' ? Colors.black : Colors.white),
//                 child: DropdownButton(
//                   hint: Text(widget.hint,
//                       style: TextStyle(
//                           color: widget.theme == 'dark'
//                               ? Colors.white
//                               : Colors.black)),
//                   style: (widget.textStyle == null)
//                       ? TextStyle(
//                           color: (widget.theme == 'dark')
//                               ? Colors.white
//                               : Colors.black,
//                           fontSize: 16.0,
//                           decorationColor: widget.theme == 'dark'
//                               ? Colors.white
//                               : Colors.black)
//                       : widget.textStyle,
//                   value: widget.value,
//                   isDense: true,
//                   elevation: 24,
//                   isExpanded: true,
//                   onChanged: (dynamic newValue) {
//                     state.didChange(newValue);
//                     widget.onChanged(newValue);
//                   },
//                   items: widget.items.map((dynamic value) {
//                     return DropdownMenuItem(
//                       value: value['id'].toString(),
//                       child: Text(value['name']),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//             SizedBox(height: 2.0),
//             state.hasError
//                 ? Text(
//                     state.hasError ? state.errorText : '',
//                     style: TextStyle(
//                         color: Colors.redAccent.shade700, fontSize: 12.0),
//                   )
//                 : SizedBox(height: 0)
//           ],
//         );
//       },
//     );
//   }
// }
