var kmcCCForm={
		 "pages": [
		           {
		            "name": "page1",
		            "questions": [
		             {
		              "type": "text",
		              "isRequired": true,
		              "name": "visit_date",
		              "startWithNewLine": false,
		              "title": "Visit Date (DD/MM/YYYY)",
		              "validators": [
		               {
		                "type": "regex",
		                "regex": "^[0-3]?[0-9]\\/[0-1]?[0-2]\\/20[0-9][0-9]$",
		                "text": "Date should be in dd/mm/yyyy format"
		               }
		              ]
		             },
		             {
		              "type": "radiogroup",
		              "choices": [
		               "Yes",
		               "No"
		              ],
		              "colCount": 2,
		              "isRequired": true,
		              "name": "mother_alive",
		              "title": "Is Mother Alive?"
		             },
		             {
		              "type": "radiogroup",
		              "choices": [
		               "Yes",
		               "No"
		              ],
		              "colCount": 2,
		              "isRequired": true,
		              "name": "baby_alive",
		              "title": "Is Baby Alive?"
		             },
		             {
		              "type": "text",
		              "isRequired": true,
		              "name": "age",
		              "title": "Age in days",
		              "validators": [
		               {
		                "type": "numeric",
		                "maxValue": "5000",
		                "minValue": "1",
		                "text": "Baby's weight is out of range"
		               }
		              ]
		             },
		             {
		              "type": "text",
		              "isRequired": true,
		              "name": "kmc_hours",
		              "title": "KMC hours yesterday",
		              "visible": false,
		              "visibleIf": "{baby_alive}='Yes'"
		             },
		             {
		              "type": "text",
		              "isRequired": true,
		              "name": "breastfeed_no",
		              "title": "No of times baby was breast fed",
		              "visible": false,
		              "visibleIf": "{baby_alive}='Yes'"
		             },
		             {
		              "type": "text",
		              "name": "baby_weight",
		              "visible": false,
		              "visibleIf": "{baby_alive}='Yes'"
		             }
		            ],
		            "title": "KMC Details"
		           }
		          ],
		          "triggers": [
		           {
		            "type": "visible",
		            "operator": "equal",
		            "value": "Yes",
		            "name": "kmc_done",
		            "questions": [
		             "kmc_time_slots_today"
		            ]
		           }
		          ]
		         }
		       