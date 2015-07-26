# CodeBook

## Variable description

**subjectID**: the subject who performed the activity test. range from 1:30.

**activityLabel**: 6 kinds of activity measured.

``` 
  activityID      activityLabel
1          1            WALKING
2          2   WALKING_UPSTAIRS
3          3 WALKING_DOWNSTAIRS
4          4            SITTING
5          5           STANDING
6          6             LAYING
```

For the rest columns are the features collected for the activity measurement. Detailed information can be found in the "features_info.txt" file.

## Structure of the tiny data.

`str(dt.tidy)`  180 rows and 68 variables

``` 
Classes ‘data.table’ and 'data.frame':	180 obs. of  68 variables:
 $ subjectID                : int  1 1 1 1 1 1 2 2 2 2 ...
 $ activityLabel            : Factor w/ 6 levels "LAYING","SITTING",..: 1 2 3 4 5 6 1 2 3 4 ...
 $ tBodyAcc-mean-X          : num  0.222 0.261 0.279 0.277 0.289 ...
 $ tBodyAcc-mean-Y          : num  -0.04051 -0.00131 -0.01614 -0.01738 -0.00992 ...
 $ tBodyAcc-mean-Z          : num  -0.113 -0.105 -0.111 -0.111 -0.108 ...
 ...
 
```

