var babysurvey=  {
 completeText: "Complete",
 completedHtml: "Completed !",
 pages: [
  {
   name: "page2",
   questions: [
    {
     type: "text",
     isRequired: true,
     name: "pid1",
     title: "In Patient No (IPD)",
     validators: [
                  {
                   type: "numeric",
                   minValue: "1",
                   maxValue: "100000"
                  }
                  ],
    },
    {
     type: "text",
     name: "question1",
     startWithNewLine: false,
     title: "Patient id 2 (optional)",
     validators: [
                  {
                   type: "numeric",
                   minValue: "1",
                   maxValue: "100000"
                  }
                  ],
    },
    {
     type: "text",
     isRequired: true,
     name: "mother_name",
     title: "Mothers name",
     validators: [
      {
       type: "text",
       minLength: "3"
      }
     ]
    },
    {
     type: "text",
     isRequired: true,
     name: "husband_name",
     startWithNewLine: false,
     title: "Husband's name",
     validators: [
      {
       type: "text",
       minLength: "3"
      }
     ]
    }
   ],
   title: "Basic  details"
  },
  {
   name: "page3",
   questions: [
    {
     type: "text",
     isRequired: true,
     name: "dob",
     title: "Date Of birth(dd/mm/yyy)",
     validators: [
      {
       type: "regex",
       regex: "^(0?[1-9]|[12][0-9]|3[01])[\\/\\-](0?[1-9]|1[012])[\\/\\-]\\d{4}$",
       text: "Please enter the date in dd/mm/yyyy format"
      }
     ]
    },
    {
     type: "text",
     isRequired: true,
     name: "time_of_birth",
     title: "Time of birth",
     validators: [
      {
       type: "regex",
       regex: "^([0-9]|0[0-9]|1[0-2]):[0-5][0-9]$",
       text: "Please enter in time hh:mm  format"
      }
     ]
    },
    {
        type: "dropdown",
        choices: [
         {          
          value: "AM"
         },
         {
          value: "PM"
         }
        ],
        name: "half",
        isRequired: true,
        startWithNewLine: false,
        title: "AM/PM",
        width:50,
       },
     
    {
     type: "text",
     isRequired: true,
     name: "birth_weight",
     startWithNewLine: false,
     title: "Birth weight(gm)",
     validators: [
      {
       type: "numeric",
       maxValue: "1999",
       minValue: "0"
      },
      {
       type: "regex",
       regex: "^[0-9]*$",
       text: "Only numbers(No decimal)"
      }
     ]
    },
    {
     type: "dropdown",
     choices: [
      {
       value: "1",
       text: "Male"
      },
      {
       value: "2",
       text: "Female"
      },
      {
       value: "3",
       text: "Other"
      }
     ],
     name: "sex",
     startWithNewLine: false,
     title: "Sex"
    },
    {
     type: "dropdown",
     choices: [
      {
       value: "1",
       text: "Well"
      },
      {
       value: "2",
       text: "Sick"
      },
      {
       value: "3",
       text: "Died"
      }
     ],
     isRequired: true,
     name: "baby_status",
     title: "How is the baby?"
    }
   ],
   title: "Baby details"
  },
  {
   name: "page4",
   questions: [
    {
     type: "html",
     name: "question7",
     html: "Where are you coming from?"
    },
    {
     type: "dropdown",
     choices: [
      {
       value: "1",
       text: "Koppal"
      },
      {
       value: "2",
       text: "Gangavati"
      },
      {
       value: "3",
       text: "Kushtagi"
      },
      {
       value: "4",
       text: "Yelburga"
      }
     ],
     hasOther: true,
     isRequired: true,
     name: "taluk_from",
     title: "Taluk"
    },
    {
     type: "dropdown",
     hasOther: true,
     isRequired: true,
     name: "community_from",
     startWithNewLine: false,
     title: "Town/Village"
    },
    {
     type: "html",
     name: "from_header",
     html: "Where will you be going to?(If different from current location)"
    },
    {
     type: "html",
     name: "question3"
    },
    {
     type: "dropdown",
     choices: [
      {
       value: "1",
       text: "Koppal"
      },
      {
       value: "2",
       text: "Gangavati"
      },
      {
       value: "3",
       text: "Kushtagi"
      },
      {
       value: "4",
       text: "Yelburga"
      }
     ],
     hasOther: true,
     isRequired: true,
     name: "taluk_to",
     title: "Taluk"
    },
    {
     type: "dropdown",
     hasOther: true,
     isRequired: true,
     name: "community_to",
     startWithNewLine: false,
     title: "Town/Village"
    }
   ],
   title: "Community Details"
  },
  {
   name: "page5",
   questions: [
    {
     type: "text",
     name: "phone1",
     title: "Phone 1",
     validators: [
      {
       type: "numeric",
       maxValue: "9999999999",
       minValue: "100000000",
       text: "Phone no in 9-10 digits"
      }
     ]
    },
    {
     type: "text",
     name: "phone2",
     title: "Phone 2",
     validators: [
      {
       type: "numeric",
       maxValue: "9999999999",
       minValue: "100000000",
       text: "Phone no in 9-10 digits"
      }
     ]
    }
   ],
   title: "Contact Details"
  },
  {
   name: "page1",
   questions: [
    {
     type: "text",
     name: "thayi_card_no",
     title: "Thayi card number",
     validators: [
      {
       type: "numeric"
      }
     ]
    },
    {
     type: "text",
     name: "uid",
     title: "UID "
    },
    {
     type: "text",
     name: "epic",
     title: "EPIC/Voters Id"
    }
   ],
   title: "Identifiers(All applicable)"
  }
 ],
 title: "Details of LBW(Continue till you get data for all)"
};