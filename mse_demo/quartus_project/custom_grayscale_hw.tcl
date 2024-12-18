# TCL File Generated by Component Editor 18.1
# Tue Dec 17 20:25:09 CET 2024
# DO NOT MODIFY


# 
# custom_grayscale "custom_grayscale" v1.0
#  2024.12.17.20:25:09
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module custom_grayscale
# 
set_module_property DESCRIPTION ""
set_module_property NAME custom_grayscale
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME custom_grayscale
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL rgb2gray
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file grayscale.vhdl VHDL PATH ../vhdl_modules/custom_module/grayscale.vhdl TOP_LEVEL_FILE


# 
# parameters
# 
add_parameter PACKET_SIZE INTEGER 32
set_parameter_property PACKET_SIZE DEFAULT_VALUE 32
set_parameter_property PACKET_SIZE DISPLAY_NAME PACKET_SIZE
set_parameter_property PACKET_SIZE TYPE INTEGER
set_parameter_property PACKET_SIZE UNITS None
set_parameter_property PACKET_SIZE HDL_PARAMETER true


# 
# display items
# 


# 
# connection point nios_custom_instruction_slave
# 
add_interface nios_custom_instruction_slave nios_custom_instruction end
set_interface_property nios_custom_instruction_slave clockCycle 0
set_interface_property nios_custom_instruction_slave operands 2
set_interface_property nios_custom_instruction_slave ENABLED true
set_interface_property nios_custom_instruction_slave EXPORT_OF ""
set_interface_property nios_custom_instruction_slave PORT_NAME_MAP ""
set_interface_property nios_custom_instruction_slave CMSIS_SVD_VARIABLES ""
set_interface_property nios_custom_instruction_slave SVD_ADDRESS_GROUP ""

add_interface_port nios_custom_instruction_slave rgb_out dataa Input 16
add_interface_port nios_custom_instruction_slave gray_pixel result Output 8

