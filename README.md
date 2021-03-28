# The context dependency of pollinator interference
This repository contains the code and data for reproducing the analyses associated with:
  
*The context dependency of pollinator interference: how environmental conditions and co-foraging species impact floral visitation* [Ecology Letters] 

Author(s): Cervantes-Loreto, Alba; Ayers, Carolyn; Dobbs, Emily; Brosi, Berry; Stouffer, Daniel


Please email Alba Cervantes-Loreto (alba.cervantesloreto@pg.canterbury.ac.nz) with any questions.

## Organization
The repository consists of one data file `bombus_forgaging_data.csv` and a file of code in the programming language R, able to run the three models described in the main text `models.R`



### [data](data)

This file contains the data of single-species and multi-species trials described in the main text, and can be used to fit the three models described there as well. This data set has been cleaned for analysis as described in the section *Foraging trials and data structure* of the *Supplemental Information*. The data keeps track of *Bombus* individuals, each individual has its own unique ID, which can be found in the column `beeID`. The response variable is the time individual bumblebees spend between floral visits, measured in seconds, and found in the `column time_between_visits`. The column `neonic_treatment` is a dummy variable that keeps track if all bees in the trial were exposed to a sublethal dose of a neonicotinoid, in which case it takes a value of 1. The column `time_between_floral_refill` keeps track of the seconds before individual flowers could dispense a new sucrose reward and has three levels; 0 120 and 540. Finally, the abundance of co-foragers; *Bombus*, *Apis*, *Osmia* and *Megachile*  is displayed in the columns with the same name. 
Note that the column `Bombus`` displays the abundance of co-foragers, which is always one individual less than the total number of *Bombus* in a trial as it does not include the focal individual.


### [code](code)

The file `models.R` contains the code to fit the models described in the main text. The code reads the data contained in `bombus_forgaging_data.csv` It requires the installation of the package `brms` previous to the analyses. The code sequentially runs the three models described in the main text, and also saves each model fit as an RDS object into the working directory. 

# Warranty
Each model takes a considerable amount of time to run, but we do not guarantee convergence if the number of iterations or the specification of the models change.

All code is provided "as is" and without warranty.  If you know of more efficient or elegant ways of doing anything (of which there are likely many), we’d love to learn from you.