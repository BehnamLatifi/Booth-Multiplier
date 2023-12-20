LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY main_tb IS
END main_tb;
 
ARCHITECTURE behavior OF main_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT main
    PORT(
         inp1 : IN  std_logic_vector(5 downto 0);
         inp2 : IN  std_logic_vector(5 downto 0);
         clk : IN  std_logic;
         rst : IN  std_logic;
         done : OUT  std_logic;
         p : OUT  std_logic_vector(11 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal inp1 : std_logic_vector(5 downto 0) := (others => '0');
   signal inp2 : std_logic_vector(5 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal done : std_logic;
   signal p : std_logic_vector(11 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main 
			PORT MAP (
          inp1 => inp1,
          inp2 => inp2,
          clk => clk,
          rst => rst,
          done => done,
          p => p
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
rst <= '1', '0' after 10 ns;
inp1 <= "110101";
inp2 <= "011101";

END;
