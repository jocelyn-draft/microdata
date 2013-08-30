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

	document: detachable MD_DOCUMENT
			-- Root document, if any.
		do
			if attached {MD_DOCUMENT} Current as curr then
				Result := curr
			elseif attached parent as p then
				if attached {MD_DOCUMENT} p as doc then
					Result := doc
				else
					Result := p.document
				end
			end
		end

	parent: detachable MD_COMPOSITE
			-- Parent of current node;
			-- Void if current node is root

feature {MD_COMPOSITE} -- Change

	set_parent (p: detachable MD_COMPOSITE)
		do
			parent := p
		end

feature -- Visitor

	accept (vis: MD_VISITOR)
		deferred
		end

end
