var kmcInitForm={
		 "completedHtml": "<h2>KMC initiation details completed</h2> ",
		 "pages": [
		  {
		   "name": "page1",
		   "questions": [
		    {
		     "type": "text",
		     "name": "kmc_reg_no",
		     "title": "KMC registration number",
		     "isRequired": true
		    },
		    {
		     "type": "radiogroup",
		     "name": "kmc_initiation",
		     "title": "What is the status of kmc initiation?",
		     "isRequired": true,
		     "choices": [
		      "Initiated",
		      "Discharged without initiation"
		     ],
		     "colCount": 2
		    },
		    {
		     "type": "text",
		     "name": "reason_for_dalay",
		     "visible": false,
		     "title": "Reason for delay(if applicable)"
		    },
		  /* ]
		  },
		  {
		   "name": "page2",
		   "questions": [*/
		    {
		     "type": "text",
		     "name": "date_of_kmc_initiation",
		     "title": "Date (dd/mm/yyyy)",
		     "isRequired": true,
		     "validators": [
		      {
		       "type": "regex",
		       "text": "Enter the date in dd/mm/yyyy format",
		       "regex": "^[0-3]?[0-9]\\/[0-1]?[0-9]\\/20[0-9][0-9]$"
		      }
		     ]
		    ,
		      "visible":false
		    },
		    {
		     "type": "text",
		     "name": "time_of_kmc_initiation",
		     "startWithNewLine": false,
		     "title": "Time (hh:mm)",
		     "isRequired": true,
		     "validators": [
		      {
		       "type": "regex",
		       "text": "Enter the time in hh:mm",
		       "regex": "^[0-1]?[0-2]:[0-5][0-9]"
		      }
		     ]
		    ,
		    "visible":false
		    },
		    {
		     "type": "dropdown",
		     "name": "am_pm",
		     "startWithNewLine": false,
		     "title": "AM/PM",
		     "isRequired": true,
		     "choices": [
		      "AM",
		      "PM"
		     ],
		     "visible":false
		    },
		    {
		     "type": "dropdown",
		     "name": "kmc_provider",
		     "title": "KMC Provider",
		     "startWithNewLine": false,
		     "hasOther": true,
		     "choices": [
		      "Husband",
		      "Mother's mother",
		      "Mother in law",
		      "Mother's sister"
		     ],
		     "colCount": 4,
		     "visible":false
		    },
		    {
		     "type": "dropdown",
		     "name": "feed_type",
		     
		     "title": "Feeding",
		     "startWithNewLine": false,
		     "choices": [
		                 "DBF",
		                 "EBM-P",
		                 "EBM-S",
		                 "EBM-T",
		                 "F",
		                 "NPO",
		                 "IV"
		     ],
		     
		      "visible":false
		    ,
		     "colCount": 4
		    }
		   ],
		
		  }
		 ],
		 "triggers": [
		  {
		   "type": "visible",
		   "operator": "equal",
		   "value": "Initiated",
		   "name": "kmc_initiation",
		   "questions": [
		    "date_of_kmc_initiation",
		    "time_of_kmc_initiation",
		    "am_pm",
		    "feed_type",
		    "kmc_provider"
		    
		   ]
		  }
		 ]
		}