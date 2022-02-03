# Computer Architecture  
## Assignment 3: Energy-Delay-Area Product Optimization (gem5 + McPAT).
### Lab C / Group 7
#### Pougaridis Nikolaos 8038
#### Spaias Georgios 8910


## **Βήμα 1**

### Ερώτημα 1

 Στην διαδικασία επικύρωσης χρησιμοποιούνται in-order καθώς και out-of-order, μονοπύρηνοι αλλά και πολυπύρηνοι επεξεργαστές. Έτσι καταλήγουμε σε ένα περιεκτικό και λεπτομερές αποτέλεσμα. Συγκρίνοντας τους Niagara και Niagara2 δοκιμάζουμε την ικανότητα μας να διατηρούμε την ακρίβεια ακόμα και μεταξύ διαφορετικών γενιών. Η διαδικασία βασίζεται σε δημοσιευμένα δεδομένα για τους αναφερόμενους επεξεργαστές τα οποία περιλαμβάνουν, την ταχύτητα ρολογιού, τις θερμοκρασίες λειτουργίας και τις παραμέτρους αρχιτεκτονικής.

 Ως όριο χρησιμοποιείται ο χρόνος κύκλου του ρολογιού στο McPAT για τον προσδιορισμό των βασικών ιδιοτήτων του κυκλώματος πριν εφαρμοστούν άλλες βελτιστοποιήσεις ή αντισταθμίσεις. Επειδή ο ρυθμός ρολογιού λαμβάνεται ήδη υπόψη καθώς υπολογίζουμε και βελτιστοποιούμε power και area, εμφανίζονται μόνο τα αποτελέσματα για αυτά.

#### Οι επεξεργαστές οι οποίοι χρησιμοποιούνται είναι οι εξής : 
        the 90nm Niagara processor        [24] running at 1.2GHz with a 1.2V  power supply
        the 65nm Niagara2 processor       [31] running at 1.4GHz with a 1.1V  power supply
        the 65nm Xeon processor           [37] running at 3.4GHz with a 1.25V power supply
        the 180nm Alpha 21364 processor   [17] running at 1.2GHz with a 1.5V  power supply

### Ερώτημα 2

 *There are several factors contributing to the CPU power consumption; they include dynamic power consumption, short-circuit power consumption, and power loss due to transistor
leakage currents:*

	{\displaystyle P_{cpu}=P_{dyn}+P_{sc}+P_{leak}}P_{{cpu}}=P_{{dyn}}+P_{{sc}}+P_{{leak}}

*The dynamic power consumption originates from the activity of logic gates inside a CPU. When the logic gates toggle, energy is flowing as the capacitors inside them are charged
 and discharged. The dynamic power consumed by a CPU is approximately proportional to the CPU frequency, and to the square of the CPU voltage:*

	{\displaystyle P_{dyn}=CV^{2}f}{\displaystyle P_{dyn}=CV^{2}f}

*where C is the switched load capacitance, f is frequency, V is voltage.*

*When logic gates toggle, some transistors inside may change states. As this takes a finite amount of time, it may happen that for a very brief amount of time some transistors are 
conducting simultaneously. A direct path between the source and ground then results in some short-circuit power loss ({\displaystyle P_{sc}}{\displaystyle P_{sc}}). The magnitude
of this power is dependent on the logic gate, and is rather complex to model on a macro level.*

*Power consumption due to leakage power ({\displaystyle P_{leak}}{\displaystyle P_{leak}}) emanates at a micro-level in transistors. Small amounts of currents are always flowing 
between the differently doped parts of the transistor. The magnitude of these currents depend on the state of the transistor, its dimensions, physical properties and sometimes 
temperature. The total amount of leakage currents tends to inflate for increasing temperature and decreasing transistor sizes.*

*Both dynamic and short-circuit power consumption are dependent on the clock frequency, while the leakage current is dependent on the CPU supply voltage. It has been shown that the
energy consumption of a program shows convex energy behavior, meaning that there exists an optimal CPU frequency at which energy consumption is minimal for the work done.*



Σύμφωνα με τα παραπάνω καθώς και άλλες πληροφορίες των papers που περιγράφουν το McPAT συμπεραίνουμε ότι Dynamic Power είναι η ωφέλιμη ισχύς του επεξεργαστή κατά την λειτουργία του, ενώ Leakage Power είναι η ισχύς απώλειων του επεξεργαστή.

Αν προσπαθήσουμε να τρέξουμε διαφορετικά προγράμματα σε έναν επεξεργαστή θα επηρεαστεί μόνο το Dynamic Power επειδή εξαρτάται από τη συχνότητα λειτουργίας του επεξεργαστή ,η οποία σχετίζεται με τις υπολογιστικές απαιτήσεις ενός προγράμματος. Το Leakage Power το οποίο εξαρτάται απο την τάση τροφοδοσίας παραμένει το ίδιο για κάθε πρόγραμμα.

Η ισχύς ωφέλιμη ή απωλειών δεν επηρεάζεται από την χρονική διάρκεια του εκάστοτε προγράμματος.

### Ερώτημα 3

 Έχοντας μπαταρία συγκεκριμένης χωρητικότητας η διάφορά στην διάρκεια ζωής για 2 διαφορετικούς επεξεργαστές οφείλεται στο energy efficiency τους. Ένας τρόπος μέτρησης του energy efficiency αποτελεί το **Performance Per Watt** το οποίο μπορεί να ορισθεί ως **Flops per Watt** και κατ'επέκταση ως συνάρτηση της συχνότητας λειτουργίας του και του average power consumption του CPU.

```PPW = constant* Frequency/Avg_pwr```

Έτσι στην περίπτωση που έχουμε δύο επεξεργαστές με κατανάλωση **25 Watt** και **35 Watt** και για ίδια workloads έχουμε:

```PPW_1 = c*f_1/25 και PPW_2 = c*f_2/35```

 Άρα ο 2ος επεξεργαστής μπορεί να είναι πιο efficient παρα την μεγαλύτερη κατανάλωση του έαν έχει επαρκώς μεγάλη συχνότητα, αυξάνοντας έτσι το PPW και το ποσοστό του χρόνου που έιναι αδρανής.

```PPW_2 > PPW_1 => f_2 > 35/25*f_1 => f_2 > 1.4*f_1```

Εάν γνωρίζουμε την average κατανάλωση ενός επεξεργαστή μπορούμε να βρούμε απο το output του McPAT την συχνότητα και συνεπώς να συγκρίνουμε δύο τυπους επεξεργαστών. Δυστυχώς όμως, απο το output του McPAT παίρνουμε μόνο peak power consumption και όχι average.

### Ερώτημα 4

### Xeon 
    	Peak Power = 134.938 W
     	Total Leakage = 36.8319 W
      	Peak Dynamic = 98.1063 W
    	Runtime Dynamic = 72.9199 W

### ARM A9 2GHz
		Peak Power = 1.74189 W
		Total Leakage = 0.108687 W
		Peak Dynamic = 1.6332 W
		Runtime Dynamic = 2.96053 W


```P_Xeon= Runtime_dynamic + Total_Leakage= 72.9199 + 36.8319= 109.7518```

```P_ARM = Runtime_dynamic + Total_Leakage =2.96053 + 0.108687= 3.069217```

Κατα την εκτέλεση της εφαρμογής η ενέργεια που καταναλώνει ο κάθε επεξεργαστής θα είναι:

```Ε_Xeon= P_Xeon* Δt_Xeon```

```E_ARM= P_ARM* Δt_ARM```

Υποθέσαμε όμως πως Δt_ARM = 40*Δt_Xeon
Άρα έχουμε:

```Ε_Xeon/E_ΑRΜ=P_Xeon* Δt_Xeon/(P_ARM* Δt_ARM)=35,758*(Δt_Xeon/Δt_ARM)=35,758/40= 0,8939```

Αρα κατα την εκτέλεση ο Xeon είναι πιο energy efficient απο τον ARM, αλλά εφόσον δεν έχουμε διακοπή λειτουργίας του συστήματος μετα την εκτέλεση της εφαρμογής το μεγαλύτερο ποσοστό κατανάλωσης ενέργειας οφείλεται στην στατική ισχύ (Total Leakage) όπου:

```P_static_Xeon= 338,8 * P_static_ARM ```

 και συνεπώς **ο Xeon δεν μπορει να είναι πιο energy efficient απο τον ARM στο παρών σενάριο**.



## **Βήμα 2**

Για το 2ο βήμα της εργασίας, αρχικά παράγουμε τα [.xml](https://github.com/PougasN/Comp_Arch/tree/main/Lab-3/spec_PDF) αρχεία για κάθε configuration που χρησιμοποιήθηκε στο [2o Assignment](https://github.com/PougasN/Comp_Arch/tree/main/Lab-2/setups) με την βοήθεια του ```GEM5ToMcPAT.py``` (που μας δόθηκε) και του [```gem2mcpat.sh```](https://github.com/PougasN/Comp_Arch/blob/main/Lab-3/gem2mcpat.sh).

Στην συνέχεια τρέχουμε το McPAT με print_level 5 για όλα τα config μέσω του [```spec_mcpat.sh```](https://github.com/PougasN/Comp_Arch/blob/main/Lab-3/spec_mcpat.sh) και συγκεντρώνουμε όλες τις πληροφορίες στο [spec_mcpat_out](https://github.com/PougasN/Comp_Arch/tree/main/Lab-3/spec_mcpat_out) ανα benchmark.

Aπο τα αποτελέσματα που συγκεντρώσαμε και με την βοήθεια των scripts [```get_energy.sh```](https://github.com/PougasN/Comp_Arch/blob/main/Lab-3/get_energy.sh) και ```print_energy.py``` παίρνουμε πληροφορίες για την ενέργεια, το leakage, dynamic και runtime power του κάθε benchmark. 

Τέλος, τρέχοντας το [```format_results.sh```](https://github.com/PougasN/Comp_Arch/blob/main/Lab-3/format_results.sh) συγκεντρώσαμε όλη την απαραίτητη πληροφορία σε συνεκτική μορφή σε .csv αρχεία ανα Benchmark.


### Διαγράμματα EDAP ( Energy * Delay * Area ) συναρτήσει παραμέτρων.

#### Specbzip
![image](https://user-images.githubusercontent.com/81879767/152386993-c668f9e1-2adf-468e-a3a1-ff862b7dfe7e.png)

#### Spechmmer
![image](https://user-images.githubusercontent.com/81879767/152387801-3ab01e98-33e6-419d-a67c-8a55a9ed7b3c.png)

#### Speclibm
![image](https://user-images.githubusercontent.com/81879767/152387931-f137cd3e-7a98-4faf-945c-9f735a94efac.png)

#### Specmcf
![image](https://user-images.githubusercontent.com/81879767/152388485-a4af73fb-accd-4bd0-8ee8-5362381fdb08.png)

#### Specsjeng
![image](https://user-images.githubusercontent.com/81879767/152388703-78f8ce68-60e9-4260-9492-139d5d93a2a7.png)


### Διαγράμματα POWER ( Peak Power ) συναρτήσει παραμέτρων.

#### Specbzip
![image](https://user-images.githubusercontent.com/81879767/152387108-73f7a4ca-32da-43df-9821-858a66db8e68.png)

#### Spechmmer
![image](https://user-images.githubusercontent.com/81879767/152387512-78e03c85-b388-4837-a12c-f23456e16963.png)

#### Speclibm
![image](https://user-images.githubusercontent.com/81879767/152388059-f51d1665-e3cc-4478-98a5-ca243c87cd08.png)

#### Specmcf
![image](https://user-images.githubusercontent.com/81879767/152388614-4a1df2e8-be24-490e-b4e3-b798f76efb79.png)

#### Specsjeng
![image](https://user-images.githubusercontent.com/81879767/152388808-d6bcf716-73de-4157-bfa3-b8645c49516f.png)

### Διαγράμματα AREA συναρτήσει παραμέτρων.
 
 #### Specbzip
![image](https://user-images.githubusercontent.com/81879767/152386870-e6f3f49c-d2a3-4d6e-97d8-76af4573738c.png)

#### Spechmmer
![image](https://user-images.githubusercontent.com/81879767/152387642-815d3323-b736-4678-9ede-ae511933c540.png)

#### Speclibm
![image](https://user-images.githubusercontent.com/81879767/152388189-03589459-100d-435a-b939-7b9ce4adbde7.png)

#### Specmcf
![image](https://user-images.githubusercontent.com/81879767/152388313-0800626a-6cb5-4a4c-a737-67224e728797.png)

#### Specsjeng
![image](https://user-images.githubusercontent.com/81879767/152388936-6c07e231-2ba4-429f-9669-b3c323afabf7.png)


### ** Παρατηρήσεις**

Απο τα διαγράμματα παραπάνω μπορούμε να πάρουμε μια ιδέα για το πως κάθε παράμετρος σχεδιασμού ενός επεξεργαστή επηρεάζει το **EDAP** και το **Peak Power**. Τα πειράματα μας είναι περιορισμένα επομένως θα αρκεστούμε σε κάποιες ποιοτικές παρατηρήσεις.

Έτσι βλέπουμε:

* Αυξάνωντας το μέγεθος του Cache Line παρατηρούμε μια μείωση στο EDAP.
* Αύξηση του cache size του L1 (είτε data, είτε instruction) οδηγεί σε μια μικρή μείωση του EDAP.
* Η αύξηση του L1  cache Associativity οδηγεί σε μεγαλύτερη μείωση στο EDAP απο το size.
* Τέλος, η αύξηση του L2 size φαίνεται να οδηγεί σε μείωση του EDAP. 

Παρακάτω φαίνονται για κάθε Benchmark, τα config με το καλύτερο CPI * Cost (1η σειρά πίνακα) και με το καλύτερο EDAP (2η σειρά πίνακα).  

### Bzip2

|L1d Size|l1d Assoc|l1i Size|l1i Assoc|l2 Size|l2 Assoc|Cache Line| Cost | Cost * CPI | EDAP |
|--------|----------|------------------	|---------------|-------|-------|-------|----------|---|---|
| 64  	 | 2	    | 64 	       	| 2 		| 2048 	| 8 	| 64   	| 37.734375|``80.187`` | 528 |
| 128 | 2 | 64 | 2 | 4096 |8  | 128 	| 56.750	|116.018 | ``194``|
### Mcf

|L1d Size|l1d Assoc|l1i Size|l1i Assoc|l2 Size|l2 Assoc|Cache Line| Cost | Cost * CPI | EDAP |
|--------|----------|------------------|------------------|--------|----------|--------|----------|---|---|
| 64 | 4 | 32  | 4 | 2048 | 8 | 64 | 42.875	|``58.191`` | 69 |
| 64 | 4 | 32  | 4 | 2048 | 8 | 64 | 42.875	|58.191 | ``69``|

### Hmmer

|L1d Size|l1d Assoc|l1i Size|l1i Assoc|l2 Size|l2 Assoc|Cache Line| Cost | Cost * CPI | EDAP |
|--------|----------|------------------|------------------|--------|----------|--------|----------|---|---|
| 64 | 4 | 32 | 2 | 2048 | 8 | 64 | 39.875	|``56.268`` | 111.9 |
| 64 | 4 | 64 | 4 | 4096 | 8 | 64 | 53.500	|75.401 | ``66.7``  |

### Sjeng

|L1d Size|l1d Assoc|l1i Size|l1i Assoc|l2 Size|l2 Assoc|Cache Line| Cost | Cost * CPI | EDAP |
|--------|----------|------------------|------------------|--------|----------|--------|----------|---|---|
| 64  | 4 | 64 | 4 | 4096   | 8       | 128 | 71.500	| ``485.856`` | 8549 |
| 128 | 8 | 64 | 4 | 4096   | 8       | 64  | 74.750	| 767.339   | ``6053`` |
### Libm

|L1d Size|l1d Assoc|l1i Size|l1i Assoc|l2 Size|l2 Assoc|Cache Line| Cost | Cost * CPI | EDAP |
|--------|----------|------------------|------------------|--------|----------|--------|----------|---|---|
| 64  | 4 | 64 | 2 | 2048 | 8 | 128 |48.500 | ``151.005`` | 1297.5 |
| 128 | 8 | 64 | 2 | 2048 | 8 | 64  | 46.750 |215.718 | ``783.2`` |

Απο τους πίνακες βλέπουμε πως ο βέλτιστος συνδιασμός απόδοσης-κόστους οδηγεί πάντοτε σε υψηλότερη κατανάλωση ισχύος και EDAP και αντιστρόφως η βελτιστοποίηση του EDAP οδηγεί σε υψηλό γινόμενο κόστους-CPI.

Καταλαβαίνουμε λοιπόν πως πρόκειται για αντικρουόμενες μετρικές και συνεπώς η σχεδίαση και το tuning του επεξεργασυή μας απαιτεί κάποιο context γύρω απο τον σκοπό και την χρήση του.

## **References:**

* https://www.hpl.hp.com/research/mcpat/micro09.pdf
* https://www.hpl.hp.com/research/mcpat/McPATAlpha_TechRep.pdf


## **Lab 3 Feedback**

...



