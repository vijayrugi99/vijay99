var kmcFiForm={
		completedHtml:"<h2>KMC details submitted .Please wait.</h2>",
		 pages: [
		         {
		          name: "page1",
		          questions: [
		           {
		            type: "text",
		            name: "date",
		            title: "Date (DD/MM/YYYY)",
		            isRequired: true,
		            validators: [
		             {
		              type: "regex",
		              regex:  "^(([1-3][0-9])|([0]?[1-9]))\\/(([0]?[1-9])|([1][0-2]))\\/20[0-1][0-7]$",
		              text: "Date should be in dd/mm/yyyy format"
		             }
		            ]
		           },
		           {
		            type: "radiogroup",
		            choices: [
		             "Yes",
		             "No"
		            ],
		            colCount: 2,
		            name: "kmc_done",
		            title: "KMC Done?",
		            isRequired: true,
		           },
		           {
		            type: "matrixdynamic",
		            choices: [
		             "DBF",
		             "EBM-P",
		             "EBM-S",
		             "EBM-T",
		             "F",
		             "NPO",
		             "IV"
		            ],
		            columns: [
		             {
		              name: "from",
		              title: "From Time(HH:MM)",
		              cellType: "text",
		              isRequired: true
		             },
		             {
		              name: "from_meridian",
		              title: "AM/PM",
		              choices: [
		               "AM",
		               "PM"
		              ],
		              cellType: "dropdown",
		              isRequired: true,
		             },
		             {
		              name: "to",
		              title: "To Time(HH:MM)",
		              cellType: "text",
		              isRequired: true
		             },
		             {
		              name: "to_meridian",
		              title: "AM/PM",
		              choices: [
		               "AM",
		               "PM"
		              ],
		              cellType: "dropdown",
		              isRequired: true,
		              
		             },
		             {
		              name: "feed_type",
		              title: "Feed Type",
		              cellType: "dropdown",
		              isRequired: true
		             },
		             {
		              name: "kmc_provider",
		              title: "KMC Provider",
		              choices: [
		               {value:"M",text:"Mother"},
		               {value:"H",text:"Husband"},
		               {value:"MM",text:"Mother's Mother"},
		               {value:"MIL",text:"Mother In Law"},
		               {value:"S",text:"Mother's sister"}
		              ],
		              cellType: "dropdown",
		              isRequired: true,
		              hasOther: true
		             }
		            ],
		            isRequired: true,
		            name: "kmc_time_slots_today",
		            rowCount: "1",
		            title: "KMC duration",
		            visible: false
		           }
		          ],
		          title: "KMC Details"
		         }
		        ],
		        triggers: [
		         {
		          type: "visible",
		          operator: "equal",
		          value: "Yes",
		          name: "kmc_done",
		          questions: [
		           "kmc_time_slots_today"
		          ]
		         }
		        ]
		       }