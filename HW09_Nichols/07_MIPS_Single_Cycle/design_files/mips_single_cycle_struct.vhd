--
-- VHDL Entity mips_lib.mips_single_cycle.symbol
--
-- Created:
--          by - Evan Nichols
--          at - 23:38:29 05/02/2011
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.ALL;


ENTITY mips_single_cycle IS
   PORT(
      clk : IN     std_logic;
      rst : IN     std_logic
   );
END mips_single_cycle ;


ARCHITECTURE struct OF mips_single_cycle IS

   -- Internal signal declarations
   SIGNAL ALUOp                                       : std_logic_vector(1 DOWNTO 0);
   SIGNAL ALUSrc                                      : std_logic;
   SIGNAL ALU_control                                 : std_logic_vector(3 DOWNTO 0);
   SIGNAL ALU_result                                  : std_logic_vector(31 DOWNTO 0);
   SIGNAL Branch                                      : std_logic;
   SIGNAL Instruction                                 : std_logic_vector(31 DOWNTO 0);
   SIGNAL Instruction_15_0_Sign_Extended              : std_logic_vector(31 DOWNTO 0);
   SIGNAL Instruction_15_0_Sign_Extended_Left_Shifted : std_logic_vector(31 DOWNTO 0);
   SIGNAL Instruction_25_0_Left_Shifted               : std_logic_vector(27 DOWNTO 0);
   SIGNAL Jump                                        : std_logic;
   SIGNAL MemRead                                     : std_logic;
   SIGNAL MemToReg                                    : std_logic;
   SIGNAL MemWrite                                    : std_logic;
   SIGNAL PC                                          : std_logic_vector(31 DOWNTO 0);
   SIGNAL PC_incremented                               : std_logic_vector(31 DOWNTO 0);
   SIGNAL PC_next                                     : std_logic_vector(31 DOWNTO 0);
   SIGNAL RegDst                                      : std_logic;
   SIGNAL RegWrite                                    : std_logic;
   SIGNAL adder_second_result                         : std_logic_vector(31 DOWNTO 0);
   SIGNAL alu_second_operand                          : std_logic_vector(31 DOWNTO 0);
   SIGNAL branch_when_equal                           : std_logic;
   SIGNAL dm_ReadData                                 : std_logic_vector(31 DOWNTO 0);
   SIGNAL jump_address                                : std_logic_vector(31 DOWNTO 0);
   SIGNAL mux_second_i3_output                        : std_logic_vector(31 DOWNTO 0);
   SIGNAL regfile_ReadData_1                          : std_logic_vector(31 DOWNTO 0);
   SIGNAL regfile_ReadData_2                          : std_logic_vector(31 DOWNTO 0);
   SIGNAL regfile_WriteAddr                           : std_logic_vector(4 DOWNTO 0);
   SIGNAL regfile_WriteData                           : std_logic_vector(31 DOWNTO 0);
   SIGNAL zero                                        : std_logic;


   -- Component Declarations
   COMPONENT ALU
   PORT (
      A           : IN     std_logic_vector (31 DOWNTO 0);
      ALU_control : IN     std_logic_vector (3 DOWNTO 0);
      B           : IN     std_logic_vector (31 DOWNTO 0);
      ALU_result  : OUT    std_logic_vector (31 DOWNTO 0);
      zero        : OUT    std_logic
   );
   END COMPONENT;

   COMPONENT ALU_controller
   PORT (
      ALU_op      : IN     std_logic_vector (1 DOWNTO 0);
      funct       : IN     std_logic_vector (5 DOWNTO 0);
      ALU_control : OUT    std_logic_vector (3 DOWNTO 0)
   );
   END COMPONENT;

   COMPONENT DM
   PORT (
      Address   : IN     std_logic_vector (31 DOWNTO 0);
      MemRead   : IN     std_logic ;
      MemWrite  : IN     std_logic ;
      WriteData : IN     std_logic_vector (31 DOWNTO 0);
      clk       : IN     std_logic ;
      rst       : IN     std_logic ;
      ReadData  : OUT    std_logic_vector (31 DOWNTO 0)
   );
   END COMPONENT;

   COMPONENT First_Shift_Left_2
   PORT (
      Instruction_25_0              : IN     std_logic_vector (25 DOWNTO 0);
      Instruction_25_0_Left_Shifted : OUT    std_logic_vector (27 DOWNTO 0)
   );
   END COMPONENT;

   COMPONENT IM
   PORT (
      ReadAddress : IN     std_logic_vector (31 DOWNTO 0);
      rst         : IN     std_logic ;
      Instruction : OUT    std_logic_vector (31 DOWNTO 0)
   );
   END COMPONENT;

   COMPONENT Main_Control_Unit
   PORT (
      Instruction_31_26 : IN     std_logic_vector (5 DOWNTO 0);
      ALUOp             : OUT    std_logic_vector (1 DOWNTO 0);
      ALUSrc            : OUT    std_logic ;
      Branch            : OUT    std_logic ;
      Jump              : OUT    std_logic ;
      MemRead           : OUT    std_logic ;
      MemToReg          : OUT    std_logic ;
      MemWrite          : OUT    std_logic ;
      RegDst            : OUT    std_logic ;
      RegWrite          : OUT    std_logic
   );
   END COMPONENT;

   COMPONENT PC_register
   PORT (
      PC_next : IN     std_logic_vector (31 DOWNTO 0);
      clk     : IN     std_logic ;
      rst     : IN     std_logic ;
      PC      : OUT    std_logic_vector (31 DOWNTO 0)
   );
   END COMPONENT;

   COMPONENT RegFile
   PORT (
      ReadAddr_1 : IN     std_logic_vector (4 DOWNTO 0);
      ReadAddr_2 : IN     std_logic_vector (4 DOWNTO 0);
      RegWrite   : IN     std_logic ;
      WriteAddr  : IN     std_logic_vector (4 DOWNTO 0);
      WriteData  : IN     std_logic_vector (31 DOWNTO 0);
      clk        : IN     std_logic ;
      rst        : IN     std_logic ;
      ReadData_1 : OUT    std_logic_vector (31 DOWNTO 0);
      ReadData_2 : OUT    std_logic_vector (31 DOWNTO 0)
   );
   END COMPONENT;

   COMPONENT Second_Shift_Left_2
   PORT (
      Instruction_15_0_Sign_Extended              : IN     std_logic_vector (31 DOWNTO 0);
      Instruction_15_0_Sign_Extended_Left_Shifted : OUT    std_logic_vector (31 DOWNTO 0)
   );
   END COMPONENT;

   COMPONENT adder_first
   PORT (
      PC            : IN     std_logic_vector (31 DOWNTO 0);
      PC_incremented : OUT    std_logic_vector (31 DOWNTO 0)
   );
   END COMPONENT;

   COMPONENT adder_second
   PORT (
      A          : IN     std_logic_vector (31 DOWNTO 0);
      B          : IN     std_logic_vector (31 DOWNTO 0);
      add_result : OUT    std_logic_vector (31 DOWNTO 0)
   );
   END COMPONENT;

   COMPONENT mux_first
   PORT (
      instruction_15_11 : IN     std_logic_vector (4 DOWNTO 0);
      instruction_20_16 : IN     std_logic_vector (4 DOWNTO 0);
      sel               : IN     std_logic ;
      output            : OUT    std_logic_vector (4 DOWNTO 0)
   );
   END COMPONENT;

   COMPONENT mux_second
   PORT (
      input_0 : IN     std_logic_vector (31 DOWNTO 0);
      input_1 : IN     std_logic_vector (31 DOWNTO 0);
      sel     : IN     std_logic ;
      output  : OUT    std_logic_vector (31 DOWNTO 0)
   );
   END COMPONENT;

   COMPONENT sign_extend
   PORT (
      Instruction_15_0               : IN     std_logic_vector (15 DOWNTO 0);
      Instruction_15_0_Sign_Extended : OUT    std_logic_vector (31 DOWNTO 0)
   );
   END COMPONENT;


BEGIN

    -- Declare branch_when_equal signal
    branch_when_equal <= zero AND Branch;
    jump_address <= PC_Incremented(31 DOWNTO 28) & Instruction_25_0_Left_Shifted;
    
    -- Program Counter Component Instantiation (CI)
    Program_Counter : PC_register PORT MAP(PC_next, clk, rst, PC);

    -- Instruction Memory CI -- Confirmed
    Instruction_Memory: IM PORT MAP (PC, rst, Instruction);

    -- Main Control Unit CI -- Confirmed
    Main_Control : Main_Control_Unit PORT MAP (
        Instruction(31 DOWNTO 26),
        ALUOp,
        ALUSrc,
        Branch,
        Jump,
        MemRead,
        MemToReg,
        MemWrite,
        RegDst,
        RegWrite );

    -- Mux_1 CI -- Confirmed
    mux_1 : mux_first PORT MAP (
        Instruction(15 DOWNTO 11),
        Instruction(20 DOWNTO 16),
        RegDst,
        regfile_WriteAddr);

    -- Register File CI -- Confirmed
    reg_file : RegFile PORT MAP (
        Instruction(25 DOWNTO 21),
        Instruction(20 DOWNTO 16),
        RegWrite,
        regfile_WriteAddr,
        regfile_WriteData,
        clk,
        rst,
        regfile_ReadData_1,
        regfile_ReadData_2 );

    -- Mux_2 CI -- Confirmed
    mux_2 : mux_second PORT MAP (
        regfile_ReadData_2,
        Instruction_15_0_Sign_Extended,
        ALUSrc,
        alu_second_operand
    );

    -- sign_extend CI -- Confirmed
    sign_extender : sign_extend PORT MAP (
        Instruction(15 DOWNTO 0),
        Instruction_15_0_Sign_Extended
    );

    -- ALU_control CI -- Confirmed
    alu_control_unit : ALU_controller PORT MAP (
        ALUOp,
        Instruction(5 DOWNTO 0),
        ALU_control
    );

    -- ALU CI -- Confirmed
    alu_unit : ALU PORT MAP (
        regfile_ReadData_1,
        ALU_control,
        alu_second_operand,
        ALU_result,
        zero
    );

    -- Data Mem CI -- Confirmed
    Data_Memory : DM PORT MAP (
        ALU_result,
        MemRead,
        MemWrite,
        regfile_ReadData_2,
        clk,
        rst,
        dm_ReadData
    );

    -- Mux_3 CI -- Confirmed
    mux_3 : mux_second PORT MAP (
        ALU_result,
        dm_ReadData,
        MemToReg,
        regfile_WriteData
    );

    -- adder_first CI -- Confirmed
    adder_1 : adder_first PORT MAP (
        PC,
        PC_incremented
    );

    -- adder_second CI -- Confirmed
    adder_2 : adder_second PORT MAP (
        PC_incremented,
        Instruction_15_0_Sign_Extended_Left_Shifted,
        adder_second_result
    );

    -- Second_Shift_Left_1 CI -- Confirmed
    second_shift_left_2_1 : First_Shift_Left_2 PORT MAP (
        Instruction(25 DOWNTO 0),
        Instruction_25_0_Left_Shifted
    );

    -- First_Shift_Left_2 CI -- Confirmed
    second_shift_left_2_2 : Second_Shift_Left_2 PORT MAP (
        Instruction_15_0_Sign_Extended,
        Instruction_15_0_Sign_Extended_Left_Shifted
    );

    -- Mux_4 CI -- QUESTIONS
    mux_4 : mux_second PORT MAP (
        PC_incremented,
        adder_second_result,
        branch_when_equal, -- IS THIS VALID? Log Ops in Input? Or is it branch_when_equal?
        mux_second_i3_output -- WHAT IS THE OUTPUT SIGNAL HERE?
    );

    -- Mux_5 CI -- QUESTIONS
    mux_5 : mux_second PORT MAP (
        mux_second_i3_output,
        jump_address,
        Jump,
        PC_next
    );

END struct;
