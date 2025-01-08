library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main is
    Port ( 
        stable5mhz : in std_logic;
        row : out std_logic_vector(3 downto 0);
        column : in std_logic_vector(3 downto 0);
        locked : out std_logic := '0';
        tempentereddigit : out std_logic_vector(3 downto 0);
        ledtest : out std_logic_vector(4 downto 0)
        );
end main;

architecture Behavioral of main is
signal rows: std_logic_vector (3 downto 0);
component counter is
    Port (  clk5mhz : in std_logic;
            row : out std_logic_vector(3 downto 0);
            keypadpressed : in std_logic);
end component;

component decoder is
    Port (row : in std_logic_vector(3 downto 0);
          col : in std_logic_vector(3 downto 0);
          currentdigit : out std_logic_vector(4 downto 0));
end component;

component debouncer is
     Port ( keyin : in std_logic;
     keyout : out std_logic;
     clk : in std_logic);
end component;

component password is
    Port ( currentdigit : in STD_LOGIC_VECTOR (4 downto 0);
           clk: in STD_LOGIC;
           correct : out STD_LOGIC;
           blink : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal keyvalueholder, keyvalueholder1 : std_logic_vector(4 downto 0);

begin


kpenc: decoder Port Map (row => rows, col => column, currentdigit => keyvalueholder1);
kpclock : counter Port Map (row => rows, clk5mhz => stable5mhz, keypadpressed =>keyvalueholder1(4));
db4 : debouncer Port Map ( keyin => keyvalueholder1(4), keyout => keyvalueholder(4), clk => stable5mhz);
db3 : debouncer Port Map ( keyin => keyvalueholder1(3), keyout => keyvalueholder(3), clk => stable5mhz);
db2 : debouncer Port Map ( keyin => keyvalueholder1(2), keyout => keyvalueholder(2), clk => stable5mhz);
db1 : debouncer Port Map ( keyin => keyvalueholder1(1), keyout => keyvalueholder(1), clk => stable5mhz);
db0 : debouncer Port Map ( keyin => keyvalueholder1(0), keyout => keyvalueholder(0), clk => stable5mhz);
ledtest <= keyvalueholder;
passwordm: password Port map (currentdigit => keyvalueholder, clk=> stable5mhz , correct => locked , blink => tempentereddigit);

row <= rows;
end Behavioral;