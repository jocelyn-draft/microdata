note
	description: "Summary description for {XML_NODE_AGENT_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XML_NODE_AGENT_FILTER [G -> XML_NODE]

inherit
	XML_NODE_FILTER [G]

create
	make

feature {NONE} -- Initialization

	make (act: like filter_agent)
		do
			filter_agent := act
		end

feature -- Access

	filter_agent: FUNCTION [ANY, TUPLE [XML_NODE], BOOLEAN]
			-- Function taking as argument a node and returning True if node matches.

	matched (v: G): BOOLEAN
			-- <Precursor>
		do
			Result := filter_agent.item ([v])
		end

end
