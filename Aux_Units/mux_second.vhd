LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


ENTITY mux_second IS
   PORT(
      input_0 : IN     std_logic_vector (31 DOWNTO 0);
      input_1 : IN     std_logic_vector (31 DOWNTO 0);
      sel     : IN     std_logic;
      output  : OUT    std_logic_vector (31 DOWNTO 0)
   );
END mux_second ;


ARCHITECTURE struct OF mux_second IS

BEGIN

    -----------------------------
    mux_process : PROCESS
    -----------------------------
    BEGIN

        IF sel = "1" THEN
            output <=  input_1;
        ELSE
            output <= input_0 ;
        END IF;

    END PROCESS;

END struct;
