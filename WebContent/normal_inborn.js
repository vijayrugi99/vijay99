var babysurvey1={
 completeText: "Complete",
 completedHtml: "Completed !",
 pages: [
  {
   name: "page2",
   questions: [
    {
     type: "text",
     name: "pid1",
     title: "In Patient No (IPD)",
     isRequired: true,
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
     name: "pid2",
     startWithNewLine: false,
     title: "Patient id 2(optional)",
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
     name: "mother_name",
     title: "Mothers name?",
     isRequired: true,
     validators: [
      {
       type: "text",
       minLength: "3"
      }
     ]
    },
    {
     type: "text",
     name: "husband_name",
     startWithNewLine: false,
     title: "Husband's name",
     isRequired: true,
     validators: [
      {
       type: "text",
       minLength: "3"
      }
     ]
    },
    {
     type: "text",
     name: "birth_weight",
     title: "Birth Weight(gm)",
     isRequired: true,
     validators: [
      {
       type: "numeric",
       minValue: "1",
       maxValue: "5000"
      }
     ]
    },
    {
     type: "text",
     name: "dob",
     startWithNewLine: false,
     title: "Date of birth(dd/mm/yyyy)",
     isRequired: true
    }
   ],
   title: "Basic details"
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
       text: "Phone no in 9-10 digits",
       minValue: "100000000",
       maxValue: "9999999999"
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
       text: "Phone no in 9-10 digits",
       minValue: "100000000",
       maxValue: "9999999999"
      },
      {
       type: "answercount",
       minCount: "9",
       maxCount: "10"
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
   visible: false,
   title: "Identifiers(All applicable)"
  }
 ],
 title: "Details of LBW(Continue till you get data for all)"
}