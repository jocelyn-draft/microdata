note
	description: "Summary description for {MD_TYPED_NODE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MD_TYPED_NODE

inherit
	MD_NODE

feature -- Access

	type: detachable MD_TYPE
			-- associated itemtype

	type_url: detachable READABLE_STRING_32
			-- valid URL of a vocabulary that describes the item and its properties context.
		do
			if attached type as l_type then
				Result := l_type.url
			end
		end

feature -- Change

	set_type_url (a_type_url: detachable READABLE_STRING_GENERAL)
		do
			if a_type_url = Void then
				type := Void
			else
				create type.make_from_url (a_type_url)
			end
		end

	set_type (a_type: like type)
		do
			type := a_type
		end

end
