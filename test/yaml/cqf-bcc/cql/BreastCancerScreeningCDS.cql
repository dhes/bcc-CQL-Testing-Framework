library BreastCancerScreeningCDS version '0.1.0'

using FHIR version '4.0.1'

include FHIRHelpers version '4.0.1'
// include FHIRCommon version '4.0.1' called FC

include BreastCancerElements called BCE

// QUESTION: Should this be a single timepoint, or is a period required?
//parameter AsOf DateTime default Now()

/*
NOTE: Introduced Measurement Period as the parameter here for demonstration purposes
so it will run on the current implementations.
*/
// parameter "Measurement Period" Interval<DateTime>
//   default Interval[Now() - 2 years, Now()]

parameter "Null Patient.deceased assumed to mean alive" Boolean default false 

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

define "Woman":
  BCE."Woman"

define "Age":
  AgeInYears()

define "Woman aged 50 to 74 years inclusive":
  BCE.Woman and BCE."aged 50 to 74 years inclusive"

// define "Is Recommendation Applicable":
//   BCE."Is female"
//   and "Age between 52 and 75"
//   and not BCE."Has Appropriate Breast Cancer Screening"
//   and not (BCE."Bilateral Mastectomy Performed")
//   // and BCE."Is female"
//   // and not BCE."Has Active Malignant Neoplasm"

define "History of bilateral mastectomy":
  BCE."Bilateral Mastectomy Performed"

define "Has Breast Cancer":
  BCE."Breast Cancer Diagnosis"

define "Excluded":
  "History of bilateral mastectomy"
  or "Has Breast Cancer"

define "Most recent mammogram":
  date from BCE."Most Recent Mammogram".issued

define "Months elapsed":
  months between BCE."Most Recent Mammogram".issued and BCE."Reference Date"

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

define "Due for screening mammogram": //"applicible" in the sense that this patient is eligible and due. 
  "Alive"
	and "Active"
  and "Woman aged 50 to 74 years inclusive" 
  and not Excluded // with bilateral mastectomy or has breast cancer
  and not BCE."Mammogram within 24 months"

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
    ' the most recent mammogram performed on ' + ToString(date from BCE."Most Recent Mammogram".issued) + '.',
    ' no mammogram on file'
  })
  else null


