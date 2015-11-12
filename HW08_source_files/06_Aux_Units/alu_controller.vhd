LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


ENTITY ALU_controller IS
   PORT(
      ALU_op      : IN     std_logic_vector (1 DOWNTO 0);
      funct       : IN     std_logic_vector (5 DOWNTO 0);
      ALU_control : OUT    std_logic_vector (3 DOWNTO 0)
   );
END ALU_controller ;


ARCHITECTURE struct OF ALU_controller IS

    -- Architecture declarations
    constant zero_value : std_logic_vector(3 DOWNTO 0) := (others => '0');

    -- Internal Signal declarations
    SIGNAL ALU_control_internal : std_logic_vector(3 DOWNTO 0);

BEGIN

    --------------------------------------------------
    alu_control_process : PROCESS (ALU_op, funct)
    --------------------------------------------------

    BEGIN

        CASE ALU_op IS
            WHEN "00" => ALU_control <= "0010";
            WHEN "01" => ALU_control <= "0110";
                -- BEQ Code
            WHEN "10" =>
                CASE funct IS
                    WHEN "100000" => ALU_control <= "0010";
                    WHEN "100010" => ALU_control <= "0110";
                    WHEN "100100" => ALU_control <= "0000";
                    WHEN "100101" => ALU_control <= "0001";
                    WHEN "101010" => ALU_control <= "0111";
                    -- DO I NEED THIS DEFAULT CASE  ???????
                    WHEN OTHERS => ALU_control <= zero_value;
                END CASE;

        END CASE;

    END PROCESS alu_control_process;

END struct;
