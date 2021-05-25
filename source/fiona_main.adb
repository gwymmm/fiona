with Ada.Command_Line;
with Fiona;

procedure Fiona_Main is

  use Ada.Command_Line;

begin

  Fiona.Run_Main;

  Set_Exit_Status(Success);

exception
  when others =>
    Set_Exit_Status(Failure);

end Fiona_Main;