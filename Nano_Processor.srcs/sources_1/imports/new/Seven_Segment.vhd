----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/10/2022 10:05:33 PM
-- Design Name: 
-- Module Name: Seven_Segment - Behavioral
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
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Seven_Segment is
 Port ( number : in STD_LOGIC_VECTOR (3 downto 0);
 output : out STD_LOGIC_VECTOR (6 downto 0));
end Seven_Segment;
architecture Behavioral of Seven_Segment is
type rom_type is array (0 to 15) of std_logic_vector(6 downto 0);
signal sevenSegment_ROM : rom_type := (
 "1000000", -- 0
 "1111001", --1
 "0100100", --2
 "0110000", --3
 "0011001", --4
 "0010010", --5
 "0000010", --6
 "1111000", --7
 "0000000", --8
 "1111000", --9 -- -7
 "0000010", -- a -- -6
 "0010010", -- b -- -5
 "0011001", -- c -- -4
 "0110000", -- d -- -3
 "0100100", -- e -- -2
 "1111001" -- f -- -1
 );
 
begin
 output <= sevenSegment_ROM(to_integer(unsigned(number)));
end Behavioral;