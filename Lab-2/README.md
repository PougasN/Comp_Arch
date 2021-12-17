# Computer Architecture  
## Assignment 2: Design Space Exploration with Gem5.
### Lab B / Group 7
#### Pougaridis Nikolaos 8038
#### Spaias Georgios 8910


## **Βήμα 1**

### Ερώτημα 1

Υλοιποιώντας το [runSpec_cpu2006.sh](https://github.com/PougasN/Comp_Arch/blob/main/Lab-2/runSpec_cpu2006.sh) και μέσα απο το παραγόμενο αρχείο [test_info.txt](https://github.com/PougasN/Comp_Arch/blob/main/Lab-2/test_info.txt) έχουμε τα παρακάτω δεδομένα.

| Parameter  | Value |
| ------------- | ------------- |
| Cache Line size  | 64  |
| L1 dcache size  | 64kB  |
| L1 dcache associativity  | 2  |
| L1 icache size  | 32kB  |
| L1 icache associativity  | 2  |
| L2 cache size  | 2MB  |
| L2 cache associativity  | 8  |

### Ερώτημα 2

Καταγράφοντας τα δεδομένα για τα εκάστοτε benchmark και χρησιμοποιώντας τις πληροφορίες για το καθένα από αυτά έχουμε τα παρακάτω γραφήματα:

![image](https://user-images.githubusercontent.com/81879767/146050784-4213a4bf-f145-4865-ac59-ce3112961eb3.png)
![image](https://user-images.githubusercontent.com/81879767/146051677-8ade9996-4542-4e66-8a31-14cefdd74884.png)
![image](https://user-images.githubusercontent.com/81879767/146051706-37002c9c-3872-4bb2-b609-de2f44fd1ed3.png)
![image](https://user-images.githubusercontent.com/81879767/146051718-73ed6040-cdd1-4e3e-a050-aca3bee29023.png)
![image](https://user-images.githubusercontent.com/81879767/146051730-5863c9de-f779-4932-bcbf-eaff05583113.png)

Παρατηρήσεις: !!!

### Ερώτημα 3

Αρχικά με τα default options έχουμε: ``system.clk_domain.clock 1000`` και ``system.cpu_clk_domain.clock 500`` άρα ρολόι χρονισμού για την προσομοίωση στα 2GHz. Την 2η φορά έχουμε ``system.clk_domain.clock 1000`` και ``system.cpu_clk_domain.clock 667`` άρα ρολόι χρονισμού για την προσομοίωση στα 1.5GHz.

Τρέχουμε ξανά τα benchmarks αυτή τη φορά όμως με το ρολόι χρονισμένο στα 1,5 GHz (--cpu=clock=1.5GHz) και οι πληροφορίες που παίρνουμε παράγουν τα παρακάτω γραφήματα:

![image](https://user-images.githubusercontent.com/81879767/146051754-04ac2749-cab7-4f05-98e8-e911da9826e2.png)
![image](https://user-images.githubusercontent.com/81879767/146051764-1688846a-7325-403a-bff5-919805aedf20.png)
![image](https://user-images.githubusercontent.com/81879767/146051780-40985c70-ea7e-42f3-a07c-8d6d426ed994.png)
![image](https://user-images.githubusercontent.com/81879767/146051791-e660438d-029e-4c85-aade-7d755dc628fa.png)
![image](https://user-images.githubusercontent.com/81879767/146051799-73a156ef-d4c0-41b9-8b0b-e3ff46931815.png)

Παρατηρήσεις: !!!

## **Βήμα 2**

Ο χώρος των δυνατών συνδιασμών για τα χαρακτηρστικά του simulation είναι πολυ μεγάλος ωστε να δοκιμάσουμε κάθε συνδιασμό για βελτιστοποίηση του συστήματος.Απο τα γραφήματα και τις πληροφορίες του βήματος 1 όμως, βλέπουμε τις αδυναμίες του setup μας για κάθε benchmark και συνεπώς μπορούμε να επικεντρωθούμε στους τομείς αυτούς.

Για την αυτοματοποίηση των Benchmark tests φτίαξαμε και χρησιμοποιήσαμε το shell script **run_benchmarks.sh** το οποίο παίρνει σαν Input ενα .ini αρχείο για την εισαγωγή των επιλογών και των πληροφοριών κάθε benchmark.

Έτσι απο τις πληροφορίες για το **cpi**, **L1_data miss rate**, **L1_instruction miss rate** και **L2 miss rate** κάνουμε για το κάθε benchmark την εξής ανάλυση:

### **Specbzip2**

Απο τα γραφήματα στο βήμα 1 καταλαβαίνουμε πως απαιτούνται αλλαγές κυρίως στην **L1 data cache** και ίσως στο **L2 cache**.  
Για το L1_d  βλεπουμε σχετικά αυξημένο miss rate επομένως:
  
  * Αυξάνουμε το μέγεθος (32kB->64kB).
  * Αυξάνουμε το Associativity (2->4).

Αντίστοιχα και στο L2 βλέπουμε σχετικά υψηλό miss rate και ετσι:

  * Αυξάνουμε το L2 size (2MB->4MB)
  * Aν δεν ήταν ηδη 8-way το associativity θα προτείνονταν αύξηση του.
  * Αύξηση του Cache line (64->128).

![bzip_cpi](https://github.com/PougasN/Comp_Arch/blob/main/Lab-2/Graphs/bzip2/bzip_cpi.png)

### **Specmcf**

Απο τις πληροφορίες του βήματος 1 βλέπουμε πως για το mcf πρέπει να εστιάσουμε στην **L1 Instruction cache**.  
Βλέπουμε στο L1_i υψιλό miss rate και συνεπώς προτείνεται:

* Αύξηση του L1_i size (32kB->128kB).
* Αύξηση του L1_i Associativity (2->8).

![mcf_cpi](https://github.com/PougasN/Comp_Arch/blob/main/Lab-2/Graphs/mcf/mcf_cpi.png)

### **Spechmmer**

To hmmer είχε ακόμα και με το default setup πολύ καλο cpi και χρόνο εκτέλεσης.Παρ'όλα αυτά, παρουσιάζει μικρή αυξηση στα miss rates των L1_Instruction Cache και L2 Cache.  
Επομένως ως βελτίωση για το L1_i προτείνεται:
  
  * Αύξηση του μεγέθους του L1_i (32kB->64kB).
  * Αύξηση του Associativity (2->4).

Kαι για το L2 cache προτείνεται:

* Αύξηση του L2 size (2MB-4MB).
* (Aν δεν ήταν ηδη 8-way το associativity θα προτείνονταν αύξηση του.)
  
![hmmer_cpi](https://github.com/PougasN/Comp_Arch/blob/main/Lab-2/Graphs/hmmer/hmmer_cpi.png)

### **Specsjeng**

Απο τα διαγράμματα του βήματος 1 βλέπουμε πως το sjeng παρουσιάζει πολύ υψιλό L1 Data Cache miss rate και πολύ υψιλό L2 miss rate.  

Έτσι, για την βελτίωση του L1 data cache θα πρέπει να:

* Αυξήσουμε το L1_d Size(64kB->128kB)
* Αυξήσουμε το Αssociativity (2->8)

Επιπλέον για την βελτίωση του L2 μπορούμε να:

* Αυξήσουμε το L2 Size (2MB->4MB)
* Αυξήσουμε το Cache Line μας (64->128)
  
![sjeng_cpi](https://github.com/PougasN/Comp_Arch/blob/main/Lab-2/Graphs/sjeng/sjeng_cpi.png)


### **Speclibm**

Τέλος για το libm βλέπουμ και πάλι αυξημένο miss rate στα L1 data cache και L2 cache και συνεπώς επικεντρωνομασται στην αλλγή αυτών.

Έτσι, για την βελτίωση του L1 data cache θα πρέπει να:

* Αυξήσουμε το L1_d Size(64kB->128kB)
* Αυξήσουμε το Αssociativity (2->8)

Για την βελτίωση του L2 μπορούμε να:

* Αυξήσουμε το L2 Size (2MB->4MB)
* Αυξήσουμε το Cache Line μας (64->128)

![libm_cpi](https://github.com/PougasN/Comp_Arch/blob/main/Lab-2/Graphs/libm/libm_cpi.png)

