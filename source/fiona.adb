with Cmd_Args;
with Cmd_Args.Parser;

package body Fiona is

  procedure Run_Main is
    Params: Cmd_Args.Execution_Parameter;
  begin

    Cmd_Args.Parser.Read_Command_Line_Arguments(Params);

  end Run_Main;

end Fiona;