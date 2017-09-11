var day1Form={
		 pages: [
		         {
		          name: "page1",
		          questions: [
		           {
		            type: "checkbox",
		            name: "phone_confirmations",
		            title: "Confirm the phone numbers",
		            hasOther: true,
		            choices: [
		             {
		              value: "1",
		              text: "98888888"
		             },
		             {
		              value: "2",
		              text: "080455555"
		             },
		             {
		              value: "3",
		              text: "808888888"
		             }
		            ],
		            storeOthersAsComment: false,
		            colCount: 4
		           },
		           {
		            type: "radiogroup",
		            choices: [
		             {
		              value: "1",
		              text: "Mother"
		             },
		             {
		              value: "2",
		              text: "Father"
		             }
		            ],
		            colCount: 3,
		            hasOther: true,
		            name: "respondent_type",
		            title: "Confirm the respondent relationship?"
		           },
		           {
		            type: "html",
		            name: "mother_name",
		            html: "Mother  name"
		           },
		           {
		            type: "checkbox",
		            name: "name_confirmations",
		            title: "Confirm the parent  names",
		            choices: [
		             {
		              value: "1",
		              text: "Mother name"
		             },
		             {
		              value: "2",
		              text: "Father name"
		             }
		            ],
		            colCount: 2
		           },
		           {
		            type: "checkbox",
		            name: "confirm_ ids",
		            choices: [
		             "Thayi Card No",
		             "UID",
		             "EPIC/Voter ID"
		            ],
		            colCount: 3
		           }
		          ],
		          title: "Confimations"
		         },
		         {
		          name: "page2",
		          questions: [
		           {
		            type: "text",
		            name: "next_date",
		            title: "Next date"
		           },
		           {
		            type: "html",
		            name: "question1",
		            html: "Next schedule time ranges"
		           },
		           {
		            type: "matrixdynamic",
		            name: "time_slots",
		            title: "Time Slots",
		            columns: [
		             {
		              name: "From (hh:mm)"
		             },
		             {
		              name: "To (hh;mm)"
		             }
		            ],
		            choices: [
		             1,
		             2,
		             3,
		             4,
		             5
		            ],
		            cellType: "text"
		           }
		          ],
		          title: "Call reschedule",
		          visible: false
		         },
		         {
		          name: "page3",
		          questions: [
		           {
		            type: "radiogroup",
		            choices: [
		             "Yes",
		             "No"
		            ],
		            colCount: 2,
		            name: "question2",
		            title: "Confirm the delivery"
		           },
		           {
		            type: "text",
		            name: "date_of_delivery1",
		            title: "Confirm date of delivery"
		           },
		           {
		            type: "radiogroup",
		            choices: [
		             "Above Mentioned Hospital",
		             "Home"
		            ],
		            hasOther: true,
		            name: "place_of_delivery",
		            title: "Place of delivery"
		           },
		           {
		            type: "dropdown",
		            name: "lbw_sex",
		            title: "Low birth weight baby sex",
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
		            ]
		           }
		          ]
		         },
		         {
		          name: "page4",
		          questions: [
		           {
		            type: "dropdown",
		            name: "mother_condition",
		            title: "How is the mother?",
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
		            ]
		           },
		           {
		            type: "dropdown",
		            name: "question3",
		            title: "What happened?",
		            hasOther: true,
		            choices: [
		             {
		              value: "1",
		              text: "Bleeding"
		             },
		             {
		              value: "2",
		              text: "Fits"
		             },
		             {
		              value: "3",
		              text: "Fever"
		             }
		            ],
		            storeOthersAsComment: false
		           },
		           {
		            type: "radiogroup",
		            choices: [
		             "Yes",
		             "No"
		            ],
		            colCount: 2,
		            name: "question4",
		            title: "Is she getting better?"
		           }
		          ],
		          title: "Mother condition"
		         },
		         {
		          name: "page5",
		          questions: [
		           {
		            type: "dropdown",
		            name: "birth_weight_confirm",
		            title: "Were you told whether your baby was normal birth weight or low birth weight?",
		            choices: [
		             {
		              value: "1",
		              text: "Normal"
		             },
		             {
		              value: "2",
		              text: "Low"
		             }
		            ],
		            storeOthersAsComment: false
		           },
		           {
		            type: "dropdown",
		            name: "sick_at_birth",
		            title: "Was the baby sick at birth?",
		            choices: [
		             "Yes",
		             "No"
		            ],
		            storeOthersAsComment: false
		           },
		           {
		            type: "dropdown",
		            name: "how_sick",
		            title: "How sick?",
		            choices: [
		             {
		              value: "1",
		              text: "Slightly sick"
		             },
		             {
		              value: "2",
		              text: "Very serious"
		             },
		             {
		              value: "3",
		              text: "Died immediately"
		             }
		            ],
		            storeOthersAsComment: false
		           },
		           {
		            type: "dropdown",
		            name: "baby_better",
		            title: "Did the baby get better?",
		            choices: [
		             "Yes",
		             "No"
		            ]
		           }
		          ],
		          title: "Baby condition"
		         }
		        ]
		       };