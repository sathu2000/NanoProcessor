----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/07/2022 09:03:22 PM
-- Design Name: 
-- Module Name: Mux_8way_4bit_Sim - Behavioral
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

entity Mux_8way_4bit_Sim is
--  Port ( );
end Mux_8way_4bit_Sim;

architecture Behavioral of Mux_8way_4bit_Sim is
component Mux_8way_4bit
    Port ( IN0 : in STD_LOGIC_VECTOR (3 downto 0); 
           IN1 : in STD_LOGIC_VECTOR (3 downto 0);
           IN2 : in STD_LOGIC_VECTOR (3 downto 0);
           IN3 : in STD_LOGIC_VECTOR (3 downto 0);
           IN4 : in STD_LOGIC_VECTOR (3 downto 0);
           IN5 : in STD_LOGIC_VECTOR (3 downto 0);
           IN6 : in STD_LOGIC_VECTOR (3 downto 0);
           IN7 : in STD_LOGIC_VECTOR (3 downto 0);
           S : in STD_LOGIC_VECTOR (2 DOWNTO 0); 
           OP : out STD_LOGIC_VECTOR (3 downto 0));    
end component;
signal IN0,IN1,IN2,IN3,IN4,IN5,IN6,IN7,OP : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL S : STD_LOGIC_VECTOR (2 DOWNTO 0);
begin
UUT : Mux_8way_4bit
PORT MAP( IN0 => IN0,
        IN1 => IN1,
        IN2 => IN2,
        IN3 => IN3,
        IN4 => IN4,
        IN5 => IN5,
        IN6 => IN6,
        IN7 => IN7,
        OP => OP,
        S => S
            );
PROCESS BEGIN
    IN0 <= "0000";
    IN1 <= "0010";
    IN2 <= "0001";
    IN3 <= "0011";
    IN4 <= "0110";
    IN5 <= "0111";
    IN6 <= "0101";
    IN7 <= "1000";
    
    S <= "000";
    WAIT FOR 100NS;
    S <= "001";
    WAIT FOR 100NS;
    S <= "010";
    WAIT FOR 100NS;
    S <= "011";
    WAIT FOR 100NS;
    S <= "100";
    WAIT FOR 100NS;
    S <= "101";
    WAIT FOR 100NS;
    S <= "110";
    WAIT FOR 100NS;
    S <= "111";
    WAIT FOR 100NS;
    
    -- 200277G
    -- 0011 0000 1110 0101 0101
END PROCESS;
end Behavioral;
