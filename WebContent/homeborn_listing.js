var homeborn_listing=
{
 "completeText": "Complete",
 "completedHtml": "Completed !",
 "pages": [
  {
   "questions": [
    {
     "type": "dropdown",
     "isRequired": true,
     "name": "nm",
     "startWithNewLine": false,
     "title": "Nurse Mentor/FI/ORW",
"choices":nms
    },
    {
     "type": "text",
     "isRequired": true,
     "name": "start_date",
     "startWithNewLine": false,
     "title": "Date of listing(dd/mm/yyy)",
     "validators": [
      {
       "type": "regex",
       "text": "Please enter the date in dd/mm/yyyy format",
       "regex": "^(0?[1-9]|[12][0-9]|3[01])[\\/\\-](0?[1-9]|1[012])[\\/\\-]\\d{4}$"
      }
     ]
    },
    {
     "type": "html",
     "name": "question7",
     "html": "Select community"
    },
    {
     "type": "dropdown",
     "choices": [
      {
       "value": "1",
       "text": "Koppal"
      },
      {
       "value": "2",
       "text": "Gangavati"
      },
      {
       "value": "3",
       "text": "Kushtagi"
      },
      {
       "value": "4",
       "text": "Yelburga"
      }
     ],
     "hasOther": true,
     "isRequired": true,
     "name": "taluk_from",
     "title": "Taluk"
    },
    {
     "type": "dropdown",
     "hasOther": true,
     "isRequired": true,
     "name": "community_from",
     "startWithNewLine": false,
     "title": "Town/Village"
    }
   ],
   "name": "page1",
   "title": "Community Details"
  },
  {
   "questions": [
    {
     "type": "text",
     "isRequired": true,
     "name": "mother_name",
     "title": "Mothers name",
     "validators": [
      {
       "type": "text",
       "minLength": "3"
      }
     ]
    },
    {
     "type": "text",
     "isRequired": true,
     "name": "husband_name",
     "startWithNewLine": false,
     "title": "Husband's name",
     "validators": [
      {
       "type": "text",
       "minLength": "3"
      }
     ]
    }
   ],
   "name": "page2",
   "title": "Basic  details"
  },
  {
   "questions": [
    {
     "type": "text",
     "isRequired": true,
     "name": "dob",
     "title": "Date Of birth(dd/mm/yyy)",
     "validators": [
      {
       "type": "regex",
       "text": "Please enter the date in dd/mm/yyyy format",
       "regex": "^(0?[1-9]|[12][0-9]|3[01])[\\/\\-](0?[1-9]|1[012])[\\/\\-]\\d{4}$"
      }
     ]
    },
    {
     "type": "text",
     "isRequired": true,
     "name": "time_of_birth",
     "startWithNewLine": false,
     "title": "Time of birth",
     "validators": [
      {
       "type": "regex",
       "text": "Please enter in time hh:ss am/pm format",
       "regex": "^([0-9]|0[0-9]|1[0-2]):[0-5][0-9] [a|p]m$"
      }
     ]
    },
    {
     "type": "text",
     "isRequired": true,
     "name": "baby_weight",
     "title": "Baby weight(gm)",
     "validators": [
      {
       "type": "numeric",
       "minValue": "0",
       "maxValue": "10000"
      },
      {
       "type": "regex",
       "text": "Only numbers(No decimal)",
       "regex": "^[0-9]*$"
      }
     ]
    },
    {
     "type": "text",
     "isRequired": true,
     "name": "babyweight_date",
     "startWithNewLine": false,
     "title": "Date of baby weight meas.(dd/mm/yyy)",
     "validators": [
      {
       "type": "regex",
       "text": "Please enter the date in dd/mm/yyyy format",
       "regex": "^(0?[1-9]|[12][0-9]|3[01])[\\/\\-](0?[1-9]|1[012])[\\/\\-]\\d{4}$"
      }
     ]
    },
    {
     "type": "dropdown",
     "choices": [
      {
       "value": "1",
       "text": "Male"
      },
      {
       "value": "2",
       "text": "Female"
      },
      {
       "value": "3",
       "text": "Other"
      }
     ],
     "name": "sex",
     "title": "Sex"
    },
    {
     "type": "dropdown",
     "choices": [
      {
       "value": "1",
       "text": "Well"
      },
      {
       "value": "2",
       "text": "Sick"
      },
      {
       "value": "3",
       "text": "Died"
      }
     ],
     "isRequired": true,
     "name": "baby_status",
     "startWithNewLine": false,
     "title": "How is the baby?"
    }
   ],
   "name": "page3",
   "title": "Baby details"
  },
  {
   "questions": [
    {
     "type": "text",
     "name": "phone1",
     "title": "Phone 1",
     "validators": [
      {
       "type": "numeric",
       "text": "Phone no in 9-10 digits",
       "minValue": "100000000",
       "maxValue": "9999999999"
      }
     ]
    },
    {
     "type": "text",
     "name": "phone2",
     "title": "Phone 2",
     "validators": [
      {
       "type": "numeric",
       "text": "Phone no in 9-10 digits",
       "minValue": "100000000",
       "maxValue": "9999999999"
      }
     ]
    }
   ],
   "name": "page5",
   "title": "Contact Details"
  },
  {
   "questions": [
    {
     "type": "text",
     "name": "thayi_card_no",
     "title": "Thayi card number",
     "validators": [
      {
       "type": "numeric"
      }
     ]
    },
    {
     "type": "text",
     "name": "uid",
     "title": "UID "
    },
    {
     "type": "text",
     "name": "epic",
     "title": "EPIC/Voters Id"
    }
   ],
   "name": "page6",
   "title": "Identifiers(All applicable)"
  },
  {
   "questions": [
    {
     "type": "dropdown",
     "choices": [
      "Yes",
      "No"
     ],
     "isRequired": true,
     "name": "baby_admitted",
"title":"Was the baby admitted to a facility?"
    },
    {
     "type": "dropdown",
     "isRequired": true,
     "name": "facility",
     "title": "Select the Facility",
     "visible": false,
"choices":facilities
    }
   ],
   "name": "page4"
  }
 ],
 "title": "Details of Baby",
 "triggers": [
  {
   "type": "visible",
   "operator": "equal",
   "value": "Yes",
   "name": "baby_admitted",
   "questions": [
    "facility"
   ]
  }
 ]
}