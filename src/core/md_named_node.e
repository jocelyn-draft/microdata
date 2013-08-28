note
	description: "Summary description for {MD_NAMED_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MD_NAMED_NODE

inherit
	MD_NODE

feature -- Access

	name: IMMUTABLE_STRING_32
			-- Itemprop name

feature -- Change

	set_name (a_name: READABLE_STRING_GENERAL)
			-- Update name
		do
			create name.make_from_string_general (a_name)
		end

end
