Instance: should-not-screen-ccs-1
InstanceOf: Procedure
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/core/StructureDefinition/us-core-procedure"
* status = #completed
* code = $cpt#44388 "Colonoscopy through stoma; with ablation of tumor(s), polyp(s), or other lesion(s) not amenable to removal by hot biopsy forceps, bipolar cautery or snare technique"
* subject = Reference(should-not-screen-ccs)
* performedPeriod.start = 2015-01-01T00:00:00-06:00
* performedPeriod.end = 2015-01-01T01:00:00-07:00