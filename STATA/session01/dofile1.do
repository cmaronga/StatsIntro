//Change directory
cd "C:\Users\mngari\OneDrive - Kemri Wellcome Trust\Statistical training"
dir

//Import data from .csv
import delimited using babies.csv,varnames(1) clear

//Saving data
save bw.dta,replace



//Import data from .csv
import delimited using birth_weight.csv,varnames(1) clear

//describe the variables in the dataset
des

//Label your variables
label variable id "ID number"
label variable matage "Mother age"
label variable ht "hypertension status"
label variable gestwks "gestational age in weeks"
label variable sex "Infant sex"
label variable bweight "Birth weight in grams"

//Raname variables
rename id subjid
rename ht hyper

//label variables
label define lhyper 1"Hypertension" 2"No hypertension"
label value hyper lhyper

label define lethnic 1"White" 2"Blacks" 3"Asian" 4"Latino"
label value ethnic  lethnic

//Create new variable
gen prem=0
replace prem=1 if gestwks<37
tabulate prem,missing

recode gestwks (20/36.99=1) (37/45= 0), gen(prem1)
tabulate prem1,missing

//Label premature
lab def lprem 0"Mature" 1"Premature"
lab val prem prem1 lprem

//Create new variable: LBW
recode bweight (500/2499=1) (2500/5000= 0), gen(lbw)

//Label lbw
lab def llbw 0"Normal birth weight" 1"Low Birth weight"
lab val lbw llbw
lab var lbw "Low birth weight"

//Destring
gen str nsex="1" if sex=="Male"
replace nsex="2" if sex=="Female"

destring nsex,replace

//label sex
lab def lsex 1"Male" 2"Female"
lab val nsex lsex

//Dealing with dates
//date of birth
gen birth_date=date(dob,"DMY")
format birth_date %d

//Date of admission
gen adm_date=date(date_admn,"DMY")
format adm_date %d


//merge
**Dataset one
use lab_results0.dta,clear
sort subjid

save lab_results0.dta,replace

**Dataset two
use section5.dta,clear
sort subjid

save section5.dta,replace

**Merge
use lab_results0.dta,clear

merge 1:1 subjid using section5.dta


//Exporing data
import delimited using birth_weight.csv,varnames(1) clear

//Female children
tab sex,missing

//Crosstabs
tab prem lbw,row
table lbw, contents(freq mean gestwks)
table lbw, contents(freq mean gestwks mean bweight mean matage )
tab lbw,summ(bweight)

//summarize
summ matage 
summ matage gestwks bweight

//bysort
bysort ethnic:tab lbw,m

//if function
 tab lbw  if ht==1,m
 tab lbw  if ht==2,m
 tab lbw  if ht==1 & ethnic==1
 tab lbw  if ht==1 & ethnic==2
 

 
//graphs
import delimited using birth_weight.csv,varnames(1) clear

//scatter plots
twoway scatter bweight gestwks
twoway scatter bweight gestwks || lfit bweight gestwks
twoway scatter bweight gestwks,xline(37)
twoway scatter bweight gestwks || lfit bweight gestwks,xline(37)
twoway scatter bweight gestwks || lfitci bweight gestwks,xline(37)
twoway scatter bweight gestwks || lfitci bweight gestwks,yline(2500)
twoway scatter bweight gestwks,xlab(25(5)45) ylab(500(1000)6000)
twoway scatter bweight gestwks,xlab(25(5)45) ylab(500(1000)6000) by(sex)
twoway scatter bweight gestwks,xlab(25(5)45) ylab(500(1000)6000) by(ht)
//Histogram
histogram bweight,freq
histogram bweight,normal freq xline(2500)
//Box plot
graph box bweight, over(sex) title (Birth weight Vs sex) ytitle(Birth weight)


