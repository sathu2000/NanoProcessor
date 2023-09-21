----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/08/2022 10:51:30 PM
-- Design Name: 
-- Module Name: ProgramROM - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ProgramROM is
    Port ( MemoryAddress : in STD_LOGIC_VECTOR (2 downto 0);
           Instruction : out STD_LOGIC_VECTOR (11 downto 0));
end ProgramROM;

architecture Behavioral of ProgramROM is
type rom_type is array (0 to 7) of STD_LOGIC_VECTOR( 11 downto 0);
    signal instructionROM : rom_type := (
                    "101110000000",--ROM0
                    "101100000011",--ROM1
                    "101010001111",--ROM2
                    "001111100000",--ROM3
                    "001101010000",--ROM4
                    "111100000111",--ROM5
                    "110000000011",--ROM6
                    "110000000111" --ROM7                        
);
 
begin
Instruction <= instructionROM(to_integer(unsigned(MemoryAddress))); 

end Behavioral;
