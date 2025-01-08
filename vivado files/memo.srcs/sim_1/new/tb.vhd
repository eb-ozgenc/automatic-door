library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
component realtopmodule is
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
end component;

signal clk :std_logic := '0';
signal row : std_logic_vector(3 downto 0):= "1000";
signal column :  std_logic_vector(3 downto 0) := "0000";
signal kout: std_logic := '0';
signal doorin:  std_logic:= '0';
signal servo1: std_logic;
signal servo2: std_logic;
signal tempentereddigit: std_logic_vector(3 downto 0);
signal led: std_logic_vector(4 downto 0);

begin

top: realtopmodule port map (clk, row, column, kout, doorin, servo1, servo2, tempentereddigit, led);

process begin
    wait for 5 ns;
    clk <= not clk;
end process;

process begin
    wait for 100 ms;
    doorin <= not doorin;
end process;

process begin
    wait for 5.1 ms;
    column <= "0100";
    wait for 0.1 ms;
    column <= "0000";
    wait for 60 ms;
    column <= "0100";
    wait for 0.1 ms;
    column <= "0000";
    wait for 80 ms;
    column <= "1000";
    wait for 0.1 ms;
    column <= "0000";
    wait for 80 ms;
    column <= "0001";
    wait for 0.1 ms;
    column <= "0000";
    wait for 80 ms;
    column <= "0001";
    wait for 0.1 ms;
    column <= "0000";
    wait for 1 ms;
    wait;
end process;

end Behavioral;
