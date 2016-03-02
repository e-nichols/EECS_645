----------------------------------------------------------------------------------
-- Name: Evan Nichols
-- Class: EECS 645
-- Title: Problem 1 Structural VHDL
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity prob1_struct is
    Port (
        REQ_01 : IN     std_logic;
        REQ_02 : IN     std_logic;
        clk    : IN     std_logic;
        rst    : IN     std_logic;
        ACK_01 : OUT    std_logic;
        ACK_02 : OUT    std_logic
        );   
end prob1_struct;

architecture Behavioral of prob1_struct is

    --Declare current and next state signals
    SIGNAL s1_current, s2_current : std_logic;
    SIGNAL s1_next,    s2_next    : std_logic;

BEGIN

    -------------------------------------------------------
        memory_elements : PROCESS(clk, rst)
    -------------------------------------------------------
    BEGIN
        IF (rst = '1') THEN
            s1_current <= '0';
            s2_current <= '0';
            --Reset Values
        ELSIF (clk'EVENT AND clk = '1') THEN
            s1_current <= s1_next;
            s2_current <= s2_next;
        END IF;
    END PROCESS memory_elements;

    ------------------------------------------------------- 
    --state logic    
    -------------------------------------------------------
    s1_next <= (REQ_01 and (not REQ_02) and (not s2_current)) or 
               (REQ_01 and s1_current and (not s2_current));

    s2_next <= ((not s1_current) and REQ_02);


    ------------------------------------------------------- 
    --output logic
    -------------------------------------------------------
    ACK_01 <= (s1_current and (not s2_current));
    ACK_02 <= (s2_current and (not s1_current));
    
end Behavioral;
