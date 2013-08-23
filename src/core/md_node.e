note
	description: "Summary description for {MD_NODE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MD_NODE

inherit
	DEBUG_OUTPUT

feature -- Access

	parent: detachable MD_COMPOSITE
			-- Parent of current node;
			-- Void if current node is root		

feature -- Visitor

	accept (vis: MD_VISITOR)
		deferred
		end

end
