note
	description: "Summary description for {XML_SELECTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XML_NODE_SELECTOR [G -> XML_NODE]

inherit
	XML_NODE_ITERATOR
		redefine
			process_element
		end

create
	make,
	make_with_filter

feature -- Initialization

	make
		do
			create items.make (0)
		end

	make_with_filter (f: attached like filter)
		do
			make
			filter := f
		end

feature -- Selection

	items: ARRAYED_LIST [G]

feature {NONE} -- Internal

	filter: detachable XML_NODE_FILTER [G]
			-- Filter associated with the selection.

feature -- Visitor

	process_element (e: XML_ELEMENT)
		do
			if
				attached filter as f and then
				attached {G} e as v and then
				f.matched (v)
			then
				items.force (v)
			end
			Precursor (e)
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
