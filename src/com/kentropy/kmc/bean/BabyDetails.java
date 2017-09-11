package com.kentropy.kmc.bean;

 /** This bean class defines the fields present in test,kmc collection of KMC project
 *	This is having getter and setter methods for each fields 
 */

public class BabyDetails 
{	
	//babies entered details field
	public Object from_date = "-";								
	public Object to_date = "-";
	public Object facility = "-";								
	public Object nm = "-";
	public Object no_of_deliveries = "-";
	public Object no_of_babies = "-";
	public Object gt_24ga ="-";
	public Object still_births = "-";
	public Object no_of_lbws = "-";						
	public Object no_below_2000 = "-";
	public Object no_of_ob_lbws = "-";
	public Object u_id = "-";
	public Object pid1 = "-";
	public Object pid2 = "-";
	public Object epic = "-";
	public Object thayi_card_no = "-";
	public Object uid = "-";
	public Object time_of_birth = "-";
	public Object community_from = "-";
	public Object baby_status = "-";
	public Object mother_name = "-";
	public Object sex ="-";
	public Object phone1 = "-";
	public Object community_to ="-";
	public Object dob ="-";
	public Object taluk_to="-";
	public Object birth_weight="-";
	public Object taluk_from ="-";
	public Object husband_name ="-";
	public Object phone2 ="-";
	public Object surveytype = "-";
	
	//kmc details fields
	public Object am_pm = "-";
	public Object kmc_reg_no = "-";
	public Object date_of_kmc_initiation = "-";
	public Object time_of_kmc_initiation = "-";
	public Object kmc_unique_id = "-";
	public Object kmc_objectID = "-";
	public Object status = "-";
	public Object kmc_done = "-";
	public Object kmc_date = "-";
	public Object kmc_from_time = "-";
	public Object kmc_to_time = "-";
	public Object kmc_from_meridian = "-";
	public Object kmc_to_meridian = "-";
	public Object kmc_feed_type = "-";
	public Object kmc_survey_type = "-";
	public Object init_date1 = "-";
	public Object kmc_initiation = "-";
	
	//discharge details
	public Object baby_condition="-";
	public Object date_of_outcome="-";
	public Object community_worker="-";
	public Object feed_type="-";
	public Object time_of_discharge="-";
	public Object meridian="-";
	public Object reason_for_delay="-";
	public Object staff_nurse="-";	
	
	//cc success details
	public Object visit_date="-";	
	public Object kmc_period="-";
	public Object baby_alive="-";
	public Object mother_alive="-";
	public Object baby_death_date="-";
	public Object mother_death_date="-";
	public Object breastfeed_no="-";
	public Object kmc_hours="-";
	public Object cc_surveytype="-";
	public Object baby_weight="-";
	
	//cc failure details
	public Object calledto="-";	
	public Object callername="-";
	public Object callerrole="-";
	public Object remarks="-";
	public Object calldate="-";
	public Object type="-";
	public Object phno="-";
	public Object fstatus="-";	
	
	//home born listing
	public Object start_date="-";
	public Object babymeasured_weight="-";
	public Object babyweight_date="-";
	public Object baby_admitted="-";
	
	//csv data
	public Object created_date="-";
	public Object filename="-";
	public Object filetype="-";
	public Object csv_datefrom="-";
	public Object csv_dateto="-";
	
	//getter and setter methods
	public Object getStart_date() {
		return start_date;
	}
	public void setStart_date(Object start_date) {
		this.start_date = start_date;
	}
	public Object getBabymeasured_weight() {
		return babymeasured_weight;
	}
	public void setBabymeasured_weight(Object babymeasured_weight) {
		this.babymeasured_weight = babymeasured_weight;
	}
	public Object getBabyweight_date() {
		return babyweight_date;
	}
	public void setBabyweight_date(Object babyweight_date) {
		this.babyweight_date = babyweight_date;
	}
	 
	public Object getVisit_date() {
		return visit_date;
	}
	public void setVisit_date(Object visit_date) {
		this.visit_date = visit_date;
	}
	public Object getKmc_period() {
		return kmc_period;
	}
	public Object getBreastfeed_no() {
		return breastfeed_no;
	}
	public void setBreastfeed_no(Object breastfeed_no) {
		this.breastfeed_no = breastfeed_no;
	}
	public Object getBaby_weight() {
		return baby_weight;
	}
	public void setBaby_weight(Object baby_weight) {
		this.baby_weight = baby_weight;
	}
	public void setKmc_period(Object kmc_period) {
		this.kmc_period = kmc_period;
	}
	public Object getBaby_alive() {
		return baby_alive;
	}
	public void setBaby_alive(Object baby_alive) {
		this.baby_alive = baby_alive;
	}
	public Object getMother_alive() {
		return mother_alive;
	}
	public void setMother_alive(Object mother_alive) {
		this.mother_alive = mother_alive;
	}	

	public Object getFrom_date() {
		return from_date;
	}
	public void setFrom_date(Object from_date) {
		this.from_date = from_date;
	}
	public Object getTo_date() {
		return to_date;
	}
	public void setTo_date(Object to_date) {
		this.to_date = to_date;
	}
	public Object getFacility() {
		return facility;
	}
	public void setFacility(Object facility) {
		this.facility = facility;
	}
	public Object getNm() {
		return nm;
	}
	public void setNm(Object nm) {
		this.nm = nm;
	}
	public Object getNo_of_deliveries() {
		return no_of_deliveries;
	}
	public void setNo_of_deliveries(Object no_of_deliveries) {
		this.no_of_deliveries = no_of_deliveries;
	}
	public Object getNo_of_babies() {
		return no_of_babies;
	}
	public void setNo_of_babies(Object no_of_babies) {
		this.no_of_babies = no_of_babies;
	}
	public Object getGt_24ga() {
		return gt_24ga;
	}
	public void setGt_24ga(Object gt_24ga) {
		this.gt_24ga = gt_24ga;
	}
	public Object getStill_births() {
		return still_births;
	}
	public void setStill_births(Object still_births) {
		this.still_births = still_births;
	}
	public Object getNo_of_lbws() {
		return no_of_lbws;
	}
	public void setNo_of_lbws(Object no_of_lbws) {
		this.no_of_lbws = no_of_lbws;
	}
	public Object getNo_below_2000() {
		return no_below_2000;
	}
	public void setNo_below_2000(Object no_below_2000) {
		this.no_below_2000 = no_below_2000;
	}
	public Object getNo_of_ob_lbws() {
		return no_of_ob_lbws;
	}
	public void setNo_of_ob_lbws(Object no_of_ob_lbws) {
		this.no_of_ob_lbws = no_of_ob_lbws;
	}
	public Object getU_id() {
		return u_id;
	}
	public void setU_id(Object u_id) {
		this.u_id = u_id;
	}
	public Object getPid1() {
		return pid1;
	}
	public void setPid1(Object pid1) {
		this.pid1 = pid1;
	}
	public Object getPid2() {
		return pid2;
	}
	public void setPid2(Object pid2) {
		this.pid2 = pid2;
	}
	public Object getEpic() {
		return epic;
	}
	public void setEpic(Object epic) {
		this.epic = epic;
	}
	public Object getThayi_card_no() {
		return thayi_card_no;
	}
	public void setThayi_card_no(Object thayi_card_no) {
		this.thayi_card_no = thayi_card_no;
	}
	public Object getUid() {
		return uid;
	}
	public void setUid(Object uid) {
		this.uid = uid;
	}
	public Object getTime_of_birth() {
		return time_of_birth;
	}
	public void setTime_of_birth(Object time_of_birth) {
		this.time_of_birth = time_of_birth;
	}
	public Object getCommunity_from() {
		return community_from;
	}
	public void setCommunity_from(Object community_from) {
		this.community_from = community_from;
	}
	public Object getBaby_status() {
		return baby_status;
	}
	public void setBaby_status(Object baby_status) {
		this.baby_status = baby_status;
	}
	public Object getMother_name() {
		return mother_name;
	}
	public void setMother_name(Object mother_name) {
		this.mother_name = mother_name;
	}
	public Object getSex() {
		return sex;
	}
	public void setSex(Object sex) {
		this.sex = sex;
	}
	public Object getPhone1() {
		return phone1;
	}
	public void setPhone1(Object phone1) {
		this.phone1 = phone1;
	}
	public Object getCommunity_to() {
		return community_to;
	}
	public void setCommunity_to(Object community_to) {
		this.community_to = community_to;
	}
	public Object getDob() {
		return dob;
	}
	public void setDob(Object dob) {
		this.dob = dob;
	}
	public Object getTaluk_to() {
		return taluk_to;
	}
	public void setTaluk_to(Object taluk_to) {
		this.taluk_to = taluk_to;
	}
	public Object getBirth_weight() {
		return birth_weight;
	}
	public void setBirth_weight(Object birth_weight) {
		this.birth_weight = birth_weight;
	}
	public Object getTaluk_from() {
		return taluk_from;
	}
	public void setTaluk_from(Object taluk_from) {
		this.taluk_from = taluk_from;
	}
	public Object getHusband_name() {
		return husband_name;
	}
	public void setHusband_name(Object husband_name) {
		this.husband_name = husband_name;
	}
	public Object getPhone2() {
		return phone2;
	}
	public void setPhone2(Object phone2) {
		this.phone2 = phone2;
	}
	public Object getSurveytype() {
		return surveytype;
	}
	public void setSurveytype(Object surveytype) {
		this.surveytype = surveytype;
	}
	
	public Object getBaby_condition() {
		return baby_condition;
	}
	public void setBaby_condition(Object baby_condition) {
		this.baby_condition = baby_condition;
	}
	public Object getDate_of_outcome() {
		return date_of_outcome;
	}
	public void setDate_of_outcome(Object date_of_outcome) {
		this.date_of_outcome = date_of_outcome;
	}
	public Object getCommunity_worker() {
		return community_worker;
	}
	public void setCommunity_worker(Object community_worker) {
		this.community_worker = community_worker;
	}
	public Object getFeed_type() {
		return feed_type;
	}
	public void setFeed_type(Object feed_type) {
		this.feed_type = feed_type;
	}
	public Object getTime_of_discharge() {
		return time_of_discharge;
	}
	public void setTime_of_discharge(Object time_of_discharge) {
		this.time_of_discharge = time_of_discharge;
	}
	public Object getMeridian() {
		return meridian;
	}
	public void setMeridian(Object meridian) {
		this.meridian = meridian;
	}
	public Object getReason_for_delay() {
		return reason_for_delay;
	}
	public void setReason_for_delay(Object reason_for_delay) {
		this.reason_for_delay = reason_for_delay;
	}
	public Object getStaff_nurse() {
		return staff_nurse;
	}
	public void setStaff_nurse(Object staff_nurse) {
		this.staff_nurse = staff_nurse;
	}
	
	/*public String toString()
	{
	    return "Object = [ from_date:"+from_date+", to_date:"+to_date+", facility:"+facility+", nm:"+nm+ ", no_of_deliveries:"+no_of_deliveries+", no_of_babies:"+no_of_babies+", gt_24ga:"+gt_24ga+", still_births:"+still_births+", no_of_lbws:"+no_of_lbws+", no_below_2000:"+no_below_2000+", no_of_ob_lbws:"+no_of_ob_lbws+", u_id:"+u_id+", pid1:"+pid1+",pid2:"+pid2+",epic:"+epic+",thayi_card_no:"+thayi_card_no+", uid:"+uid+", time_of_birth:"+time_of_birth+", community_from:"+community_from+",baby_status:"+baby_status+", mother_name:"+mother_name+", sex:"+sex+", phone1:"+phone1+", community_to:"+community_to+", dob:"+dob+", taluk_to:"+taluk_to+", birth_weight:"+birth_weight+", taluk_from:"+taluk_from+", husband_name:"+husband_name+", phone2:"+phone2+", surveytype:"+surveytype+" ]";
	}*/
	 
	public static void main(String[] args) 
	{
		// TODO Auto-generated method stub
	}
}
