library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity password is
    Port ( currentdigit : in STD_LOGIC_VECTOR (4 downto 0);
           clk: in STD_LOGIC;
           correct : out STD_LOGIC;
           blink : out STD_LOGIC_VECTOR (3 downto 0));
end password;
 
architecture Behavioral of password is
signal enteredpin: STD_LOGIC_VECTOR (19 downto 0) := "00000000000000000000";
constant correctpin: STD_LOGIC_VECTOR (19 downto 0) := '1' & x"1" & '1' & x"2" & '1' & x"3" & '1' & x"4";
signal datafull, corrects: STD_LOGIC;
begin
datafull <= enteredpin(4) and enteredpin(9) and enteredpin(14) and enteredpin(19);

process(currentdigit) begin
    if rising_edge(currentdigit(4)) then
        if corrects = '0' and enteredpin = correctpin and datafull ='1' then
            corrects <= '1';
            enteredpin <= "00000000000000000000";
        end if;
        if corrects = '0' and enteredpin /= correctpin and datafull ='1' then
            enteredpin <= "00000000000000000000";
        end if;
        if corrects = '1' and datafull ='1' then
            corrects <= '0'; 
            enteredpin <= "00000000000000000000";
        end if;
        
        if enteredpin(4) = '0' then
            enteredpin(4 downto 0) <= currentdigit;
        elsif enteredpin(9) = '0' then
            enteredpin(9 downto 5) <= currentdigit;
        elsif enteredpin(14) = '0' then
            enteredpin(14 downto 10) <= currentdigit; 
        elsif enteredpin(19) = '0' then
            enteredpin(19 downto 15) <= currentdigit;
        end if;
    end if;
end process;

blink <= enteredpin(4)&enteredpin(9)&enteredpin(14)&enteredpin(19);
correct <= corrects;
end Behavioral;