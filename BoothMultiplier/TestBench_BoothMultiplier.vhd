library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TestBench_BoothMultiplier is

end entity;

architecture tb of TestBench_BoothMultiplier is
     constant CLK_PERIOD : time := 10 ns; -- Clock period
     signal clock, reset : std_logic := '0';
     signal multiplicand: std_logic_vector(3 downto 0);
     signal multiplier: std_logic_vector(3 downto 0);
     signal product : std_logic_vector(7 downto 0);
     signal valid : std_logic;

     component BoothMultiplier
         port (
             clock        : in  std_logic;
             reset        : in  std_logic;
             multiplicand : in  std_logic_vector(3 downto 0);
             multiplier   : in  std_logic_vector(3 downto 0);
             product      : out std_logic_vector(7 downto 0);
             valid        : out std_logic
         );
     end component;

begin
     -- Instantiate the BoothMultiplier
     UUT : BoothMultiplier
         port map (
             clock        => clock,
             reset        => reset,
             multiplicand => multiplicand,
             multiplier   => multiplier,
             product      => product,
             valid        => valid
         );

     -- Clock process
     process
     begin
         while now < 100 ns loop
             clock <= '0';
             wait for CLK_PERIOD / 2;
             clock <= '1';
             wait for CLK_PERIOD / 2;
         end loop;
         wait;
     end process;

     -- Stimulus process
     process
     begin
         -- Initialize inputs
         reset <= '1';
         wait for CLK_PERIOD;

         reset <= '0';
         multiplicand <= "0011";  -- Example multiplicand
         multiplier   <= "0011";  -- Example multiplier

         wait for CLK_PERIOD * 10; -- Allow for some clock cycles

         assert product = std_logic_vector(signed(multiplicand) *
signed(multiplier));
             report "Test failed: Product does not match expected value"
             severity error;

         wait;
     end process;

end tb;



