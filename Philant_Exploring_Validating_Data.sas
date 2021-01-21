/*Using means, univariate, and freq to analyze the muscle dataset*/

*Importing the data first;
proc import datafile= "/home/u49706966/Muscle.csv" 
	dbms=csv
	out=muscle
	replace;
run;

*Displaying only the first ten(10)rows;
proc print data=muscle (obs=10);
run;


*Selecting some few columns in the data and displaying the fisrt 10 rows;

proc print data=muscle (obs=10);
	var Age Gender Knee_stance_even Ankle_stance_even Knee_stance_uneven Ankle_stance_uneven;
run;

* Calculating summary statistics. Remember it uses numerical values;
proc means data= muscle;
	var Knee_stance_even Ankle_stance_even Knee_stance_uneven Ankle_stance_uneven;
run;

*Using univariate statistics to examine cthe five extreme values;
proc univariate data= muscle;
	var Knee_stance_even Ankle_stance_even Knee_stance_uneven Ankle_stance_uneven;
run;


*Using frequency statistics to list unique values and frequencies;
proc freq data=muscle;
  tables Knee_stance_even Ankle_stance_even Knee_stance_uneven Ankle_stance_uneven;
run;

*Exercise
*1;
proc import datafile= "/home/u49706966/iEID Implement outcomes.29nov2020.xlsx"
	dbms=xlsx
	out=IEID
	replace;
run;

proc print data= IEID (obs=20);
	var studyarm districtname age_mom typeofresidence studyid racode;
run;

*Running summary statistics (means) with only mum age since it is the only numerical value in the data;
proc means data=IEID;
	var age_mom;
run;

*Using univariate statistics to examine extreme values;
proc univariate data=IEID;
   var age_mom;
run;


*Using frequency statistics to list unique values and frequencies;
proc freq data=IEID;
	tables age_mom;
run;


/* Filtering rows with where statement*/
proc import datafile= "/home/u49706966/StateData.csv"
	dbms=csv
	out=State_data
	replace;
run;

*where openness is greater or equal to 30. Remember is it case sensitive;
proc print data=State_data;	
	where openness>=30;
run;
	

* where governor is democrat. Single quote is also acceptable;
proc print data=State_data;	
	where governor="Democrat";
run;


*Single quote;
proc print data=State_data;	
	where governor='Democrat';
run;


*Where region is south and west;
proc print data=State_data;
	where region in ("South" "West");
run;


*Where date is on or after 10 January 2010. Note that there is no date column in the state dataset but for 
illustration purposes;

proc print data=state_data;
where date>= "10jan2010"d;
run;


*Compound statements: where region is Northeast and governor is republican. remember this is a conditional statement;
proc print data=state_data;
	where region="Northeast" and governor="Republican";
run;


* the OR statement. where region is Northeast or governor is republican; 
proc print data=state_data;
	where region="Northeast" or governor="Republican";
run;


*Creating macro variables;
*Importing the data first;
proc import datafile= "/home/u49706966/MATH660/diamonds.csv" 
	dbms=csv
	out=diamonds
	replace;
run;

proc print data= diamonds;
 where cut="Ideal" and price >=10000 and table>=55;
 var carat cut price color clarity;
run;

proc means data= diamonds;
 where cut="Ideal" and price >= 10000 and table>=55;
 var carat  price;
run;

*Creating macro variables to prodce the same output;
%let cut= Ideal;
%let price=10000;
%let table=55;
proc print data= diamonds;
 where cut="&cut" and price >="&price" and table>="&table";
 var carat cut price color clarity;
run;

proc means data= diamonds;
 where cut="&cut" and price >="&price" and table>="&table";
 var carat  price;
run;


*Formatting data values in results;
proc import datafile= "/home/u49706966/Muscle.csv" 
	dbms=csv
	out=muscle
	replace;
run;

*Rounding the Ankle_stance_even and Ankle_stance_uneven with a 3. format which round the values to the nearest whole number;

proc print data= muscle;
 format Ankle_stance_even Ankle_stance_uneven 3.;
run;

*Formatting date. Remember it is not a date date though.;

proc print data= muscle;
 format Ankle_stance_even Ankle_stance_uneven date9.;
run;

*Round to one decimal place;
proc print data= muscle;
 format Ankle_stance_even Ankle_stance_uneven 8.1;
run;

*Inserting  leading 0s and comma;
proc print data= muscle;
 format Ankle_stance_even z8. Ankle_stance_uneven COMMA8.1;
run;

*Other formats. currencies;
DOLLAR10.2 for formating dollar with two decimal places;
DOLLAR10. for the nearest dollar;
YEN7. for the yen;
EUROX10.2 for euros;

* Formating some columns with leading 0s.;
proc print data= muscle;
 format Ankle_stance_even Ankle_stance_uneven Z8.;
run;


*Sorting data. Gender ascending;
proc sort data= muscle out=muscle_sort;
 	by Gender;
run;


*Sort Age within gender in ascending;
proc sort data= muscle out=muscle_sort;
 	by Gender Age;
run;

*Sorting Gender by descending;
proc sort data= muscle
 	out=muscle_sort;
 	by descending Gender;
run;

*Sort by ascending Gender and descending Age within;
proc sort data= muscle out=muscle_sort;
 	by  Gender descending Age;
run;


*Removing duplicates;
proc sort data= muscle out=muscle_clean
	nodupkey dupout= muscle_dup;
	by _all_;
run;

* For the diamond dataset;
proc import datafile= "/home/u49706966/MATH660/diamonds.csv" 
	dbms=csv
	out=diamonds
	replace;
run;

*Removing duplicates;

proc sort data= diamonds out=diamonds_clean
	nodupkey dupout= diamonds_dup;
	by _all_;
run;
 





