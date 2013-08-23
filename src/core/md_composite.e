note
	description: "Summary description for {MD_COMPOSITE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MD_COMPOSITE

inherit
	MD_NODE

	ITERABLE [MD_NODE]

feature {NONE} -- Initialize

	initialize
		do
			create {ARRAYED_LIST [MD_NODE]} nodes.make (0)
		end

feature -- Access

	count: INTEGER
		do
			Result := nodes.count
		end

	nodes: LIST [MD_NODE]

	elements: LIST [MD_ELEMENT]
		local
			l_nodes: like nodes
		do
			l_nodes := nodes
			create {ARRAYED_LIST [MD_ELEMENT]} Result.make (l_nodes.count)
			across
				l_nodes as c
			loop
				if attached {MD_ELEMENT} c.item as e then
					Result.force (e)
				end
			end
		end

feature -- Change

	wipe_out
		do
			nodes.wipe_out
		end

	force (n: MD_NODE)
		do
			nodes.force (n)
		end

feature -- Report

	has (n: MD_NODE): BOOLEAN
		do
			Result := nodes.has (n)
		end

feature -- Access

	new_cursor: ITERATION_CURSOR [MD_NODE]
			-- <Precursor>
		do
			Result := nodes.new_cursor
		end

end
