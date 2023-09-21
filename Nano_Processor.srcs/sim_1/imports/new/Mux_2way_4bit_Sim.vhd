----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/07/2022 08:30:53 PM
-- Design Name: 
-- Module Name: Mux_2way_4bit_Sim - Behavioral
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

entity Mux_2way_4bit_Sim is
--  Port ( );
end Mux_2way_4bit_Sim;

architecture Behavioral of Mux_2way_4bit_Sim is
COMPONENT Mux_2way_4bit
    Port ( IN0 : in STD_LOGIC_VECTOR (3 downto 0); 
           IN1 : in STD_LOGIC_VECTOR (3 downto 0);
           S : in STD_LOGIC; 
           OP : out STD_LOGIC_VECTOR (3 downto 0));
END COMPONENT;
SIGNAL IN0,IN1,OP :STD_LOGIC_VECTOR (3 downto 0);
SIGNAL S : STD_LOGIC; 
begin
UUT : Mux_2way_4bit
    PORT MAP(
            IN0 => IN0,
            IN1 => IN1,
            S => S,
            OP => OP       
            );
PROCESS BEGIN
    IN0 <= "0000";
    IN1 <= "0011";
    S <= '0';
    WAIT FOR 100NS;
    
    IN0 <= "0101";
    IN1 <= "1110";
    S <= '1';
    WAIT FOR 100NS;
    
    S <= '0';
    WAIT FOR 100NS;
    
    IN0 <= "0101";
    IN1 <= "0000";
    S <= '0';
    WAIT FOR 100NS;
    
    S <= '1';
    WAIT FOR 100NS;
    
    -- 200277G
    -- 0011 0000 1110 0101 0101
END PROCESS;
end Behavioral;