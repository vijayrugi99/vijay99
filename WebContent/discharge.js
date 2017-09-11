
var dischargeCommunities=[];

var dischargeForm={
 "pages": [
  {
   "name": "page3",
   "questions": [
    {
     "type": "text",
     "name": "date_of_outcome",
     "title": "Date of outcome(DD/MM/YYYY)",
     "isRequired": true,
     "validators": [
      {
       "type": "regex",
       "text": "Date should be in dd/mm/yyyy format",
       "regex":  "^(0?[1-9]|[12][0-9]|3[01])[\\/\\-](0?[1-9]|1[012])[\\/\\-]\\d{4}$"
      }
     ]
    },
    {
     "type": "dropdown",
     "name": "baby_condition",
     "title": "Baby Condition",
     "isRequired": true,
     "choices": [
      "Well",
      "Referred",
      "DAMA",
      "Died"
     ]
    },
    {
     "type": "text",
     "name": "reason_for_delay",
     "title": "Reason(if applicable)"
    }
   ],
   "title": "Final Outcome"
  },
  {
   "name": "page1",
   "questions": [
    {
     "type": "text",
     "name": "time_of_discharge",
   
     "title": "Time of discharge",
     "isRequired":true,
     "validators": [
      		      {
      		       "type": "regex",
      		       "text": "Enter the time in hh:mm",
      		       "regex": "^([0-9]|0[0-9]|1[0-2]):[0-5][0-9]$"
      		      }
      		     ]
    
    },
    {
        "name": "meridian",
        "type": "dropdown",
        "title": "AM/PM",
        "startWithNewLine": false,
        "choices": [
         "AM",
         "PM"
        ],
    "isRequired":true,
    },
    {
     "type": "dropdown",
     "name": "feed_type",
     "title": "Feeding",
     "isRequired": true,
     "choices": [
                 "DBF",
	               "EBM-P",
	               "EBM-S",
	               "EBM-T",
	               "F",
	               "NPO",
	               "IV"
     ],
    
    }
   ],
   "title": "Discharge details"
  },
  {
   "name": "page2",
   "questions": [
    {
     "type": "text",
     "name": "staff_nurse",
     "title": "Staff Nurse"
    },
    {
     "type": "dropdown",
     "name": "community_worker",
     "title": "Community Worker(Asha/ANC)",
     "choices": dischargeCommunities,   
     "choicesOrder": "asc",
     "isRequired": true,
     "hasOther": true,
   "title": "Handover"
  }
    ]
}

  ]
}