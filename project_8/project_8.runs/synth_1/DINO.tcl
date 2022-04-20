# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
namespace eval ::optrace {
  variable script "C:/Users/rodri/ECE350/final-project-team-18/project_8/project_8.runs/synth_1/DINO.tcl"
  variable category "vivado_synth"
}

# Try to connect to running dispatch if we haven't done so already.
# This code assumes that the Tcl interpreter is not using threads,
# since the ::dispatch::connected variable isn't mutex protected.
if {![info exists ::dispatch::connected]} {
  namespace eval ::dispatch {
    variable connected false
    if {[llength [array get env XILINX_CD_CONNECT_ID]] > 0} {
      set result "true"
      if {[catch {
        if {[lsearch -exact [package names] DispatchTcl] < 0} {
          set result [load librdi_cd_clienttcl[info sharedlibextension]] 
        }
        if {$result eq "false"} {
          puts "WARNING: Could not load dispatch client library"
        }
        set connect_id [ ::dispatch::init_client -mode EXISTING_SERVER ]
        if { $connect_id eq "" } {
          puts "WARNING: Could not initialize dispatch client"
        } else {
          puts "INFO: Dispatch client connection id - $connect_id"
          set connected true
        }
      } catch_res]} {
        puts "WARNING: failed to connect to dispatch server - $catch_res"
      }
    }
  }
}
if {$::dispatch::connected} {
  # Remove the dummy proc if it exists.
  if { [expr {[llength [info procs ::OPTRACE]] > 0}] } {
    rename ::OPTRACE ""
  }
  proc ::OPTRACE { task action {tags {} } } {
    ::vitis_log::op_trace "$task" $action -tags $tags -script $::optrace::script -category $::optrace::category
  }
  # dispatch is generic. We specifically want to attach logging.
  ::vitis_log::connect_client
} else {
  # Add dummy proc if it doesn't exist.
  if { [expr {[llength [info procs ::OPTRACE]] == 0}] } {
    proc ::OPTRACE {{arg1 \"\" } {arg2 \"\"} {arg3 \"\" } {arg4 \"\"} {arg5 \"\" } {arg6 \"\"}} {
        # Do nothing
    }
  }
}

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
OPTRACE "synth_1" START { ROLLUP_AUTO }
set_param tcl.collectionResultDisplayLimit 0
set_param chipscope.maxJobs 1
set_param xicom.use_bs_reader 1
OPTRACE "Creating in-memory project" START { }
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/rodri/ECE350/final-project-team-18/project_8/project_8.cache/wt [current_project]
set_property parent.project_path C:/Users/rodri/ECE350/final-project-team-18/project_8/project_8.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:nexys-a7-100t:part0:1.0 [current_project]
set_property ip_output_repo c:/Users/rodri/ECE350/final-project-team-18/project_8/project_8.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
OPTRACE "Creating in-memory project" END { }
OPTRACE "Adding files" START { }
read_mem {
  C:/Users/rodri/ECE350/final-project-team-18/VGA/dino.mem
  C:/Users/rodri/ECE350/final-project-team-18/Processor/dino_assembly.mem
  C:/Users/rodri/ECE350/final-project-team-18/VGA/colors.mem
  C:/Users/rodri/ECE350/final-project-team-18/VGA/image.mem
  C:/Users/rodri/ECE350/final-project-team-18/VGA/pause.mem
  C:/Users/rodri/ECE350/final-project-team-18/VGA/game_over.mem
}
read_verilog -library xil_defaultlib {
  C:/Users/rodri/ECE350/final-project-team-18/Processor/ADD.v
  C:/Users/rodri/ECE350/final-project-team-18/Scores/BCD.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/BIT_AND.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/BIT_OR.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/CLA_1.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/CLA_32.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/CLA_8.v
  C:/Users/rodri/ECE350/final-project-team-18/Scores/DigitDisplay.v
  C:/Users/rodri/ECE350/final-project-team-18/LFSR_4bit.v
  C:/Users/rodri/ECE350/final-project-team-18/LSFR_5bit.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/NOT_EQUAL.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/RAM.v
  C:/Users/rodri/ECE350/final-project-team-18/VGA/RAM_VGA.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/ROM.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/SLL.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/SRA.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/SUBTRACT.v
  C:/Users/rodri/ECE350/final-project-team-18/VGA/VGAController.v
  C:/Users/rodri/ECE350/final-project-team-18/VGA/VGATimingGenerator.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/Wrapper.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/alu.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/bypass_struct.v
  C:/Users/rodri/ECE350/final-project-team-18/clock_divider.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/decode.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/decoder_32.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/dffe_neg.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/dffe_ref.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/divider.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/dx.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/execute.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/fd.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/fetch.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/memory.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/multdiv.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/multiplier.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/mux_2.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/mux_2_one_bit.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/mux_4.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/mux_4_one_bit.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/mux_8.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/mux_8_one_bit.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/mw.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/overflow_struct.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/pc.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/pc_control.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/processor.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/pw.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/regfile.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/register.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/tri_32.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/tristate_32.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/tristate_5.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/type_control.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/writeback.v
  C:/Users/rodri/ECE350/final-project-team-18/Processor/xm.v
  C:/Users/rodri/ECE350/final-project-team-18/DINO.v
}
read_ip -quiet C:/Users/rodri/ECE350/final-project-team-18/project_8/project_8.srcs/sources_1/ip/ila_0/ila_0.xci
set_property used_in_synthesis false [get_files -all c:/Users/rodri/ECE350/final-project-team-18/project_8/project_8.srcs/sources_1/ip/ila_0/ila_v6_2/constraints/ila_impl.xdc]
set_property used_in_implementation false [get_files -all c:/Users/rodri/ECE350/final-project-team-18/project_8/project_8.srcs/sources_1/ip/ila_0/ila_v6_2/constraints/ila_impl.xdc]
set_property used_in_implementation false [get_files -all c:/Users/rodri/ECE350/final-project-team-18/project_8/project_8.srcs/sources_1/ip/ila_0/ila_v6_2/constraints/ila.xdc]
set_property used_in_implementation false [get_files -all c:/Users/rodri/ECE350/final-project-team-18/project_8/project_8.srcs/sources_1/ip/ila_0/ila_0_ooc.xdc]

OPTRACE "Adding files" END { }
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/rodri/ECE350/final-project-team-18/VGA/constraints.xdc
set_property used_in_implementation false [get_files C:/Users/rodri/ECE350/final-project-team-18/VGA/constraints.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

OPTRACE "synth_design" START { }
synth_design -top DINO -part xc7a100tcsg324-1
OPTRACE "synth_design" END { }


OPTRACE "write_checkpoint" START { CHECKPOINT }
# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef DINO.dcp
OPTRACE "write_checkpoint" END { }
OPTRACE "synth reports" START { REPORT }
create_report "synth_1_synth_report_utilization_0" "report_utilization -file DINO_utilization_synth.rpt -pb DINO_utilization_synth.pb"
OPTRACE "synth reports" END { }
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
OPTRACE "synth_1" END { }
