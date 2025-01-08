library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity decoder is
    Port (row : in std_logic_vector(3 downto 0);
          col : in std_logic_vector(3 downto 0);
          currentdigit : out std_logic_vector(4 downto 0));
end decoder;

architecture Behavioral of decoder is
begin

process (row, col) begin
case row is
when "0001" =>
    case col is
    when "1000" => currentdigit <= "10001"; --1
    when "0100" => currentdigit <= "10010"; --2
    when "0010" => currentdigit <= "10011"; --3
    when "0001" => currentdigit <= "11010"; --A
    when others => currentdigit <= "00000"; --no input
    end case;
when "0010" =>
    case col is
    when "1000" => currentdigit <= "10100"; --4
    when "0100" => currentdigit <= "10101"; --5
    when "0010" => currentdigit <= "10110"; --6
    when "0001" => currentdigit <= "11011"; --B
    when others => currentdigit <= "00000"; --no input
    end case;
when "0100" =>
    case col is
    when "1000" => currentdigit <= "10111"; --7
    when "0100" => currentdigit <= "11000"; --8
    when "0010" => currentdigit <= "11001"; --9
    when "0001" => currentdigit <= "11100"; --C
    when others => currentdigit <= "00000"; --no input
    end case;
when "1000" =>
    case col is
    when "1000" => currentdigit <= "11111"; --* (F)
    when "0100" => currentdigit <= "10000"; --0
    when "0010" => currentdigit <= "11110"; --# (E)
    when "0001" => currentdigit <= "11101"; --D
    when others => currentdigit <= "00000"; --no input
    end case;
when others => currentdigit <= "00000";
end case;
end process;
end Behavioral;