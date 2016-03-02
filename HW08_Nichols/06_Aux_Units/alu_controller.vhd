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

	--Internal Signal Declarations
	SIGNAL ALU_control_internal : std_logic_vector(3 DOWNTO 0);

BEGIN

	ALU_control <= ALU_control_internal;

	--------------------------------------------------------------------------------
	alu_control_process : PROCESS (ALU_op, funct, ALU_control)
	--------------------------------------------------------------------------------

-- No idea what I'm doing	
BEGIN
	
		CASE ALU_op IS
		WHEN "00" =>
			CASE 
			ALU_control_internal <= "0010";
		

END struct;
