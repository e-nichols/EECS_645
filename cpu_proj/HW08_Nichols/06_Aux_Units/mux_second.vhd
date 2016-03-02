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

    -- Signal Declarations
    SIGNAL output_internal : std_logic_vector ( 31 DOWNTO 0);

BEGIN

    output <= output_internal;
    
    --------------------------------------------------
    mux_process : PROCESS ( sel )
    --------------------------------------------------
    BEGIN
    
        IF (sel = "1") THEN
            output_internal <= input_1;
        ELSE
            output_internal <= input_0;
        END IF;
        
    END PROCESS;

END struct;