note
	description: "Summary description for {HTML_PARSER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_PARSER

inherit
	XML_STANDARD_PARSER
		redefine
			report_missing_attribute_value,
			report_unsupported_bom_value
		end

create
	make

feature {NONE} -- Query

	report_unsupported_bom_value (a_bom: READABLE_STRING_GENERAL)
		do
			-- Accept unsupported bom value: ignore
		end

	report_missing_attribute_value (p: detachable READABLE_STRING_32; n: READABLE_STRING_32)
		do
			-- Accept attribute without value
			-- assume it is empty
		end

end
