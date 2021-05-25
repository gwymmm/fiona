with Ada.Text_IO;

package body Error_Handling is

  procedure Write_Warning(Warning_Msg: in String) is
    use Ada.Text_IO;
  begin
    Put_Line("Warning: " & Warning_Msg);
  end Write_Warning;


  function Error_Msg(Line_Number: in Positive; Msg: in String) return String is
  begin
    return "Error in line " & Line_Number'Image & ": " & Msg;
  end Error_Msg;

end Error_Handling;