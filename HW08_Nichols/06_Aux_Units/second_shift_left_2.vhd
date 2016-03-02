LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


ENTITY Second_Shift_Left_2 IS
   PORT( 
      Instruction_15_0_Sign_Extended              : IN     std_logic_vector (31 DOWNTO 0);
      Instruction_15_0_Sign_Extended_Left_Shifted : OUT    std_logic_vector (31 DOWNTO 0)
   );
END Second_Shift_Left_2 ;


ARCHITECTURE struct OF Second_Shift_Left_2 IS

BEGIN

-- Insert your code here --

---------------------------

END struct;
