# Computer Architecture  
## Assignment 1: Introduction to Gem5.
### Lab B / Group 7
#### Pougaridis Nikolaos 8038
#### Spaias Georgios 8910




### Ερώτημα 1

Ανοίγοντας το starter_se.py βλέπουμε πως οι βασικές παράμετροι που περνάμε στο simulation script είναι οι εξής:
1. **--cpu** \
   τύπος επεξεργαστή:
   * "Atomic": AtomicSimpleCPU (default)
   * "Minor": MinorCPU
   * "HPI" : HPI.HPI
2. **--cpu-freq**\
  Συχνότητα-ρολόι επεξεργαστή:1 GHz (default)
4.  **--num-cores**\
    Aριθμός πυρήνων επεξεργαστή: 1 (default)
5.    **--mem-type** \
   Τύπος μνήμης που χρησιμοποιούμε: DDR3_1600_8x8 (default)
6. **--mem-channels** \
    Αριθμός καναλιών μνήμης: 2 (default)
7. **--mem-ranks** \
   A memory rank is a block or area of data that is created using some, or all, of the memory chips on a module.
8.    **--mem-size** \
   μέγεθος μνήμης: 2GB (default)


Mπορούσαμε να αλλάξουμε τη συχνότητα λειτουργίας του συστήματος χρησιμοποιώντας το flag **--cpu-freq="Χ"** οπου Χ η τιμή της συχνότητας που θέλουμε.




### Ερώτημα 2


Αρχικά κανουμε simulate την εκτέλεση του **hello** με το scripit **starter_se.py** με την εντολή στο directory του gem5:


   `` ./build/ARM/gem5.opt configs/example/arm/starter_se.py --cpu=minor tests/test-progs/hello/bin/arm/linux/hello``


Στο directory m5out βρισκουμε τα παραγόμενα απο την εξομοίωση αρχεία: stats.txt, config.json και config.ini τα οποία περιέχουν πληροφορίες για το configuration του simulated συστήματος και στατιστικά.

Ετσι βλέπουμε τις μετρήσεις:
* **sim_secon**s: 0.000035 (Number of seconds simulated)
* **sim_insts**: 5027 (Number of instructions simulated)
* **host_inst_rate**: 66131 (Simulator instruction rate (_inst/s_))

### Ερώτημα 3

Tα config.ini και config.json μας παρέχουν πληροφορίες για το σύστημα που εξομοιώνει ο gem5.

**a.** Θεωρώντας πως το σύστημα έχει ποινή αστοχίας (miss penalty) _L1= 6 cycles_ και ποινή αστοχίας (miss penalty) _L2= 50 cycles_ και 1 cycle cache hit/instruction execution μπορούμε να υπολογίσουμε το **_CPI_** του συστήματος με την εξίσωση


$ CPI=1+ \frac{(IL1.miss\_num+DL1.miss\_num)\times6 +L2.miss\_num\times50}{Total\_inst\_num} $


και απο το stats.txt έχουμε:
* ``l2.overall_misses::total``  = 474
* ``Icache.overall_misses::total`` = 327
* ``dcache.overall_misses::total`` = 177
* ``sim_insts`` =5027
  
Άρα τελικά έχουμε:
$
CPI=1+ \frac{(327+177)\times6 +474\times50}{5027}= 6.31
$

### Ερώτημα 4

In-order CPUs:

* **SimpleCPU**:
	
    Ο SimpleCPU είναι ένας πλήρως λειτουργικός τύπος επεξεργαστή, το οποίο είναι κατάλληλο για περιπτώσεις στις οποίες δεν είναι απαραίτητο ένα λεπτομερές μοντέλο.Τέτοιες περιπτώσεις είναι οι περίοδοι προθέρμανσης, η διαδικασία testing για την ομαλή λειτουργία ενός προγράμματος. Πρόσφατα επαναπρογραμματίστηκε έτσι ώστε να λειτουργεί σύμφωνα με το νέο σύστημα μνήμης και πλέον διακρίνετε σε τρεις κατηγορίες :BaseSimpleCPU , AtomicSimpleCPU, TimingSimpleCPU. 
	*	**BaseSimpleCPU**: Τον χρησιμοποιούμε για περιπτώσεις όπου, θέλουμε να καθορίζει  λειτουργίες για τον έλεγχο για διακοπές, τη ρύθμιση ενός αιτήματος ανάκτησης, τον χειρισμό της ρύθμισης πριν από την εκτέλεση, τον χειρισμό ενεργειών μετά την εκτέλεση και την προώθηση του υπολογιστή στην επόμενη εντολή. Δεν μπορεί να εκτελεστεί από μόνος του, καθώς πρέπει να χρησιμοποιήσει κλάσεις που κληρονομούνται απο τα άλλα δύο μοντέλα
	
    *	**AtomicSimpleCPU**: Είναι η έκδοση που χρησιμοποιεί πρόσβαση ατομικής μνήμης. Χρησιμοποιεί τις εκτιμήσεις καθυστέρησης για την ατομικές προσβάσεις για να υπολογίσει τον συνολικό χρόνο πρόσβασης της cache. Προέρχεται από την έκδοση BaseSimple  και εφαρμόζει λειτουργίες ανάγνωσης και εγγραφής μνήμης, και για κάθε τικ που καθορίζει τι συμβαίνει σε κάθε κύκλο. Τέλος, καθορίζει τη θύρα που χρησιμοποιείται για την σύνδεση στη μνήμη και συνδέει τον CPU με την μνήμη cache.
	
    *	**TimingSimpleCPU**: Είναι η έκδοση που χρησιμοποιεί προσβάσεις στη μνήμη χρονισμού. Σταματά τις προσβάσεις cache και περιμένει το σύστημα μνήμης να απαντήσει πριν προχωρήσει. Προέρχεται και αυτός από τον BaseSimple και ενσωματώνει το ίδιο σετ συναρτήσεων. Καθορίζει τη θύρα που χρησιμοποιείται για τη σύνδεση στη μνήμη και συνδέει τον CPU με την cache. Τέλος, ορίζει επίσης τις απαραίτητες λειτουργίες για το χειρισμό της απόκρισης από τη μνήμη στις προσβάσεις που αποστέλλονται.

* **MinorCPU Model**:
  
   Είναι ένα μοντέλο επεξεργαστή με σταθερό pipeline αλλά διαμορφώσιμες δομές δεδομένων και συμπεριφορά εκτέλεσης. Προορίζεται να χρησιμοποιηθεί για τη μοντελοποίηση επεξεργαστών με αυστηρή συμπεριφορά εκτέλεσης κατά σειρά και επιτρέπει την οπτικοποίηση της θέσης μιας εντολής στη διοχέτευση μέσω της μορφής/εργαλείου MinorTrace/minorview.py. Η πρόθεση είναι να παράσχει ένα πλαίσιο για μικροαρχιτεκτονικό συσχετισμό του μοντέλου με έναν συγκεκριμένο, επιλεγμένο επεξεργαστή με παρόμοιες δυνατότητες. Δεν διαθέτει την δυνατότητα multithreading.

#### Ερωτημα 4a.

 Στην συνέχεια γράψαμε ενα [πρόγραμμα σε C](https://github.com/PougasN/Comp_Arch/blob/main/fibonacci.c) προκειμένου να το προσομοιώσουμε με το script se.py και τα cpu-types TimingSimpleCPU και MinorCPU.  
 Επιλέξαμε να γράψουμε ένα πρόγραμμα υπολογισμού του n-οστού στοιχείου της σειράς fibonacci με την χρήση του Fast Doubling αλγορίθμου o οποίος βασίζεται στην ταυτότητα:  
$$Given~ F(k)~ and~ F(k+1),~ we~ can~ calculate~ these: $$  
$$F(2k)=F(k)[2F(k+1)−F(k)]$$  
$$F(2k+1)=F(k+1)^2+F(k)^2.$$

Λόγω των ορίων των unsigned long long int μπορούμε να υπολογίσουμε μέχρι και το 93ο στοιχείο της σειράς.  
Αφού φτίαξουμε το fibonacci.c το κάνουμε cross-compile με **arm-linux-gnueabihf-gcc** χρησιμοποιώντας το --static flag ως εξής:

        arm-linux-gnueabihf-gcc --static fibonacci.c -o fibonacci_arm  

ή χρησιμοποιώντας το Makefile που φτίαξαμε.

Τρεχοντας το simulation για τα δύο cpu-types και για διαφορετικά cpu-frequencies και memory types παίρνουμε τους παρακάτω χρόνους εξομοιωμένης εκτέλεσης.

<center>

|        | MinorCPU       | TimingSimpleCPU |
|--------|----------------|-----------------|
| f(MHz) | Time(μs)       | Time(μs)        |
| 1000   |     101,171    |     39,648      |
| 500    |     101,254    |     40,555      |
| 400    |     101,471    |     41,531      |
| 200    |     101,963    |     43,430      |
| 100    |     103,298    |     48,211      |
| 80     |     104,248    |     51,174      |
| 60     |     105,436    |     55,045      |
| 40     |     108,042    |     62,862      |
| 20     |     116,938    |     87,194      |
| 10     |     136,237    |     135,948     |
| 1      |     507,688    |     1015,103    |

</center>

***Table 1**: Χρόνοι simulation συναρτήσει της συχνότητας CPU με mem-type SimpleMemory*

<center>

|                            |     MinorCPU    |     TimingSimpleCPU    |
|----------------------------|-----------------|------------------------|
|     Memory Type            |     Time(μs)    |     Time(μs)           |
|     HBM_1000_4H_1x128      |     79,089      |     47,701             |
|     DRAMCtrl               |     -           |      -                 |
|     DDR3_2133_8x8          |     74,584      |     38,565             |
|     HBM_1000_4H_1x64       |     83,752      |     45,946             |
|     GDDR5_4000_2x32        |     -           |     -                  |
|     HMC_2500_1x32          |     -           |     -                  |
|     LPDDR3_1600_1x32       |     84,980      |     46,318             |
|     WideIO_200_1x128       |     94,606      |     55,537             |
|     QoSMemSinkCtrl         |     -           |     -                  |
|     DDR4_2400_8x8          |     74,626      |     38,756             |
|     DDR3_1600_8x8          |     75,958      |     39,892             |
|     DDR4_2400_4x16         |     75,485      |     40,178             |
|     DDR4_2400_16x4         |     74,626      |     38,756             |
|     SimpleMemory           |     101,171     |     39,648             |
|     LPDDR2_S4_1066_1x32    |     88,303      |     49,955             |
</center>

_**Table 2**: Χρόνοι simulation συναρτήσει της τεχνολογίας της μνήμης με CPU-frequency 1GHz_

**i)** Προκειμένου να μελετήσουμε πoιός τύπος CPU είναι πιο ευαίσθητος μετρήσαμε την διαφορά των χρόνων εκτέλεσης για έναν τύπο προς την μεταβολή της συχνότητας.

$$
 Sensitivity= \left\lvert \frac{Δt}{Δf} \right\rvert
$$


 Συγκρίνοντας για συγκεκριμένες μεταβολές την ευαισθησία:
 <center>

|           | MinorCPU       | TimingSimpleCPU |
|-----------|----------------|-----------------|
| Δf(MHz)   |           Sensitivity            |
| 1000-500  |     0.0002    |     0.0018       |
| 500-400   |     0.0022    |     0.0098       |
| 400-200   |     0.0025    |     0.0095       |
| 200-100   |     0.0134    |     0.0478       |
| 100-80    |     0.0475    |     0.1482       |
| 80-60     |     0.0594    |     0.1936       |
| 60-40     |     0.1303    |     0.3909       |
| 40-20     |     0.4448    |     1.2166       |
| 20-10     |     1.9299    |     4.8754       |
| 10-1      |     41.2723   |     97.6839      |

</center>

Απο τον παραπάνω πίνακα βλέπουμε οτι για κάθε μείωση της συχνότητας του CPU, ο **TimingSimpleCPU** παρουσιάζει πάντα μεγαλύτερη ευαισθησία απο τον MinorCPU. 

**ii)** Στα πειράματα για διαφορετικούς που κάναμε χρησιμοποιήσαμε το ίδιο μέγεθος μνήμης (default) και συνεπώς οποιαδήποτε διαφοροποίηση στον χρόνο για τον εκάστοτε τύπο επεξεργαστή οφείλεται στην τεχνολογία της μνήμης.  
Για να μετρήσουμε την ευαισθησία, στη συνέχεια, του κάθε τύπου χρησιμοποιήσαμε την μετρική της τυπικής απόκλισης. Μεγαλύτερη απόκλιση δείχνει μεγαλύτερη ευαισθησία στην τεχνολογία της μνήμης.

Απο τον πίνακα 2 παίρνουμε standard deviation **9.09** για τον **MinorCPU** και **5.70** για τον **TimingSimpleCPU** και συνεπώς συμπεραίνουμε πως ο ΜinorCPU εχει μεγαλύτερη ευαισθησία στην αλλαγή του mem-type.

#### Αιτιολόγηση

Τα παραπάνω αποτελέσματα δικαιολογούνται από τον τρόπο με τον οποίο λειτουργεί καθε cpu-type.

O TimingSImpleCPU  δεν έχει pipeline και επομένως είναι πρακτικά μη ρεαλιστικός. Ωστόσο είναι πολύ γρηγορότερος του MinorCPU o οποίος αποτελεί ενα αρκετά λεπτομερές και πολύ παραμετροποιήσιμο μοντέλο απο το οποίο μπορούν να να παραχθούν μοντέλα πραγματικών επεξεργαστών.   
H αυξημένη ευαισθησία του **TimingSimpleCPU** στις αλλαγές της συχνότητας λειτουργίας οφείλεται στην έλλειψη pipeline. Ως αποτέλεσμα ο επεξεργαστής κανει stall μέχρι να ολοκληρωθεί η εκτέλεση της κάθε εντολής και συνεπώς η απόδοση του μοντέλου αυτού εξαρτάται πλήρως απο την ταχύτητα εκτέλεσης της κάθε εντολής. Απο την άλλη ο MinorCPU εχει Pipeline τεσσάρων level και συνεπώς η απόδοση του εξαρτάται απο το fetch εντολών και δεδομένων και κατ' επέκταση απο τον τύπο μνήμης.

### References

1. [gem5 Documentation](https://www.gem5.org/documentation/)
2. [MinorCPU Introduction](https://nitish2112.github.io/post/gem5-minor-cpu/)
3. [Fast Doubling Fibonacci](https://www.nayuki.io/page/fast-fibonacci-algorithms)

### Κριτική

Αρχικά υπήρξε μια δυσκολία ως προς την εξοικείωση με το περιβάλλον Linux και την λειτουργία του, καθώς και την χρήση εργαλείων για το στήσιμο του VM για τα πειράματα πάνω στον gem5. Η κατανόηση των scripts έγινε κυρίως μέσα από την ανάγνωση των ιδίων, κάτι στο οποίο θα βοηθούσε η ύπαρξη κάποιου documentation και κάποιες περισσότερες πληροφορίες. 
Εφόσον καταφέραμε να βρούμε την σωστή σύνταξη κάποιων εντολών, η ανάγνωση των αποτελεσμάτων καθώς και ο πειραματισμός με την αλλαγή παραμέτρων έγινε πιο εύκολος. Τέλος, εξοικειωθήκαμε με το github ,αλλά και την γλώσσα markdown, που ήταν και τα δύο πολύ εύκολα.
