LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;

ENTITY ALU IS
   PORT( 
      A           : IN     std_logic_vector (31 DOWNTO 0);
      ALU_control : IN     std_logic_vector (3 DOWNTO 0);
      B           : IN     std_logic_vector (31 DOWNTO 0);
      ALU_result  : OUT    std_logic_vector (31 DOWNTO 0);
      zero        : OUT    std_logic
   );
END ALU ;


ARCHITECTURE behav OF ALU IS
  
   -- Architecture declarations
   constant zero_value : std_logic_vector(31 downto 0) := (others => '0');
   constant one_value : std_logic_vector(31 downto 0) := (zero_value(31 downto 1) & '1');

   -- Internal signal declarations
   SIGNAL ALU_result_internal : std_logic_vector(31 DOWNTO 0);
   SIGNAL zero_internal : std_logic;

BEGIN

   ALU_result <= ALU_result_internal;
   
   zero <= '1' when (ALU_result_internal = zero_value)
   ELSE '0';
         
   alu_process: PROCESS (ALU_control, A, B) 
   
   BEGIN   
   
   CASE ALU_control IS
   
       when "0000" => ALU_result_internal <= A AND B;
       when "0001" => ALU_result_internal <= A OR B;
       when "0010" => ALU_result_internal <= A + B;
       when "0110" => ALU_result_internal <= A - B;
       when "0111" => 
           IF ( A < B ) THEN 
           ALU_result_internal <= one_value;
           ELSE
           ALU_result_internal <= zero_value;
           END IF;
       when "1100" => ALU_result_internal <= A NOR B;
       when others => 
           ALU_result_internal <= zero_value;
           zero_internal <= '1';
           
     END CASE;
     
--     IF ALU_result_internal = zero_value THEN
--          zero <= "1";
--     ELSE
--          zero <= "0";
--     END IF;
   
   END PROCESS;
       
END behav;
