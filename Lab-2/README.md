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

![image](https://github.com/PougasN/Comp_Arch/blob/main/Lab-2/Graphs/bzip2/bzip_cpi.png)

