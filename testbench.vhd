-- Code your design here
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_processor is
end tb_processor;

architecture behavior of tb_processor is
    component processor_4bit
        Port (
            clk         : in  STD_LOGIC;
            reset       : in  STD_LOGIC;
            opcode      : in  STD_LOGIC_VECTOR(1 downto 0);
            input_A     : in  STD_LOGIC_VECTOR(3 downto 0);
            input_B     : in  STD_LOGIC_VECTOR(3 downto 0);
            alu_out     : out STD_LOGIC_VECTOR(3 downto 0);
            zero_flag   : out STD_LOGIC
        );
    end component;

    signal clk       : std_logic := '0';
    signal reset     : std_logic := '0';
    signal opcode    : std_logic_vector(1 downto 0) := "00";
    signal input_A   : std_logic_vector(3 downto 0) := "0000";
    signal input_B   : std_logic_vector(3 downto 0) := "0000";
    signal alu_out   : std_logic_vector(3 downto 0);
    signal zero_flag : std_logic;

    constant clk_period : time := 10 ns;
begin

    uut: processor_4bit port map (
          clk => clk,
          reset => reset,
          opcode => opcode,
          input_A => input_A,
          input_B => input_B,
          alu_out => alu_out,
          zero_flag => zero_flag
        );

    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    stim_proc: process
    begin		
        reset <= '1';
        wait for 20 ns;	
        reset <= '0';
        wait for 20 ns;

        -- ADD: 5 + 3 = 8
        opcode <= "00";
        input_A <= "0101"; 
        input_B <= "0011"; 
        wait for 20 ns;

        -- SUB: 7 - 2 = 5
        opcode <= "01";
        input_A <= "0111"; 
        input_B <= "0010"; 
        wait for 20 ns;

        -- ZERO FLAG test: 4 - 4 = 0
        opcode <= "01";
        input_A <= "0100"; 
        input_B <= "0100"; 
        wait for 20 ns;

        std.env.finish;
    end process;

end behavior;