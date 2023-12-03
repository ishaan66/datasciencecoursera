Here were the steps I performed:

1. Load Packages
2. Set Path and Download Data
3. Load Activity Labels and Features and save into 'measurements'
4. Load Train Datasets and save into 'train'
5. Load Test Datasets and save into 'test'
6. Merge Datasets and save into 'combined'
7. Convert ClassLabels to ActivityName and save into 'combined[["Activity"]]'
8. Factorize SubjectNum and save into 'combined[["SubjectNum"]]'
9. Reshape Data for Tidy Format
10. Write Tidy Data to File