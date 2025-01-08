library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.ALL;

entity counter is
    Port (clk5mhz : in std_logic;
          row : out std_logic_vector(3 downto 0);
          keypadpressed : in std_logic);
end counter;

architecture Behavioral of counter is
signal rowcount : std_logic_vector(1 downto 0) := "00";
signal count : integer range 0 to 50000:= 0;
signal clk50hz : std_logic := '0';
begin

process(clk5mhz)begin
if rising_edge(clk5mhz) then
count <= count + 1;
end if;
if (keypadpressed = '0' and count = 50000) then 
clk50hz <= not clk50hz;
end if;
end process;  

process(clk50hz)begin
if rising_edge(clk50hz) then
rowcount <= rowcount + 1;
end if;
end process;

process (rowcount) begin
case rowcount is 
when "00" => row <= "1000";
when "01" => row <= "0100";
when "10" => row <= "0010";    
when "11" => row <= "0001";      
when others => row <= "0000";
end case;
end process;

end Behavioral;