note
	description: "Summary description for {MD_DEBUG_ITERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_DEBUG_ITERATOR

inherit
	MD_ITERATOR
		redefine
			visit_element
		end

feature -- Visit

	visit_element (v: MD_ELEMENT)
		do
			print (v.debug_output)
			io.put_new_line
			Precursor (v)
		end


end
