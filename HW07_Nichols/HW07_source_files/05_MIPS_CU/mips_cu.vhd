LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


ENTITY Main_Control_Unit IS
   PORT( 
      Instruction_31_26 : IN     std_logic_vector (5 DOWNTO 0);
      ALUOp             : OUT    std_logic_vector (1 DOWNTO 0);
      ALUSrc            : OUT    std_logic;
      Branch            : OUT    std_logic;
      Jump              : OUT    std_logic;
      MemRead           : OUT    std_logic;
      MemToReg          : OUT    std_logic;
      MemWrite          : OUT    std_logic;
      RegDst            : OUT    std_logic;
      RegWrite          : OUT    std_logic
   );
END Main_Control_Unit ;

ARCHITECTURE struct OF Main_Control_Unit IS

--Internal Signal Declaration - Do I need this?
SIGNAL r_type, lw, sw, beq, addi, j : std_logic;

BEGIN
                -- Set Instruction Operation --
    ------------------------------------------------------------
    r_type <= '1' when Instruction_31_26 = "000000" else '0';
    lw <= '1' when Instruction_31_26 = "100011" else '0';
    sw <= '1' when Instruction_31_26 = "101011" else '0';
    beq <= '1' when Instruction_31_26 = "000100" else '0';
    j <= '1' when Instruction_31_26 = "000010" else '0';
    addi <= '1' when Instruction_31_26 = "001000" else '0';
    ------------------------------------------------------------
    
                    -- Set Output Logic --
    ------------------------------------------------------------
    ALUOp(0) <= beq;
    ALUOp(1) <= r_type;
    ALUSrc <= lw OR sw OR addi;
    Branch <= beq;
    MemRead <= lw; 
    MemToReg <= lw;
    MemWrite <= sw;
    RegDst <= r_type;
    RegWrite <= r_type OR lw OR addi;
    Jump <= j;
    ------------------------------------------------------------
  
END struct;
