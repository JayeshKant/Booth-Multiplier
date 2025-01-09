library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BoothMultiplier is
     port (
         clock        : in  std_logic;
         reset        : in  std_logic;
         multiplicand : in  std_logic_vector(3 downto 0);
         multiplier   : in  std_logic_vector(3 downto 0);
         product      : out std_logic_vector(7 downto 0);
         valid        : out std_logic
     );
end entity;

architecture booth of BoothMultiplier is
     signal M    : std_logic_vector(3 downto 0);
     signal Q    : std_logic_vector(3 downto 0);
     signal A    : std_logic_vector(3 downto 0) := (others => '0');
     signal q0   : std_logic;
     signal cnt  : unsigned(2 downto 0);
     signal tmp : std_logic_vector(1 downto 0);
begin
     process(clock, reset, multiplicand, multiplier)
     begin
         -- initialize registers
         if reset = '1' then
             M   <= (others => '0');
             Q   <= (others => '0');
             q0  <= '0';
             A   <= (others => '0');
             cnt <= "101";
             tmp <= (others => '0');
         elsif rising_edge(clock) then

          if (cnt > "000") then

                 if cnt = "101" then
             M <= multiplicand;
                  Q <= multiplier;
                  tmp(1) <= multiplier(0);
                  tmp(0) <= q0;
                  cnt <= cnt -1;
                   if multiplicand = "0000" then
                   Q <= "0000";
                   cnt <= "000";
                  elsif multiplier  = "0000" then
                   Q <= "0000";
                   cnt <= "000";
                   elsif multiplicand = "0001" then
                   Q <= multiplier;
                   cnt <= "000";
                  elsif multiplier  = "0001" then
                   Q <= multiplicand;
                   cnt <= "000";
                  end if;


                elsif("101" > cnt) and (cnt > "000") then

                 report "qo = " & std_logic'image(q0);
                 report "Q(0) = " & std_logic'image(Q(0));
                 report "Q(1) = " & std_logic'image(Q(1));
                 report "Q(2) = " & std_logic'image(Q(2));
                 report "Q(3) = " & std_logic'image(Q(3));

                 report "A(0) = " & std_logic'image(A(0));
                 report "A(1) = " & std_logic'image(A(1));
                 report "A(2) = " & std_logic'image(A(2));
                 report "A(3) = " & std_logic'image(A(3));

                 report "tmp(0) = " & std_logic'image(tmp(0));
                 report "tmp(1) = " & std_logic'image(tmp(1));
                            -- Block 1 (ADD/SUB)
             if tmp = "01" then
                report "add";
                 A <= std_logic_vector(unsigned(A) + unsigned(M));
               tmp(1) <= '0';
                    tmp(0) <= '0';

             elsif tmp = "10" then
                report "sub";
                 A <= std_logic_vector(unsigned(A) - unsigned(M));
                 tmp(1) <= '0';
                      tmp(0) <= '0';

                  else
                           -- Block 2 (SHIFT)
                    report "shr";
                    q0 <= Q(0);

                    for i in 0 to 2 loop
                        Q(i) <= Q(i + 1);
                    end loop;

                          Q(3) <= A(0);

                          for i in 0 to 2 loop
                        A(i) <= A(i + 1);
                    end loop;

                          tmp(1) <= Q(1);
                          tmp(0) <= Q(0);
                          cnt <= cnt - 1;
                  report "dec";
                end if;
                 end if;
                 -- Decrement cnt only if it's greater than 0

         end if;

        end if;
     end process;

     product <= (A & Q);

     -- set valid bit indicating if the product has been fully computed (after N clock cycles)
     valid <= '1' when cnt = "000" else '0';

end booth;
