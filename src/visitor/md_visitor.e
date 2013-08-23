note
	description: "Summary description for {MD_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MD_VISITOR

feature -- Visitor

	visit_document (vis: MD_DOCUMENT)
		deferred
		end

	visit_element (vis: MD_ELEMENT)
		deferred
		end


end
