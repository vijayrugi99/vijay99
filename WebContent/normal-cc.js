var normalCCForm={
 "pages": [
  {
   "questions": [
    {
     "type": "text",
     "isRequired": true,
     "name": "visit_date",
     "startWithNewLine": false,
     "title": "Call/Visit Date (DD/MM/YYYY)",
     "validators": [
      {
       "type": "regex",
       "regex": "^([0-9]|[0-2][0-9]|3[0-1])\\/(([0][1-9])|([1][0-2]))\\/20[0-9][0-9]$",
       "text": "Date should be in dd/mm/yyyy format"
      }
     ]
    },
    {
     "type": "radiogroup",
     "name": "mother_alive",
     "title": "Is Mother Alive?",
     "isRequired": true,
     "choices": [
      "Yes",
      "No"
     ],
     "colCount": 2
    },
    {
     "type": "text",
     "isRequired": true,
     "name": "mother_death_date",
     "title": "Date Of death of mother (DD/MM/YYYY)",
     "validators": [
      {
       "type": "regex",
       "regex": "^([0-9]|[0-2][0-9]|3[0-1])\\/(([0][1-9])|([1][0-2]))\\/20[0-9][0-9]$",
       "text": "Date should be in dd/mm/yyyy format"
      }
     ],
     "visible": false
    },
    {
     "type": "radiogroup",
     "name": "baby_alive",
     "title": "Is Baby Alive?",
     "isRequired": true,
     "choices": [
      "Yes",
      "No"
     ],
     "colCount": 2
    },
    {
     "type": "text",
     "isRequired": true,
     "name": "baby_death_date",
     "title": "Date Of death of baby (DD/MM/YYYY)",
     "validators": [
      {
       "type": "regex",
       "regex": "^([0-9]|[0-2][0-9]|3[0-1])\\/(([0][1-9])|([1][0-2]))\\/20[0-9][0-9]$",
       "text": "Date should be in dd/mm/yyyy format"
      }
     ],
     "visible": false
    },
    {
     "type": "radiogroup",
     "name": "breastfeed_no",
     "visible": false,
     "visibleIf": "{baby_alive}='Yes'",
     "title": "Was the baby exclusively breast fed in the last 24 hours?",
     "choices": [
      "Yes",
      "No"
     ],
     "colCount": 2
    },
    {
     "type": "dropdown",
     "choices": [
      {
       "value": "1",
       "text": "Baby in ICU/ Facility "
      },
      {
       "value": "2",
       "text": "Baby Dead "
      },
      {
       "value": "3",
       "text": "Mother dead"
      }
     ],
     "hasOther": true,
     "name": "nobreastfeed_reason",
     "storeOthersAsComment": false,
     "title": "Why was the baby not breastfed?",
     "visible": false
    },
    {
     "type": "comment",
     "name": "comments"
    }
   ],
   "name": "page1",
   "title": "KMC Details"
  }
 ],
 "triggers": [
  {
   "type": "visible",
   "operator": "equal",
   "value": "Yes",
   "name": "baby_alive",
   "questions": [
    "baby_weight",
    "kmc_hours",
    "breastfeed_no"
   ]
  },
  {
   "type": "visible",
   "operator": "equal",
   "value": "No",
   "name": "baby_alive",
   "questions": [
    "baby_death_date"
   ]
  },
  {
   "type": "visible",
   "operator": "equal",
   "value": "No",
   "name": "mother_alive",
   "questions": [
    "mother_death_date"
   ]
  },
  {
   "type": "visible",
   "operator": "equal",
   "value": "0",
   "name": "kmc_hours",
   "questions": [
    "nokmc_reason"
   ]
  },
  {
   "type": "visible",
   "operator": "equal",
   "value": "No",
   "name": "breastfeed_no",
   "questions": [
    "nobreastfeed_reason"
   ]
  }
 ]
}