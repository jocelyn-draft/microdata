note
	description: "Summary description for {XML_NODE_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XML_NODE_FILTER [G -> XML_NODE]

feature -- Status report

	matched (v: G): BOOLEAN
		deferred
		end

end
