# Computer Architecture  
## Assignment 3: Energy-Delay-Area Product Optimization (gem5 + McPAT).
### Lab C / Group 7
#### Pougaridis Nikolaos 8038
#### Spaias Georgios 8910


## **Βήμα 1**

### Ερώτημα 1

#### Στην διαδικασία επικύρωσης χρησιμοποιούνται in-order καθώς και out-of-order, μονοπύρηνοι αλλά και πολυπύρηνοι επεξεργαστές. Έτσι καταλήγουμε σε ένα περιεκτικό και λεπτομερές αποτέλεσμα. Συγκρίνοντας τους Niagara και Niagara2 δοκιμάζουμε την ικανότητα μας να διατηρούμε την ακρίβεια ακόμα και μεταξύ διαφορετικών γενιών. Η διαδικασία βασίζεται σε δημοσιευμένα δεδομένα για τους αναφερόμενους επεξεργαστές τα οποία περιλαμβάνουν, την ταχύτητα ρολογιού, τις θερμοκρασίες λειτουργίας και τις παραμέτρους αρχιτεκτονικής.

#### Ως όριο χρησιμοποιείται ο χρόνος κύκλου του ρολογιού στο McPAT για τον προσδιορισμό των βασικών ιδιοτήτων του κυκλώματος πριν εφαρμοστούν άλλες βελτιστοποιήσεις ή αντισταθμίσεις. Επειδή ο ρυθμός ρολογιού λαμβάνεται ήδη υπόψη καθώς υπολογίζουμε και βελτιστοποιούμε power και area, εμφανίζονται μόνο τα αποτελέσματα για αυτά.

#### Οι επεξεργαστές οι οποίοι χρησιμοποιούνται είναι οι εξής : 
        the 90nm Niagara processor        [24] running at 1.2GHz with a 1.2V  power supply
        the 65nm Niagara2 processor       [31] running at 1.4GHz with a 1.1V  power supply
        the 65nm Xeon processor           [37] running at 3.4GHz with a 1.25V power supply
        the 180nm Alpha 21364 processor   [17] running at 1.2GHz with a 1.5V  power supply

### Ερώτημα 2

There are several factors contributing to the CPU power consumption; they include dynamic power consumption, short-circuit power consumption, and power loss due to transistor
leakage currents:

	{\displaystyle P_{cpu}=P_{dyn}+P_{sc}+P_{leak}}P_{{cpu}}=P_{{dyn}}+P_{{sc}}+P_{{leak}}

The dynamic power consumption originates from the activity of logic gates inside a CPU. When the logic gates toggle, energy is flowing as the capacitors inside them are charged
 and discharged. The dynamic power consumed by a CPU is approximately proportional to the CPU frequency, and to the square of the CPU voltage:

	{\displaystyle P_{dyn}=CV^{2}f}{\displaystyle P_{dyn}=CV^{2}f}

where C is the switched load capacitance, f is frequency, V is voltage.

When logic gates toggle, some transistors inside may change states. As this takes a finite amount of time, it may happen that for a very brief amount of time some transistors are 
conducting simultaneously. A direct path between the source and ground then results in some short-circuit power loss ({\displaystyle P_{sc}}{\displaystyle P_{sc}}). The magnitude
of this power is dependent on the logic gate, and is rather complex to model on a macro level.

Power consumption due to leakage power ({\displaystyle P_{leak}}{\displaystyle P_{leak}}) emanates at a micro-level in transistors. Small amounts of currents are always flowing 
between the differently doped parts of the transistor. The magnitude of these currents depend on the state of the transistor, its dimensions, physical properties and sometimes 
temperature. The total amount of leakage currents tends to inflate for increasing temperature and decreasing transistor sizes.

Both dynamic and short-circuit power consumption are dependent on the clock frequency, while the leakage current is dependent on the CPU supply voltage. It has been shown that the
energy consumption of a program shows convex energy behavior, meaning that there exists an optimal CPU frequency at which energy consumption is minimal for the work done.



Σύμφωνα με τα παραπάνω καθώς και άλλες πληροφορίες των papers που περιγράφουν το McPAT συμπεραίνουμε ότι Dynamic Power είναι η ωφέλιμη ισχύς του επεξεργαστή κατά την λειτουργία του, ενώ Leakage Power είναι η ισχύς απώλειων του επεξεργαστή.

Αν προσπαθήσουμε να τρέξουμε διαφορετικά προγράμματα σε έναν επεξεργαστή θα επηρεαστεί μόνο το Dynamic Power επειδή εξαρτάται από τη συχνότητα λειτουργίας του επεξεργαστή ,η οποία σχετίζεται με τις υπολογιστικές απαιτήσεις ενός προγράμματος. Το Leakage Power το οποίο εξαρτάται απο την τάση τροφοδοσίας παραμένει το ίδιο για κάθε πρόγραμμα.

Η ισχύς ωφέλιμη ή απωλειών δεν επηρεάζεται από την χρονική διάρκεια του εκάστοτε προγράμματος.

### Ερώτημα 3

#### Έχοντας μπαταρία συγκεκριμένης χωρητικότητας η διάφορά στην διάρκεια ζωής για 2 διαφορετικούς επεξεργαστές οφείλεται στο energy efficiency τους. Ένας τρόπος μέτρησης του    energy efficiency αποτελεί το Performance Per Watt το οποίο μπορεί να ορισθεί ως Flops per Watt και κατ'επέκταση ως συνάρτηση της συχνότητας λειτουργίας του kai του average power consumption του CPU.

```PPW=constant* Frequency/Avg_pwr```

#### Έτσι στην περίπτωση που έχουμε δύο επεξεργαστές με κατανάλωση 25 Watt και 35 Watt και για ίδια workloads έχουμε:

```PPW_1=c*f_1/25 και PPW_2=c*f_2/35```

#### Άρα ο 2ος επεξεργαστής μπορεί να είναι πιο efficient παρα την μεγαλύτερη κατανάλωση του έαν έχει επαρκώς μεγάλη συχνότητα, αυξάνοντας έτσι το PPW και το ποσοστό του χρόνου που έιναι αδρανής.

```PPW_2>PPW_1=>f_2>35/25*f_1=>f_2>1.4*f_1```

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


```P_Xeon= Runtime_dynamic + Total_Leakage= 72.9199 + 36.8319= 109.7518```

```P_ARM = Runtime_dynamic + Total_Leakage =2.96053 + 0.108687= 3.069217```

#### Κατα την εκτέλεση της εφαρμογής η ενέργεια που καταναλώνει ο κάθε επεξεργαστής θα είναι:

```Ε_Xeon= P_Xeon* Δt_Xeon```

```E_Arm= P_ARM* Δt_ARM```

#### Υποθέσαμε όμως πως Δt_ARM = 40*Δt_Xeon
#### Άρα έχουμε:

```Ε_Xeon/E_ΑΡΜ=P_Xeon* Δt_Xeon/(P_ARM* Δt_ARM)=35,758*(Δt_Xeon/Δt_ARM)=35,758/40= 0,8939```

#### Αρα κατα την εκτέλεση ο Xeon είναι πιο energy efficient απο τον ARM, αλλά εφόσον δεν έχουμε διακοπή λειτουργίας του συστήματος μετα την εκτέλεση της εφαρμογής το μεγαλύτερο ποσοστό κατανάλωσης ενέργειας οφείλεται στην στατική ισχύ (Total Leakage) όπου:

```P_static_Xeon= 338,8 * P_static_ARM ```

#### και συνεπώς ο Xeon δεν μπορει να είναι πιο energy efficient απο τον ARM στο παρών σενάριο.

## **Βήμα 2**

### EDAP

![specbzip-EDAP](https://user-images.githubusercontent.com/81879767/150416936-b8244a0e-7d99-47dc-bda2-2f4a5a698cb0.png)
![spechmmer-EDAP](https://user-images.githubusercontent.com/81879767/150416968-c0c04bc7-44d7-4aeb-b46b-8a90497f3e36.png)
![speclibm-EDAP](https://user-images.githubusercontent.com/81879767/150420571-19ec2f5d-6fae-40be-8faa-3527008839cf.png)
![specmcf-edap](https://user-images.githubusercontent.com/81879767/150416989-10aa1c9a-93b5-4eb3-bffa-f9d53ef1cac8.png)
![specsjeng-edap](https://user-images.githubusercontent.com/81879767/150417022-43c41bf4-dd3f-4361-834e-5bfe34152ea7.png)

### POWER

![specbzip-power](https://user-images.githubusercontent.com/81879767/150420118-5c4aabad-bbb6-404f-a44a-48eb05c6e627.png)
![spechmmer-power](https://user-images.githubusercontent.com/81879767/150420126-105783e1-168a-405a-83d7-f15cb2815fd7.png)
![speclibm-power](https://user-images.githubusercontent.com/81879767/150420137-3110097b-c12c-47b6-8f63-ad53b451f34a.png)
![specmcf-power](https://user-images.githubusercontent.com/81879767/150420141-4ef06c96-7d5b-4728-9e41-16d3c7e11d66.png)
![specsjeng-power](https://user-images.githubusercontent.com/81879767/150420147-4973ce0d-eb51-460e-a18e-6f3ac14106f1.png)

### AREA

![specbzip-area](https://user-images.githubusercontent.com/81879767/150420165-9935529c-4d54-4d5c-9809-6bb14b6e3011.png)
![spechmmer-area](https://user-images.githubusercontent.com/81879767/150420169-08a9cf40-fe4f-42af-8a2c-153782516050.png)
![speclibm-area](https://user-images.githubusercontent.com/81879767/150420174-adc63d11-7ea2-43a1-86b1-56ef3a1efb85.png)
![specmcf-area](https://user-images.githubusercontent.com/81879767/150420182-aa53b54b-132d-4495-96e9-7dc6f7fcfb61.png)
![specsjeng-area](https://user-images.githubusercontent.com/81879767/150420189-37d9866f-33fd-485e-9ae5-a83a599fb75e.png)





