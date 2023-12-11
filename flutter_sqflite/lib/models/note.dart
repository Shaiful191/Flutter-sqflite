
class Note {

	int ?id;
	String ?title;
	String ?description;
	String ?date;
	int ?priority;

	Note(this.title, this.date, this.priority, [this.description]);

	Note.withId(this.id, this.title, this.date, this.priority, [this.description]);

	//int get id => id;

	// String get title => title;

	// String get description => description ?? " ";

	// int get priority => priority;

	// String get date => date;

	// set title(String newTitle) {
	// 	if (newTitle.length <= 255) {
	// 		this.title = newTitle;
	// 	}
	// }

	// set description(String newDescription) {
	// 	if (newDescription.length <= 255) {
	// 		this.description = newDescription;
	// 	}
	// }

	// set priority(int newPriority) {
	// 	if (newPriority >= 1 && newPriority <= 2) {
	// 		this.priority = newPriority;
	// 	}
	// }

	// set date(String newDate) {
	// 	this.date = newDate;
	// }

	// Convert a Note object into a Map object
	Map<String, dynamic> toMap() {

		var map = Map<String, dynamic>();
		if (id != null) {
			map['id'] = id;
		}
		map['title'] = title;
		map['description'] = description;
		map['priority'] = priority;
		map['date'] = date;

		return map;
	}

	// Extract a Note object from a Map object
	Note.fromMapObject(Map<String, dynamic> map) {
		this.id = map['id'];
		this.title = map['title'];
		this.description = map['description'];
		this.priority = map['priority'];
		this.date = map['date'];
	}
}









