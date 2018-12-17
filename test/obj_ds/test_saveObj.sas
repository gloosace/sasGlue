

%macro test_saveObj;
	
	%local tres;%let tres=%createTempVar;%local &tres;
	%local data key obj members;

	%let members=id type value desc;


	%importLocalLib(local,saveObj);
	%clearLib(local);

	%newObj(members=&members,res=&tres);%let obj=&&&tres;


	* ---- APPEND TEST CREATE ----;
	%let data=local.saveObj_append_create;

	%let &obj.id=1;
	%let &obj.type=ABC;
	%let &obj.value=100000;
	%let &obj.desc=append test;
	%saveObj(data=&data,obj=&obj,key=&key);
	
	

	* ---- APPEND TEST ADD ----;
	%let data=local.saveObj_append_add;
	%copyDs(data=local.saveObj_append_create,out=&data);
	

	%let &obj.id=2;
	%let &obj.type=ABC;
	%let &obj.value=100000;
	%let &obj.desc=saveObj_append_new_obs;
	%saveObj(data=&data,obj=&obj,key=&key);


	%let &obj.id=3;
	%let &obj.type=ABCDEF;
	%let &obj.value=300000;
	%let &obj.desc=saveObj_append_new_obs_2;
	%saveObj(data=&data,obj=&obj,key=&key);
	

	* ---- APPEND TEST NEW VAR ----;

	%let data=local.saveObj_append_new_var;
	%copyDs(data=local.saveObj_append_create,out=&data);

	%addObjMembers(obj=&obj,members=value2);
	%let &obj.id=2;
	%let &obj.type=ABC;
	%let &obj.value=100000;
	%let &obj.value2=new value;
	%let &obj.desc=saveObj_append_new_var;
	%saveObj(data=&data,obj=&obj,key=&key);
	
	%dropObjMembers(obj=&obj,members=value2);
	%let &obj.id=3;
	%let &obj.type=ABC;
	%let &obj.value=200000;
	%let &obj.desc=saveObj_append_new_var_novalue2;
	%saveObj(data=&data,obj=&obj,key=&key);


	* ---- APPEND TEST EXTEND VAR LENGTH ----;

	%let data=local.saveObj_append_extend_length;
	%copyDs(data=local.saveObj_append_create,out=&data);
	
	%let key=;
	%let &obj.id=2;
	%let &obj.type=ABC;
	%let &obj.value=123456789012345678901234567890;
	%let &obj.desc=saveObj_append_extend_length;
	%saveObj(data=&data,obj=&obj,key=&key);

	%let key=;
	%let &obj.id=3;
	%let &obj.type=ABC;
	%let &obj.value=1234567890123456789012345678901234567890123456789012345678901234567890;
	%let &obj.desc=saveObj_append_extend_length_2;
	%saveObj(data=&data,obj=&obj,key=&key);
	
	
	* ---- APPEND TEST SPECIAL CHARACTERS ----;

	%let data=local.saveObj_append_special;
	%copyDs(data=local.saveObj_append_create,out=&data);
	
	%let key=;
	%let &obj.id=2;
	%let &obj.type=' abc ';									
	%let &obj.value=%quote(a='123' b='343' c='   ');		
	%let &obj.desc=saveObj_append_special;
	%saveObj(data=&data,obj=&obj,key=&key);

	%let key=;
	%let &obj.id=3;
	%let &obj.type=;										
	%let &obj.value=%str( abc );							
	%let &obj.desc=saveObj_append_special_2;
	%saveObj(data=&data,obj=&obj,key=&key);

	%let key=;
	%let &obj.id=4;
	%let &obj.type=.;									
	%let &obj.value=%str(,,,,,);						
	%let &obj.desc=saveObj_append_special_3;
	%saveObj(data=&data,obj=&obj,key=&key);
	
	* ---- KEY TEST CREATE ----;

	%let data=local.saveObj_key_create;

	%let key=id;
	%let &obj.id=1;
	%let &obj.type=ABC;
	%let &obj.value=100000;
	%let &obj.desc=saveObj_key_create;
	%saveObj(data=&data,obj=&obj,key=&key);
	
	
	* ---- KEY TEST ADD ----;
	%let data=local.saveObj_key_add;
	%copyDs(data=local.saveObj_key_create,out=&data);

	%let key=id;
	%let &obj.id=2;
	%let &obj.type=DEF;
	%let &obj.value=200000;
	%let &obj.desc=saveObj_key_add;
	%saveObj(data=&data,obj=&obj,key=&key);

	%let key=id;
	%let &obj.id=3;
	%let &obj.type=GHI;
	%let &obj.value=300000;
	%let &obj.desc=saveObj_key_add_2;
	%saveObj(data=&data,obj=&obj,key=&key);
	
	
	* ---- KEY TEST UPDATE ----;
	%let data=local.saveObj_key_update; 
	%copyDs(data=local.saveObj_key_add,out=&data);


	%let key=id;
	%let &obj.id=2;
	%let &obj.type=NEW_TYPE;
	%let &obj.value=100000;
	%let &obj.desc=saveObj_key_update;
	%saveObj(data=&data,obj=&obj,key=&key);

	%let key=id;
	%let &obj.id=2;
	%let &obj.type=DEF;
	%let &obj.value=NEW_VALUE;
	%let &obj.desc=saveObj_key_update_2;
	%saveObj(data=&data,obj=&obj,key=&key);


	* ---- KEY TEST DELETE ----;
	%let data=local.saveObj_key_delete;
	%copyDs(data=local.saveObj_key_create,out=&data);
	%let key=;
	%let &obj.id=2;
	%let &obj.type=ABC;
	%let &obj.value=100000;
	%let &obj.desc=saveObj_key_delete;
	%saveObj(data=&data,obj=&obj,key=&key);

	%let key=;
	%let &obj.id=2;
	%let &obj.type=DEF;
	%let &obj.value=200000;
	%let &obj.desc=saveObj_key_delete;
	%saveObj(data=&data,obj=&obj,key=&key);

	%let key=;
	%let &obj.id=2;
	%let &obj.type=GHI;
	%let &obj.value=300000;
	%let &obj.desc=saveObj_key_delete;
	%saveObj(data=&data,obj=&obj,key=&key);

	%getDsObs(data=&data,res=&tres);
	%put BEFORE SAVE &data OBS=&&&tres;

	%let key=id;
	%let &obj.id=2;
	%let &obj.type=UNIQUE;
	%let &obj.value=999999;
	%let &obj.desc=saveObj_key_delete;
	%saveObj(data=&data,obj=&obj,key=&key);

	%getDsObs(data=&data,res=&tres);
	%put AFTER SAVE &data OBS=&&&tres;

	* ---- KEY TEST NEW KEY VAR ----;
	%let data=local.saveObj_key_new_key;
	%copyDs(data=local.saveObj_key_add,out=&data);

	%addObjMembers(obj=&obj,members=value2);
	%let key=value2;
	%let &obj.id=2;
	%let &obj.type=ABC;
	%let &obj.value=100000;
	%let &obj.value2=new value;
	%let &obj.desc=saveObj_key_new_key;
	%saveObj(data=&data,obj=&obj,key=&key);


	* ---- MULTI KEYS TEST ----;
	%addObjMembers(obj=&obj,members=group);
	%dropObjMembers(obj=&obj,members=value2);

	* ---- MULTI KEYS TEST CREATE ----;

	%let data=local.saveObj_key_multi_create;
	%let key=group id;
	%let &obj.group=G1;
	%let &obj.id=1;
	%let &obj.type=ABC;
	%let &obj.value=100000;
	%let &obj.desc=saveObj_key_multi_create;
	%saveObj(data=&data,obj=&obj,key=&key);
	

	* ---- MULTI KEYS TEST ADD ----;
	%let data=local.saveObj_key_multi_add;
	%copyDs(data=local.saveObj_key_multi_create,out=&data);

	%let key=group id;
	%let &obj.group=G1;
	%let &obj.id=1;
	%let &obj.type=ABC;
	%let &obj.value=100;
	%let &obj.desc=saveObj_key_multi_add;
	%saveObj(data=&data,obj=&obj,key=&key);

	%let key=group id;
	%let &obj.group=G1;
	%let &obj.id=2;
	%let &obj.type=ABC;
	%let &obj.value=200;
	%let &obj.desc=saveObj_key_multi_add_2;
	%saveObj(data=&data,obj=&obj,key=&key);

	%let key=group id;
	%let &obj.group=G2;
	%let &obj.id=1;
	%let &obj.type=ABC;
	%let &obj.value=300;
	%let &obj.desc=saveObj_key_multi_add_3;
	%saveObj(data=&data,obj=&obj,key=&key);

	%let key=group id;
	%let &obj.group=G2;
	%let &obj.id=2;
	%let &obj.type=ABC;
	%let &obj.value=400;
	%let &obj.desc=saveObj_key_multi_add_4;
	%saveObj(data=&data,obj=&obj,key=&key);

	%let key=group id;
	%let &obj.group=G3;
	%let &obj.id=;
	%let &obj.type=ABC;
	%let &obj.value=500;
	%let &obj.desc=saveObj_key_multi_add_4;
	%saveObj(data=&data,obj=&obj,key=&key);

	%let key=group id;
	%let &obj.group=;
	%let &obj.id=2;
	%let &obj.type=ABC;
	%let &obj.value=600;
	%let &obj.desc=saveObj_key_multi_add_5;
	%saveObj(data=&data,obj=&obj,key=&key);

	%let key=group id;
	%let &obj.group=;
	%let &obj.id=;
	%let &obj.type=ABC;
	%let &obj.value=700;
	%let &obj.desc=saveObj_key_multi_add_6;
	%saveObj(data=&data,obj=&obj,key=&key);

	* ---- MULTI KEYS TEST UPDATE ----;

	%let data=local.saveObj_key_multi_update;
	%copyDs(data=local.saveObj_key_multi_add,out=&data);

	%let key=group id;
	%let &obj.group=G1;
	%let &obj.id=2;
	%let &obj.type=G1_2_NEW;
	%let &obj.value=1234567890123456789012345678901234567890;
	%let &obj.desc=saveObj_key_multi_update;
	%saveObj(data=&data,obj=&obj,key=&key);

	%let &obj.group=;
	%let &obj.id=2;
	%let &obj.type=NULL_2_NEW;
	%let &obj.value=1234567890123456789012345678901234567890;
	%let &obj.desc=saveObj_key_multi_update_2;
	%saveObj(data=&data,obj=&obj,key=&key)

	%let &obj.group=G3;
	%let &obj.id=;
	%let &obj.type=G3_NULL_NEW;
	%let &obj.value=1234567890123456789012345678901234567890;
	%let &obj.desc=saveObj_key_multi_update_3;
	%saveObj(data=&data,obj=&obj,key=&key);

	%let &obj.group=;
	%let &obj.id=;
	%let &obj.type=NULL_NULL_NEW;
	%let &obj.value=1234567890123456789012345678901234567890;
	%let &obj.desc=saveObj_key_multi_update_4;
	%saveObj(data=&data,obj=&obj,key=&key);


	%dropObj(&obj);

%mend;



%test_saveObj;

