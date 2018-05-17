notifying
notifyChangesTo: aSupervisor

	aSupervisor relateChangesIn: view withModelFor: self.
	view notifyChangesTo: aSupervisor