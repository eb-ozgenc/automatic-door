library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity debouncer is
     Port ( keyin : in std_logic;
     keyout : out std_logic;
     clk : in std_logic);
end debouncer;

architecture Behavioral of debouncer is
signal bigcount : integer range 0 to 100000 := 0;
signal onecount : integer range 0 to 100000 := 0;
signal zerocount : integer range 0 to 100000 := 0;
begin
process(clk) begin
if rising_edge(clk) then
    bigcount <= bigcount + 1;
    if keyin = '1' then
        onecount <= onecount + 1;
    else
        zerocount <= zerocount + 1;
    end if;
    if bigcount = 100000 then
        if zerocount < onecount then
            keyout <= '1';
        else
            keyout <= '0';
        end if;
        zerocount <= 0;
        onecount <= 0;
     end if;
end if;
end process;        
end Behavioral;