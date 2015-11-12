LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


ENTITY PC_register IS
   PORT(
      PC_next : IN     std_logic_vector (31 DOWNTO 0);
      clk     : IN     std_logic;
      rst     : IN     std_logic;
      PC      : OUT    std_logic_vector (31 DOWNTO 0)
   );
END PC_register ;


ARCHITECTURE struct OF PC_register IS

    -- Architecture declarations
    constant PC_reset : std_logic_vector(31 downto 0) := x"0040_0000";

    -- Signal Declarations

    SIGNAL PC_internal : std_logic_vector(31 downto 0);


BEGIN

    PC <= PC_internal;

    ---------------------------------------------------
    pc_process : PROCESS (clk, rst)
    ---------------------------------------------------

    BEGIN

        -- Asynchronous Reset
        IF (rst = '1') THEN
            -- Reset Actions
            PC_internal <= PC_reset;
        ELSIF (clk'EVENT AND clk = '1') THEN
            PC_internal <= PC_next;
        --ELSE
            -- Do I need this?
            --PC_internal <= PC_next;
        END IF;

    END PROCESS pc_process;

END struct;
