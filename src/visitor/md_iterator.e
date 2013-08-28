note
	description: "Summary description for {MD_ITERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_ITERATOR

inherit
	MD_VISITOR

feature -- Visit

	visit_document (v: MD_DOCUMENT)
		do
			visit_composite (v)
		end

	visit_item (v: MD_ITEM)
		do
			visit_composite (v)
		end

	visit_property (v: MD_PROPERTY)
		do
		end

feature -- Visit helper		

	visit_composite (v: MD_COMPOSITE)
		do
			across
				v as c
			loop
				c.item.accept (Current)
			end
		end

end
