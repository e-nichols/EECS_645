library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity prob1_behavorial_tb is
end prob1_behavorial_tb;

architecture Behavioral of prob1_behavorial_tb is

    --Component Declaration for the Unit Under Test (UUT)
    COMPONENT prob01_behav is
        PORT (
            REQ_01 : IN     std_logic;
            REQ_02 : IN     std_logic;
            clk    : IN     std_logic;
            rst    : IN     std_logic;
            ACK_01 : OUT    std_logic;
            ACK_02 : OUT    std_logic
            );
    END COMPONENT;
    
    --Inputs
    signal REQ_01 : std_logic := '0';
    signal REQ_02 : std_logic := '0';
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';

    --Outputs
    signal ACK_01 : std_logic;
    signal ACK_02 : std_logic;
    
    --Clock Period Definitions
    constant clk_period : time := 10 ns;
    
begin

    --Instantiate the Unit Under Test (UUT)
    uut: prob01_behav PORT MAP (
                                    REQ_01 => REQ_01,
                                    REQ_02 => REQ_02,
                                    clk => clk,
                                    rst => rst,
                                    ACK_01 => ACK_01,
                                    ACK_02 => ACK_02
                                    );
                                    
    --Clock Process Definitions
    clk_process :process
    begin
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
    end process;
    
    --Stimulus Process
    stim_proc: process
    begin
    
        --hold reset state for 3 clock periods
            rst <= '1';
        wait for clk_period*3;
            
            rst <= '0';
        wait for clk_period*3;

        -- insert stimulus here
            REQ_01 <= '1';
            REQ_02 <= '1';
        wait for clk_period*3;
        
            REQ_01 <= '1';
            REQ_02 <= '0';
        wait for clk_period*3;

            REQ_01 <= '1';
            REQ_02 <= '1';
        wait for clk_period*3;
        
            REQ_01 <= '0';
            REQ_02 <= '1';
        wait for clk_period*3;
        
            REQ_01 <= '1';
            REQ_02 <= '1';
        wait for clk_period*3;
        
            REQ_01 <= '1';
            REQ_02 <= '0';
        wait for clk_period*3;
        
            REQ_01 <= '1';
            REQ_02 <= '1';
        wait for clk_period*3;
        
            REQ_01 <= '0';
            REQ_02 <= '0';
        wait for clk_period*9;
        
            REQ_01 <= '0';
            REQ_02 <= '1';
        wait for clk_period*3;
        
            rst <= '1';
        wait for clk_period*3;              

            rst <= '0';
        wait for clk_period*3;
        
        wait;
        
    end process;
    
end;
