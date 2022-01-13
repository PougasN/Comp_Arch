# Computer Architecture  
## Assignment 3: Energy-Delay-Area Product Optimization (gem5 + McPAT).
### Lab C / Group 7
#### Pougaridis Nikolaos 8038
#### Spaias Georgios 8910


## **Βήμα 1**

### Ερώτημα 1

### Ερώτημα 2

### Ερώτημα 3

#### Έχοντας μπαταρία συγκεκριμένης χωρητικότητας η διάφορά στην διάρκεια ζωής για 2 διαφορετικούς επεξεργαστές οφείλεται στο energy efficiency τους. Ένας τρόπος μέτρησης του    energy efficiency αποτελεί το Performance Per Watt το οποίο μπορεί να ορισθεί ως Flops per Watt και κατ'επέκταση ως συνάρτηση της συχνότητας λειτουργίας του kai του average power consumption του CPU.

        PPW=constant* Frequency/Avg_pwr

#### Έτσι στην περίπτωση που έχουμε δύο επεξεργαστές με κατανάλωση 25 Watt και 35 Watt και για ίδια workloads έχουμε:

        PPW_1=c*f_1/25 και PPW_2=c*f_2/35

#### Άρα ο 2ος επεξεργαστής μπορεί να είναι πιο efficient παρα την μεγαλύτερη κατανάλωση του έαν έχει επαρκώς μεγάλη συχνότητα, αυξάνοντας έτσι το PPW και το ποσοστό του χρόνου που έιναι αδρανής.

        PPW_2>PPW_1=>f_2>35/25*f_1=>f_2>1.4*f_1

#### Εάν γνωρίζουμε την average κατανάλωση ενός επεξεργαστή μπορούμε να βρούμε απο το output του McPAT την συχνότητα και συνεπώς να συγκρίνουμε δύο τυπους επεξεργαστών. Δυστυχώς όμως, απο το output του McPAT παίρνουμε μόνο peak power consumption και όχι average.

### Ερώτημα 4

#### Xeon 
    Peak Power = 134.938 W
      Total Leakage = 36.8319 W
      Peak Dynamic = 98.1063 W
    Runtime Dynamic = 72.9199 W

#### ARM A9 2GHz
     Peak Power = 1.74189 W
      Total Leakage = 0.108687 W
      Peak Dynamic = 1.6332 W
    Runtime Dynamic = 2.96053 W


#### P_Xeon= Runtime_dynamic + Total_Leakage= 72.9199 + 36.8319= 109.7518

#### P_ARM = Runtime_dynamic + Total_Leakage =2.96053 + 0.108687= 3.069217

#### Κατα την εκτέλεση της εφαρμογής η ενέργεια που καταναλώνει ο κάθε επεξεργαστής θα είναι:

#### Ε_Xeon= P_Xeon* Δt_Xeon

#### E_Arm= P_ARM* Δt_ARM

#### Υποθέσαμε όμως πως Δt_ARM = 40*Δt_Xeon
#### Άρα έχουμε:

#### Ε_Xeon/E_ΑΡΜ=P_Xeon* Δt_Xeon/(P_ARM* Δt_ARM)=35,758*(Δt_Xeon/Δt_ARM)=35,758/40= 0,8939

#### Αρα κατα την εκτέλεση ο Xeon είναι πιο energy efficient απο τον ARM, αλλά εφόσον δεν έχουμε διακοπή λειτουργίας του συστήματος μετα την εκτέλεση της εφαρμογής το μεγαλύτερο ποσοστό κατανάλωσης ενέργειας οφείλεται στην στατική ισχύ (Total Leakage) όπου:

    P_static_Xeon= 338,8 * P_static_ARM 

#### και συνεπώς ο Xeon δεν μπορει να είναι πιο energy efficient απο τον ARM στο παρών σενάριο
