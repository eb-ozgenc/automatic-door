library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity servocontroller is
    Port ( clk5mhz : in STD_LOGIC;
           dooropen : in STD_LOGIC;
           servocontrol1 : out STD_LOGIC;
           servocontrol2 : out STD_LOGIC);
end servocontroller;
architecture Behavioral of servocontroller is

signal count : std_logic_vector (17 downto 0) := "000000000000000000";


begin


process (clk5mhz)
begin
if count = 100000 then
count <= "000000000000000000";
elsif rising_edge(clk5mhz) then
count <= count + 1;
end if;
if count = 0 then
servocontrol1 <= '1';
servocontrol2 <= '1';
elsif (dooropen = '1' and count = 5000) or (dooropen = '0' and count = 10000) then
servocontrol1 <= '0' ;
elsif (dooropen = '0' and count = 5000) or (dooropen = '1' and count = 10000) then
servocontrol2 <= '0' ;
end if;
end process;
end Behavioral;
