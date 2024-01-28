Instance: should-not-screen-bcs-6
InstanceOf: GuidanceResponse
Usage: #example
* contained[0] = expected
* contained[+] = screening-not-recommended
* moduleCanonical = "http://fhir.org/guides/cqf/bcc/PlanDefinition/BreastCancerScreeningCDS"
* status = #success
* subject = Reference(should-not-screen-ccs)
* result = Reference(expected)