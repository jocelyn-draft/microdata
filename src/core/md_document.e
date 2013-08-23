note
	description: "Summary description for {MD_DOCUMENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_DOCUMENT

inherit
	MD_COMPOSITE

create
	make

feature {NONE} -- Initialization

	make
		do
			initialize
		end

feature -- Status report

	debug_output: STRING_32
			-- <Precursor>
		do
			create Result.make_empty
			Result.append_string_general (generator)
		end

feature -- Visitor

	accept (vis: MD_VISITOR)
		do
			vis.visit_document (Current)
		end

end
