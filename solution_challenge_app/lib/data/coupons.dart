import 'package:flutter/material.dart';

class rewards_data {
  rewards_data(
      {required this.name,
      required this.points_required,
      required this.money,
      required this.money_icon,
      required this.url,
      required this.code});

  String name;
  int points_required;
  int money;
  Icon money_icon;
  String url;
  String code;
}

var dummyData = [
  rewards_data(
    name: 'Amazon Gift Card',
    points_required: 10,
    money: 50,
    money_icon: const Icon(Icons.currency_rupee, color: Colors.white),
    url:
        'https://ci3.googleusercontent.com/meips/ADKq_Nb38T5FVwp-gYi01dP2miqart7TVQfL7KkfwFZHrzbzc37-w8BKAeXW8VfdCJLF9KFUjRcMWyWobNfj8_8mpqGoQUk6McApSA6wWjL1xSXDZ3lWel-xJOnXl22tx7p1QzdiFitgIGJkXnSC9ydd23hzM3L6Q1iNJjF9MPoLr8w=s0-d-e1-ft#https://m.media-amazon.com/images/G/31/gc/designs/livepreview/congratulations_greatwin_noto_email_in-main',
    code: ' RJ4X-PUPNGB-7UJD',
  ),
  rewards_data(
      name: 'Flipkart Gift Card',
      points_required: 20,
      money: 50,
      money_icon: const Icon(
        Icons.currency_rupee,
        color: Colors.white,
      ),
      url:
          'https://ci3.googleusercontent.com/meips/ADKq_NZwgOwFTkB0kNGuIYR60_wFbJmuBx43tdyr-MPFeBkeP4_TsyvBiBQVcTN6U0BJNkRSDLeI6RIRdbZx67CD_--8rVHKz5SKaOwaJJpp4UQ8s4huhHhb8Q8ibtkDf-UERm-fXRPdUOSssAJqYgRWkCpzVlj9-VwoyhMZ=s0-d-e1-ft#https://m.media-amazon.com/images/G/31/gc/designs/livepreview/a_generic_orange_in_noto_email_in-main',
      code: 'QMY8-Y4RN6F-6HRT'),

  // rewards_data(
  // name: 'Flipkart Gift Card',
  // points_required: 150,
  // money: 50,
  // money_icon: const Icon(
  //   Icons.currency_rupee,
  //   color: Colors.white,
  // ),
  // url:
  //     'https://ci3.googleusercontent.com/meips/ADKq_NZwgOwFTkB0kNGuIYR60_wFbJmuBx43tdyr-MPFeBkeP4_TsyvBiBQVcTN6U0BJNkRSDLeI6RIRdbZx67CD_--8rVHKz5SKaOwaJJpp4UQ8s4huhHhb8Q8ibtkDf-UERm-fXRPdUOSssAJqYgRWkCpzVlj9-VwoyhMZ=s0-d-e1-ft#https://m.media-amazon.com/images/G/31/gc/designs/livepreview/a_generic_orange_in_noto_email_in-main',
  // code: 'QMY8-Y4RN6F-6HRT'),
];
