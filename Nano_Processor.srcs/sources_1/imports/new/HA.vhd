----------------------------------------------------------------------------------
-- Company: UOM
-- Engineer: U.Sathurgini
-- 
-- Create Date: 06/02/2022 09:53:22 AM
-- Design Name: 
-- Module Name: HA - Behavioral
-- Project Name: Adder
-- Target Devices: 
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

entity HA is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           S : out STD_LOGIC;
           C_OUT : out STD_LOGIC);
end HA;

architecture Behavioral of HA is

begin
 S <= A XOR B;
 C_OUT <= A AND B;

end Behavioral;
