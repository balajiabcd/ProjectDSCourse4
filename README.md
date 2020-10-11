# ProjectDSCourse4
DS course4 Project wee4

### Whit I did in this project.

1. First downloading the required zipfile in to a newly created directiory. And unzip it.
2. Now there are 3 each files in Test and Train directories in that unzipped file. Merging all in to one df variable called "allbind".
3. Next seletion of required mean and std columns in "allbind", with the help of features file. And assign it to another vareiable called "finaldf".
4. Then labelling all activity values, with the help of activity_lable.txt file.
5. Giving the corresponding names to the variables of the "finalfd".
6. Then summarise the means for all combinations of activities(6)\*subjcts(30). And put it in a variable called "newtidy".
7. Then saving the result with the help of "write.table()" function.
