
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity realtopmodule is
    Port ( 
        clk100mhz : in std_logic;
        row : out std_logic_vector(3 downto 0);
        column : in std_logic_vector(3 downto 0);
        keypadout : out std_logic := '0';
        doorin: in std_logic;
        servo1: out std_logic;
        servo2: out std_logic;
        tempentereddigit : out std_logic_vector(3 downto 0);
        digit : out std_logic_vector(4 downto 0)
        );
end realtopmodule;

architecture Behavioral of realtopmodule is

component mux is
    Port ( s : in STD_LOGIC;
           in1 : in STD_LOGIC;
           in2 : in STD_LOGIC;
           sout : out STD_LOGIC);
end component;

component clk_wiz_0
port
 (clk_out1: out std_logic;
  reset: in std_logic;
  clklocked: out std_logic;
  clk_in1: in std_logic);
end component;

component servocontroller is
    Port ( clk5mhz : in STD_LOGIC;
           dooropen : in STD_LOGIC;
           servocontrol1 : out STD_LOGIC;
           servocontrol2 : out STD_LOGIC);
end component;

component main is
    Port ( 
        stable5mhz : in std_logic;
        row : out std_logic_vector(3 downto 0);
        column : in std_logic_vector(3 downto 0);
        locked : out std_logic := '0';
        tempentereddigit : out std_logic_vector(3 downto 0);
        ledtest : out std_logic_vector(4 downto 0)
        );
end component;

signal clk5mhz, stable5mhz, lockedclock, door, openmydoor, doorreg: std_logic;
begin


stable5mhz <= clk5mhz and lockedclock;
mhz5clkmain : clk_wiz_0 port map ( clk_out1 => clk5mhz ,reset => '0', clklocked => lockedclock, clk_in1 => clk100mhz);
servo: servocontroller Port Map( clk5mhz => stable5mhz, dooropen => openmydoor, servocontrol1 => servo1, servocontrol2 => servo2);

keypad1: main
    Port Map ( 
        stable5mhz => stable5mhz,
        row => row,
        column => column,
        locked => door,
        tempentereddigit => tempentereddigit,
        ledtest => digit);
     
keypadout <= door;

openmydoor <= doorin;

end Behavioral;
