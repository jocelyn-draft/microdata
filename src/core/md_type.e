note
	description: "A valid URL of a vocabulary that describes the item and its properties context."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_TYPE

create
	make_from_url

feature {NONE} -- Initialization

	make_from_url (a_type_url: READABLE_STRING_GENERAL)
		do
			create url.make_from_string_general (a_type_url)
		end

feature -- Access

	url: IMMUTABLE_STRING_32

feature -- Change	

end
