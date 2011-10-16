var noteFileFieldCount = 1;

function addCheckListField(value) {
	if (noteFileFieldCount >= 10) return false
	noteFileFieldCount++;
	var cb = document.createElement("input");
	cb.type = "checkbox";
	cb.id = "id"
	cb.value = value

	var lb = document.createElement("label");
	lb.innerHTML = value
	

	p = document.getElementById("issue_checklist");
	p.appendChild(document.createElement("br"));
	p.appendChild(cb);
	p.appendChild(lb);
}