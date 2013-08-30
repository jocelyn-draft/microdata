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

note
	copyright: "2011-2013, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
