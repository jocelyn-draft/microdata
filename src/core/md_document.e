note
	description: "Summary description for {MD_DOCUMENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_DOCUMENT

inherit
	MD_COMPOSITE
		redefine
			initialize
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			initialize
		end

	initialize
		do
			Precursor
			create id_nodes.make (0)
		end

feature -- Access

	id_nodes: STRING_TABLE [MD_ID_NODE]
			-- List of referenceable node.

	register_id_node (a_id_node: MD_ID_NODE)
		require
			has_not_id: not id_nodes.has (a_id_node.id)
		do
			id_nodes.force (a_id_node, a_id_node.id)
		end

	unregister_id_node (a_id_node: MD_ID_NODE)
		do
			id_nodes.remove (a_id_node.id)
		ensure
			has_not_id: not id_nodes.has (a_id_node.id)
		end

	id_node (a_id: READABLE_STRING_GENERAL): detachable MD_ID_NODE
			-- Eventual node id related to `a_id'.
		do
			Result := id_nodes.item (a_id)
		end

feature -- Status report

	debug_output: STRING_32
			-- <Precursor>
		do
			create Result.make_empty
			Result.append_string_general (generator)
			Result.append_character (' ')
			Result.append_integer (count)
			Result.append_string_general (" items")

			if not id_nodes.is_empty then
				Result.append_character (' ')
				Result.append_integer (id_nodes.count)
				Result.append_string_general (" ids")
			end
		end

feature -- Visitor

	accept (vis: MD_VISITOR)
		do
			vis.visit_document (Current)
		end

end
