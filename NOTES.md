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

Now for BRCA:

Condition codes:

>ICD10 Z15.01 - Genetic susceptibility to malignant neoplasm of breast
>SNOMED 718220008 Hereditary breast and ovarian cancer syndrome (disorder)
>718220008 | Hereditary breast and ovarian cancer syndrome (disorder) |
>  en   Hereditary breast and ovarian cancer syndrome (disorder)
>.  en   Hereditary breast and ovarian cancer syndrome
>  en   Breast cancer is the most common cancer in women, accounting for 25% of all new cases of cancer. Most cases are sporadic, while 5-10% are estimated to be due to an inherited predisposition. Autosomal dominant alterations in two genes, BRCA1 and BRCA2, are likely to account for most familial cases of early-onset breast and/or ovarian cancer and for 3-4% of all breast cancer. The lifetime risk of developing hereditary breast cancer and/or ovarian cancer can reach 80%. For a given mutation in the susceptibility gene, disease severity and age at onset show great variability within and between breast cancer families, suggesting the involvement of other genetic as well as non-genetic factors.

Observation codes:

>BRCA1 gene mutation detected (finding) SCTID: 412734009 
>BRCA2 gene mutation detected (finding) SCT ID: 412738007

Here's a sampling of the LOINC codes in case you want to exclude based on test results:
```
 	21637-4 	BRCA1 gene.c.185 del AG [presence] in Blood or Tissue by Molecular genetics method
	21638-2 	BRCA1 gene c.5382insC [Presence] in Blood or Tissue by Molecular genetics method
	21640-8 	BRCA2 gene c.6174delT [Presence] in Blood or Tissue by Molecular genetics method 
	21639-0 	BRCA1 gene mutations tested for in Blood or Tissue by Molecular genetics
	21636-6 	BRCA1 gene mutations found [Identifier] in Blood or Tissue by Molecular genetics method
	59041-4 	BRCA1+BRCA2 gene mutations tested for in Blood or Tissue by Molecular genetics method
	50995-0 	BRCA1+BRCA2 gene targeted mutation analysis in Blood or Tissue by Molecular genetics method
	38531-0 	BRCA2 gene mutations tested for in Blood or Tissue by Molecular genetics method
	38530-2 	BRCA2 gene mutations found [Identifier] in Blood or Tissue by Molecular genetics method Nominal
	79207-7 	BRCA1 gene mutation analysis limited to known familial mutations in Blood or Tissue by Molecular genetics method
	79208-5 	BRCA2 gene mutation analysis limited to known familial mutations in Blood or Tissue by Molecular genetics method
	94191-4 	BRCA1+BRCA2 gene deletion+duplication and full mutation analysis in Blood or Tissue by Molecular genetics method

ChatGPT suggests this Observation resource:
```
{
  "resourceType": "Observation",
  "id": "brca-observation",
  "status": "final",
  "category": [
    {
      "coding": [
        {
          "system": "http://terminology.hl7.org/CodeSystem/observation-category",
          "code": "laboratory",
          "display": "Laboratory"
        }
      ]
    }
  ],
  "code": {
    "coding": [
      {
        "system": "http://loinc.org",
        "code": "LOINC_CODE_FOR_BRCA_TEST", // Replace with actual LOINC code for BRCA1/BRCA2 testing
        "display": "BRCA1 and BRCA2 gene mutation analysis"
      }
    ],
    "text": "BRCA1/BRCA2 Gene Mutation Test"
  },
  "subject": {
    "reference": "Patient/example-patient" // Replace with actual patient reference
  },
  "effectiveDateTime": "2024-02-02", // Replace with the actual date of the test
  "issued": "2024-02-02T12:10:00Z", // Replace with the timestamp when the result was issued
  "performer": [
    {
      "reference": "Practitioner/example-practitioner" // Replace with actual performer reference
    }
  ],
  "valueString": "Positive for BRCA1/BRCA2 mutation",
  "interpretation": [
    {
      "coding": [
        {
          "system": "http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation",
          "code": "POS",
          "display": "Positive"
        }
      ],
      "text": "Positive test result indicates a mutation in either the BRCA1 or BRCA2 gene."
    }
  ],
  "note": [
    {
      "authorReference": {
        "reference": "Practitioner/example-practitioner"
      },
      "time": "2024-02-02T12:10:00Z",
      "text": "Patient has tested positive for a mutation in the BRCA1 or BRCA2 gene. Genetic counseling and further assessment of cancer risk are recommended."
    }
  ]
}
```

So maybe and observation like this:
```

```

