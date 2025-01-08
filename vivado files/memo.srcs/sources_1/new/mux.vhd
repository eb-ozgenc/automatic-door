library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
    Port ( s : in STD_LOGIC;
           in1 : in STD_LOGIC;
           in2 : in STD_LOGIC;
           sout : out STD_LOGIC);
end mux;

architecture Behavioral of mux is
begin

sout <= in1 when s = '1' else in2;

end Behavioral;
