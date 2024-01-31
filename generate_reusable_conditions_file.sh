#!/bin/bash

# Define the input CSV file
inputFile="breast-cancer-diagnosis-codes.csv"

# Read each line
# while IFS=, read -r col1 col2 col3
# do
#     echo "  - resourceType: Condition"
#     echo "    code: $col1#$col2 $col3"
#     echo "    onsetDateTime: 2014-09-05"
#     echo "    verificationStatus: #confirmed"
#     echo ""
# done < "$inputFile"

while IFS= read -r line || [ -n "$line" ]
do
    IFS=, read -r col1 col2 col3 <<< "$line"
    echo "  - resourceType: Condition"
    echo "    code: $col1#$col2 $col3"
    echo "    onsetDateTime: 2014-09-05"
    echo "    verificationStatus: #confirmed"
    echo ""
done < "$inputFile"
