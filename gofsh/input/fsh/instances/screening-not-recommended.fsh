Instance: screening-not-recommended
InstanceOf: ServiceRequest
Usage: #inline
* extension.url = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-rationale"
* extension.valueMarkdown = "Patient has appropriate Breast cancer screening: most recent Colonoscopy performed on 2012-01-01"
* status = #draft
* intent = #proposal
* doNotPerform = true
* code.text = "Breast Cancer Screening Not Recommended"
* subject = Reference(should-not-screen-ccs)
* supportingInfo = Reference(should-not-screen-ccs-1)