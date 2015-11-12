LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


ENTITY sign_extend IS
   PORT(
      Instruction_15_0               : IN     std_logic_vector (15 DOWNTO 0);
      Instruction_15_0_Sign_Extended : OUT    std_logic_vector (31 DOWNTO 0)
   );
END sign_extend ;


ARCHITECTURE struct OF sign_extend IS

    -- Architecture declarations
    constant zero_value : std_logic_vector(15 DOWNTO 0) := (others => '0');
    constant one_value : std_logic_vector(15 DOWNTO 0) := (others => '1');

BEGIN

    IF Instruction_15_0(15) = "1" THEN
        Instruction_15_0_Sign_Extended <= one_value & Instruction_15_0;
    ELSE
        Instruction_15_0_Sign_Extended <= zero_value & Instruction_15_0;
    END IF;

    -- OR..... IF I'm being stupid....

    Instruction_15_0_Sign_Extended <= zero_value & Instruction_15_0;

END struct;
