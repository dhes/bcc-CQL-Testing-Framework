Instance: should-screen-ccs
InstanceOf: Patient
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient"
* extension[0].url = "http://hl7.org/fhir/us/core/StructureDefinition/us-core-race"
* extension[=].extension.url = "ombCategory"
* extension[=].extension.valueCoding = urn:oid:2.16.840.1.113883.6.238#2028-9 "Asian"
* extension[+].url = "http://hl7.org/fhir/us/core/StructureDefinition/us-core-ethnicity"
* extension[=].extension.url = "ombCategory"
* extension[=].extension.valueCoding = urn:oid:2.16.840.1.113883.6.238#2135-2 "Hispanic or Latino"
* identifier.use = #usual
* identifier.type = $v2-0203#MR "Medical Record Number"
* identifier.system = "http://hospital.smarthealthit.org"
* identifier.value = "999999992"
* name.family = "Dere"
* name.given = "Ben"
* birthDate = "1968-01-01"
* gender = #male