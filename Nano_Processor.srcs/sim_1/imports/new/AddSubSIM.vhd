----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/07/2022 04:26:23 PM
-- Design Name: 
-- Module Name: AddSubSIM - Behavioral
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

entity AddSubSIM is
--  Port ( );
end AddSubSIM;

architecture Behavioral of AddSubSIM is
component AdderSubtractor
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           C_IN : in STD_LOGIC;
           S : inout STD_LOGIC_VECTOR (3 downto 0);
           Zero: out STD_LOGIC;
           C_OUT : out STD_LOGIC);
end component;

signal A,B,S : STD_LOGIC_VECTOR (3 downto 0);
signal SET, OVERFLOW, ZERO : STD_LOGIC;

begin
UUT: AdderSubtractor
    PORT MAP(
    A=>A,
    B=>B,
    C_IN=>SET,
    S=>S,
    Zero=>ZERO,
    C_OUT=>OVERFLOW);
    
    PROCESS
    BEGIN
--    index number= 200279
--    Binary form= 0011 0000 1110 0101 0111

    
    SET<='0';
    A<="1110";
    B<="0101";
    WAIT FOR 100NS;
       
    SET<='0';
    A<="0000";
    B<="0000";
    WAIT FOR 100NS;
       
    SET<='0';
    A<="1101";
    B<="1001";
    WAIT FOR 100NS;
      
    SET<='0';
    A<="1011";
    B<="0010";
    WAIT FOR 100NS;
    
    SET<='1';
    A<="0000";
    B<="0001";
    WAIT FOR 100NS;
    
    SET<='0';
    A<="0000";
    B<="0101";
    WAIT FOR 100NS;

    SET<='0';
    A<="1110";
    B<="0111";
    WAIT FOR 100NS;
    
    SET<='1';
    A<="0000";
    B<="0101";
    WAIT FOR 100NS;
    
    SET<='0';
    A<="1110";
    B<="0101";
    WAIT FOR 100NS;
    
    SET<='1';
    A<="0000";
    B<="1101";
    WAIT FOR 100NS;
    WAIT;
    END PROCESS;
end Behavioral;
