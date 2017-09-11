/**
 * 
 */

function getOpts(options,selectedVal,defaultVal,defaultText)
{
	var optstr="";					
	//var selected2="selected";
	//alert(options);
	optstr+="<option value='"+defaultVal+"' >"+defaultText;
	//function displayOpts()
				
	for(var i=0; i< options.length;i++)
	{		
		var selected="";
		if(selectedVal == options[i].value)						
			selected = "selected";						
		optstr+="<option value='"+options[i].value+"' "+selected+">"+options[i].text;																	
	}
	//obj.innerHTML=optstr;
	return optstr;
}

/* Get values form .js file */
function DropdownFilter(f,currentValue)
{
	var str="<center>";
	str+="<label style=\"font-size:20px; color:blue\" > "+f.label+": </label><select class=\"form-control\" id='"+f.field+"' name='"+f.field+"' style=\"padding:3px\">"; 										
	str+=getOpts(f.options,+currentValue,f.defaultValue,f.defaultText);
	str+="</select>";
	str+="</center>";
	return str;
}

/* Get values from selected other field using onchange function */
function DropdownFilterWithOnchange(f,currentValue)
{
	var str="<center>";
	str+="<label style=\"font-size:20px; color:blue\" > "+f.label+": </label><select onchange=\"displayFacility(this.options.selectedIndex);\" class=\"form-control\" id='"+f.field+"' name='"+f.field+"' style=\"padding:3px\">"; 										
	str+=getOpts(f.options,+currentValue,f.defaultValue,f.defaultText);
	str+="</select>";
	str+="</center>";
	return str;
}
// select taluk on district change
function DropdownOnchange(f,currentValue)
{
	var str="<center>";
	str+="<label style=\"font-size:20px; color:blue\" > "+f.label+": </label><select onchange=\"onChange(this.options.selectedIndex);\" class=\"form-control\" id='"+f.field+"' name='"+f.field+"' style=\"padding:3px\">"; 										
	str+=getOpts(f.options,+currentValue,f.defaultValue,f.defaultText);
	str+="</select>";
	str+="</center>";
	return str;
}

var kmcPeriods=[{text:"7th day after discharge",value:"3"},{text:"28th day of life",value:"4"}];
var facilityFilter={label:"Facility",field:"facility",options:(facilities==null?[]:facilities),defaultValue:"1",defaultText:"All"};
var kmcPeriodFilter={label:"KMCPeriod",field:"kmcPeriod",options:kmcPeriods,defaultValue:"2",defaultText:"7th day of life"};
var recordsCount =[{text:"10",value:"10"},{text:"20",value:"20"},{text:"50",value:"50"},{text:"100",value:"100"}];
var recordsFilter={label:"RecordsPerPage",field:"recordsPerPage",options:recordsCount,defaultValue:"5",defaultText:"5"};
var jsonFiles=[{text:"inborn_lbw",value:"1"},{text:"inborn_listing",value:"2"},{text:"inborn_normal",value:"3"},{text:"discharge_form",value:"4"},{text:"kmc_cc_form",value:"5"},{text:"kmc_fi_form",value:"6"},{text:"kmc_init_form",value:"7"},{text:"outborn_lbw",value:"8"},{text:"homeborn_listing",value:"9"},{text:"normal-cc",value:"10"}];
var dataForms={label:"select a form",field:"forms",options:jsonFiles,defaultValue:"0",defaultText:"choose..."};
var birthweight=[{text:"<2000g",value:"2"},{text:"2000-2499g",value:"3"},{text:">=2500g",value:"4"}];
var birthweightFilter={label:"BirthWeight",field:"birthweight",options:birthweight,defaultValue:"1",defaultText:"All"};
var talukFilter={label:"Taluks",field:"taluka",options:(taluks==null?[]:taluks),defaultValue:"0",defaultText:"All"};
var dist=[{text:"Koppal",value:"1"},{text:"gadag",value:"2"}];
var sel_dist={label:"Select District",field:"selDist",options:dist,defaultValue:"0",defaultText:"choose"};
function ExportToexcel(url,filename,hideCtrls)
{
	if(hideCtrls==false)
	{
		var str="<button onclick='window.open(\""+url+"?ctrl=ExportToexcel&hideCtrls=true&filename="+filename+"\",\"export\",\"width=800,height=600\")'>Export to excel</button>";
		//var str="<button onclick='window.open(\""+url+"&ctrl=ExportToexcel&hideCtrls=true&filename="+filename+"\",\"export\",\"width=800,height=600\")'>Export to excel</button>";
		return str;
	}
	else
		return "";
}

function ExportToexcelWithParameter(url,filename,hideCtrls)
{
	if(hideCtrls==false)
	{
		//var str="<button onclick='window.open(\""+url+"?ctrl=ExportToexcel&hideCtrls=true&filename="+filename+"\",\"export\",\"width=800,height=600\")'>Export to excel</button>";
		var str="<button onclick='window.open(\""+url+"&ctrl=ExportToexcel&hideCtrls=true&filename="+filename+"\",\"export\",\"width=800,height=600\")'>Export to excel</button>";
		return str;
	}
	else
		return "";
}