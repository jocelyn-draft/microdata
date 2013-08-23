note
	description: "Summary description for {MD_ELEMENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_ELEMENT

inherit
	MD_COMPOSITE

create
	make

feature {NONE} -- Initialization

	make
		do
			initialize
		end

feature -- Access

	associated_xml_element: detachable XML_ELEMENT

feature -- Change

	set_associated_xml_element (e: like associated_xml_element)
		do
			associated_xml_element := e
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
			vis.visit_element (Current)
		end

end
