with Cmd_Args;

package body Fiona is

  procedure Run_Main is
    Exec_Opts: Cmd_Args.Execution_Options;
  begin

    Cmd_Args.Parser.Read_Command_Line_Arguments(Exec_Opts);

  end Run_Main;

end Fiona;