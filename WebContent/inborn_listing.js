var listsurvey={
		 completeText: "Complete",
		 completedHtml: "Completed !",
		 pages: [
		  {
		   name: "page1",
		   questions: [
		    {
		     type: "dropdown",
		     name: "facility",
		     title: "Facility",
		     isRequired: true,
		     choices:facilities
		    },
		    {
		     type: "dropdown",
		     name: "nm",
		     startWithNewLine: false,
		     title: "Nurse Mentor",
		     isRequired: true,
		     choices:nms
		    },
		    {
		     type: "html",
		     name: "question1",
		     html: "<B> Baby details for the 24 hour period</B>"
		    },
		    {
		     type: "text",
		     name: "from_date",
		     title: "From date(8 AM)",
		     isRequired: true,
		     validators: [
		      {
		       type: "regex",
		       text: "Please enter the date in dd/mm/yyyy format",
		       regex: "^(0?[1-9]|[12][0-9]|3[01])[\\/\\-](0?[1-9]|1[012])[\\/\\-]\\d{4}$"
		      }
		     ]
		    },
		    {
		     type: "text",
		     name: "to_date",
		     startWithNewLine: false,
		     title: "To date (8 AM)",
		     isRequired: true,
		     validators: [
		      {
		       type: "regex",
		       text: "Please enter the date in dd/mm/yyy format",
		       regex: "^(0?[1-9]|[12][0-9]|3[01])[\\/\\-](0?[1-9]|1[012])[\\/\\-]\\d{4}$"
		      }
		     ]
		    }
		   ],
		   title: "Basic mother details"
		  },
		  {
		   name: "page3",
		   questions: [
		    {
		     type: "text",
		     name: "no_of_deliveries",
		     title: "No of deliveries",
		     isRequired: true,
		     validators: [
		      {
		       type: "numeric",
		       minValue: "1",
		       maxValue: "50"
		      },
		      {
		       type: "regex",
		       text: "Only numbers (No decimals)",
		       regex: "^[0-9]*$"
		      }
		     ]
		    },
		    {
		     type: "text",
		     name: "no_of_babies",
		     startWithNewLine: false,
		     title: "Number of babies",
		     isRequired: true,
		     validators: [
		      {
		       type: "numeric",
		       minValue: "1",
		       maxValue: "50"
		      },
		      {
		       type: "regex",
		       text: "Only numbers (No decimals)",
		       regex: "^[0-9]*$"
		      }
		     ]
		    },
		    {
		     type: "text",
		     name: "gt_24ga",
		     startWithNewLine: false,
		     title: ">24GA",
		     isRequired: true,
		     validators: [
		      {
		       type: "numeric",
		       minValue: "1",
		       maxValue: "50"
		      },
		      {
		       type: "regex",
		       text: "Only numbers (No decimals)",
		       regex: "^[0-9]*$"
		      }
		     ]
		    },
		    {
		     type: "text",
		     name: "still_births",
		     startWithNewLine: false,
		     title: "SBs",
		     isRequired: true,
		     validators: [
		      {
		       type: "numeric",
		       minValue: "0",
		       maxValue: "50"
		      },
		      {
		       type: "regex",
		       text: "Only numbers (No decimals)",
		       regex: "^[0-9]*$"
		      }
		     ]
		    },
		    {
		     type: "text",
		     name: "no_of_lbws",
		     title: "No of  low birth weight babies(<2500 gm)",
		     isRequired: true,
		     validators: [
		      {
		       type: "numeric",
		       minValue: "0",
		       maxValue: "10"
		      },
		      {
		       type: "regex",
		       text: "Only numbers (No decimals)",
		       regex: "^[0-9]*$"
		      }
		     ]
		    },
		    {
		     type: "text",
		     name: "no_below_2000",
		     title: "Number< 2000 gm",
		     isRequired: true,
		     validators: [
		      {
		       type: "numeric",
		       minValue: "0",
		       maxValue: "10"
		      },
		      {
		       type: "regex",
		       text: "Only numbers (No decimals)",
		       regex: "^[0-9]*$"
		      }
		     ]
		    }
		   ],
		   title: "Delivery Info"
		  }
		 ]
		}