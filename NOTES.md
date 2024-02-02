2024-02-01

Well whaddyaknow, there is a new draft recommendation!

Here are my notes about it:

>To do: narrow satisfying criteria to loinc 24606-6	MG Breast Screening (rather than a mammography value set). 
>
>Exclude 
>- BRCA1 or BRCA2 gene mutations
>- other hereditary genetic syndromes 
>- history of high-dose radiation to the chest at a young age
>- high-risk lesion on previous biopsies
>
>AKA "a genetic marker or syndrome associated with a high risk of breast cancer (e.g., BRCA1 or BRCA2 genetic mutations), a history of high-dose radiation therapy to the chest at a young age, or previous breast cancer or a high-risk breast lesion on previous biopsies."
>
>Follow the new draft! https://www.uspreventiveservicestaskforce.org/home/getfilebytoken/AhUGkt_VKfEYZKstAJzzzP
>Allow
>- digital breast tomosynthesis (3D mammography)

FYI here is the code for BRCA:
```
 2024 ICD-10-CM Diagnosis Code Z15.01
Genetic susceptibility to malignant neoplasm of breast

    2016 2017 2018 2019 2020 2021 2022 2023 2024 Billable/Specific Code POA Exempt 

    Z15.01 is a billable/specific ICD-10-CM code that can be used to indicate a diagnosis for reimbursement purposes.
    The 2024 edition of ICD-10-CM Z15.01 became effective on October 1, 2023.
    This is the American ICD-10-CM version of Z15.01 - other international versions of ICD-10 Z15.01 may differ.

```

Who needs to pay royalties to use [CPT content](https://www.ama-assn.org/practice-management/cpt/ama-cpt-licensing-overview)?

[Here](https://www.hl7.org/fhir/us/breast-radiology/2020MAY/StructureDefinition-MGBreastDensity.html) is a FHIR link for breast density categories. [Here](http://www.acr.org/Quality-Safety/Resources/BIRADS) is a link to the Bi-Rads atlas. 

It sure looks like BI-RADS is used in all sorts of breast imaging, including 2D and 3D. So for standard mammo we have [this](https://loinc.org/24606-6/) loinc and for digital mammo (which seems to be rapidly taking over) we have [this](https://loinc.org/72142-3/). 

Here is a [summary](https://loinc.org/search/?t=1&s=breast+screening) of all breast screening codes, some not applicable. 

So now begins the process of retiring the mammogram value set for two specific loinc codes: 72142-3 and 24606-6. 

02-02-2024

ICD10 codes for high-risk breast biopsy. 

>Atypical ductal hyperplasia (ADH) of the breast - D05.10,  Atypical hyperplasia of lactiferous duct (disorder) SCTID: 427785007
>Atypical lobular hyperplasia of breast (disorder) - SCTID: 450697004 (no icd10 exists)
> Lobular carcinoma in situ of breast (disorder) - SCTID: 109888004, (no ICD10)

A quick look at vsac reveals no code groupings like this. 