//My analysis script, created by Moses Ngari on xxxxx

log using analysis0.log,replace

//Change my directory
cd "C:\Users\mngari\OneDrive - Kemri Wellcome Trust\Statistical training"
dir

//Import data from .csv
import delimited using birth_weight.csv,varnames(1) clear

//describe the variables in the dataset
des






//close the log file
log close

