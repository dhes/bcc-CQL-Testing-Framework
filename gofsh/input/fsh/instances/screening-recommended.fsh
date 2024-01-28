Instance: screening-recommended
InstanceOf: ServiceRequest
Usage: #inline
* extension.url = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-rationale"
* extension.valueMarkdown = "Patient meets the inclusion criteria for appropriate Breast cancer screening, but has most recent Colonoscopy performed on 2009-12-30"
* status = #draft
* intent = #proposal
* doNotPerform = true
* code.text = "Breast Cancer Screening Recommended"
* subject = Reference(should-screen-ccs)
* supportingInfo = Reference(should-screen-ccs-2)