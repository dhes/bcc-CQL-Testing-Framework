library BreastCancerScreeningCDS version '0.1.0'

using FHIR version '4.0.1'

include FHIRHelpers version '4.0.1'
include FHIRCommon version '4.0.1' called FC

include BreastCancerElements called BCE
include BreastCancerConcepts called Bx

// QUESTION: Should this be a single timepoint, or is a period required?
//parameter AsOf DateTime default Now()

/*
NOTE: Introduced Measurement Period as the parameter here for demonstration purposes
so it will run on the current implementations.
*/
// parameter "Measurement Period" Interval<DateTime>
//   default Interval[Now() - 2 years, Now()]

parameter "Null Patient.deceased assumed to mean alive" Boolean default false 

parameter "Reference Date" DateTime 
  // default  @2024-01-01T00:00:00-06:00
  default Now()

codesystem "LOINC": 'http://loinc.org'
code "MG Breast Screening": '24606-6' from "LOINC" display 'MG Breast Screening' // AKA 2D mammogram
code "DBT Breast - bilateral screening": '72142-3' from "LOINC" display 'DBT Breast - bilateral screening' // AKA 3D mammogram
concept "Mammography screening": { "MG Breast Screening", "DBT Breast - bilateral screening" } display 'Mammography screening'

context Patient

// First and foremost, are you alive? Are you an active patient? 
// Always and only. 

define "Alive": 
  case 
    // when Patient.deceased = true then false //redundant
    when Patient.deceased = false then true
    when "Null Patient.deceased assumed to mean alive" = true and Patient.deceased is null then true
    else false
  end

// define Alive:
//   Patient.deceased = false

define Active: 
  Patient.active = true

// define "Age":
//   AgeInYearsAt(start of "Measurement Period")

// define "Age between 52 and 75":
//   "Age" between 52 and 75

define Woman:
  Patient.gender = 'female'

define "Age":
  AgeInYears()

define "aged 50 to 74 years inclusive": 
  Age between 50 and 74 // `between` is inclusive

define "Woman aged 50 to 74 years inclusive":
  Woman and "aged 50 to 74 years inclusive"

// define "Is Recommendation Applicable":
//   BCE."Is female"
//   and "Age between 52 and 75"
//   and not BCE."Has Appropriate Breast Cancer Screening"
//   and not (BCE."Bilateral Mastectomy Performed")
//   // and BCE."Is female"
//   // and not BCE."Has Active Malignant Neoplasm"

// define "Bilateral Mastectomy Procedure from elements":
// BCE."Bilateral Mastectomy Procedure"
define "Bilateral Mastectomy Procedure":
  [Procedure: Bx."Bilateral Mastectomy"] BilateralMastectomyPerformed // the procedure
    where BilateralMastectomyPerformed.status~'completed'

// define "Bilateral Mastectomy Diagnosis from elements":
// BCE."Bilateral Mastectomy Diagnosis"
define "Bilateral Mastectomy Diagnosis":
  [Condition: Bx."History of bilateral mastectomy"] BilateralMastectomyHistory // the condition
    // where BilateralMastectomyHistory.clinicalStatus in FC."Active Condition"
  // where BilateralMastectomyHistory.verificationStatus ~ FC."confirmed"

define "History of bilateral mastectomy":
  "Bilateral Mastectomy Performed"
define "Bilateral Mastectomy Performed":
  // ( 
	// 	(
	// 		exists ( "Right Mastectomy Diagnosis" )
	// 		or exists ( "Right Mastectomy Procedure" )
	// 	)
	// 		and 
	// 	(
	// 		exists ( "Left Mastectomy Diagnosis" )
	// 		or exists ( "Left Mastectomy Procedure" )
	// 	)
	// ) of
	exists "Bilateral Mastectomy Diagnosis"
	or exists "Bilateral Mastectomy Procedure"

// define "Has Breast Cancer":
//   BCE."Breast Cancer Diagnosis"
// Exclusion - Breast Cancer Diagnosis
define "Breast Cancer Diagnosis":
  exists ([Condition: Bx."Breast Cancer Diagnoses"] Dx
  where Dx.verificationStatus ~ FC."confirmed"
  and Dx.clinicalStatus ~ FC."active")

define "Excluded":
  "History of bilateral mastectomy"
  or "Breast Cancer Diagnosis"

define "Mammography Performed":
// This worked with the old valueset "Mammogram"
// [Observation: Bx."Mammography"] Mammogram
//   where Mammogram.status = 'final'
  [Observation: "Mammography screening"] O
// where O.code in BreastCancerScreeningLOINCCodes
// where O.status = 'final'
// and O.code ~ "Mammography screening"

define function MostRecent(observations List<Observation>, asOf DateTime):
  First(
    observations O
      sort by start of FC.ToInterval(issued)
  )

define "Most Recent Mammogram":
  MostRecent("Mammography Performed", "Reference Date")


define "Most recent mammogram":
  date from "Most Recent Mammogram".issued

define "Months elapsed":
  months between "Most Recent Mammogram".issued and "Reference Date"

// define "Rationale":
//   Coalesce({
//     'most recent mammogram performed on ' + ToString(date from BCE."Most Recent Mammogram".issued),
//     'no mammogram on file'
//   })

// define "Mammogram status":
// // if Count(X) > 0 then X[1] else 0
//   if 
//     "Woman aged 50 to 74 years inclusive" 
//     and BCE."Mammogram within 24 months" 
//   then 'mammogram up to date'
//   else 'mammogram due'

define "Mammogram within 24 months":
  exists "Mammography Performed" P
  where P.issued >= ("Reference Date" - 2 years)

define "Due for screening mammogram": //"applicible" in the sense that this patient is eligible and due. 
  "Alive"
	and "Active"
  and "Woman aged 50 to 74 years inclusive" 
  and not Excluded // with bilateral mastectomy or has breast cancer
  and not "Mammogram within 24 months"

define "Get Card Summary":
  if "Due for screening mammogram" then
    'Due for screening mammogram'
  else
    null

define "Get Card Indicator":
  // if "Is Recommendation Applicable" then
  if "Due for screening mammogram"
  then 'asap'
  else null

define "Get Card Detail":
  if "Due for screening mammogram" then
    'This patient is due for mammogram, with ' + Rationale + '.'
  else
    null

define Rationale:
  if "Due for screening mammogram"
  then Coalesce({
    ' the most recent mammogram performed on ' + ToString(date from "Most Recent Mammogram".issued) + '.',
    ' no mammogram on file'
  })
  else null


