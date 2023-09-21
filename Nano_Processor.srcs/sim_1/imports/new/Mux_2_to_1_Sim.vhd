----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/07/2022 06:02:33 PM
-- Design Name: 
-- Module Name: Mux_2_to_1_Sim - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux_2_to_1_Sim is
--  Port ( );
end Mux_2_to_1_Sim;

architecture Behavioral of Mux_2_to_1_Sim is
component Mux_2_to_1
    Port ( D0 : in STD_LOGIC;
           D1 : in STD_LOGIC;
           S : in STD_LOGIC;
           Y : out STD_LOGIC);
end component;
signal D0,D1,S,Y : STD_LOGIC;
begin
UUT : Mux_2_to_1
    PORT MAP(
    D0 => D0,
    D1 => D1,
    S => S,
    Y => Y
    );
PROCESS BEGIN
    D0 <= '1';
    D1 <= '0';
    S  <= '1';
    WAIT FOR 50NS;
    S <= '0';
    WAIT FOR 50NS;
    D0 <= '0';
    D1 <= '1';
    S  <= '0';
    WAIT FOR 50NS;
    
    --200277G
    --110 000 111 001 010 101
    
END PROCESS;
end Behavioral;
