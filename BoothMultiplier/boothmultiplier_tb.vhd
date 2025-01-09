library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity boothmultiplier_tb is 
end entity; 

architecture tb_arch of boothmultiplier_tb is 
signal clock: std_logic := '0';
signal reset: std_logic := '0'; 
signal multiplicand , multiplier := signed(4 downto 1) := (others => '0');
signal  product      : out signed(2*4 downto 1);
signal valid : out std_logic;

component BoothMultiplier
port 
( port (
        clock        : in  std_logic;
        reset        : in  std_logic;
        multiplicand : in  signed(4 downto 1);
        multiplier   : in  signed(4 downto 1);
        product      : out signed(2*4 downto 1);
        valid        : out std_logic
    );
	 end component; 

begin

UUT : BoothMultiplier port map (
    clock => clock,
	 reset => reset,
	 multiplicand => mul

)
 

end architecture;