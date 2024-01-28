Instance: Inline-Instance-for-should-screen-ccs-5-1
InstanceOf: CarePlan
Usage: #inline
* id = "expected"
* instantiatesCanonical = "http://fhir.org/guides/cqf/bcc/PlanDefinition/BreastCancerScreeningCDS"
* status = #draft
* intent = #proposal
* subject = Reference(should-screen-ccs)
* activity.reference = Reference(screening-recommended)