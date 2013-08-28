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
			visit_item,
			visit_property
		end

create
	make

feature {NONE} -- Initialization

	make (buf: like buffer)
		do
			buffer := buf
			create offset.make_empty
		end

feature -- Access

	buffer: STRING_32

	offset: STRING_32

feature -- Visit

	visit_item (v: MD_ITEM)
		do
			buffer.append (offset)
			buffer.append (v.debug_output)
			buffer.append_character ('%N')
			offset.extend (' ')
			Precursor (v)
			offset.remove_tail (1)
		end

	visit_property (v: MD_PROPERTY)
		do
			buffer.append (offset)
			buffer.append (v.debug_output)
			buffer.append_character ('%N')
			offset.extend (' ')
			Precursor (v)
			offset.remove_tail (1)
		end



end
