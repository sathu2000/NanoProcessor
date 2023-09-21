----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/09/2022 07:27:44 AM
-- Design Name: 
-- Module Name: ProgamRom_Sim - Behavioral
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

entity ProgamRom_Sim is
--  Port ( );
end ProgamRom_Sim;

architecture Behavioral of ProgamRom_Sim is
component ProgramRom 
     Port ( MemoryAddress : in STD_LOGIC_VECTOR (2 downto 0);
          Instruction : out STD_LOGIC_VECTOR (11 downto 0));
end component;
signal M :STD_LOGIC_VECTOR (2 downto 0);
signal I :STD_LOGIC_VECTOR (11 downto 0);
begin
UUT : ProgramRom
    port map(
        MemoryAddress => M,
        Instruction => I
    );
    process
    begin
    M <= "000";
    wait for 100ns;
    M <= "001";
    wait for 100ns;
    M <= "010";
    wait for 100ns;
    M <= "011";
    wait for 100ns;
    M <= "100";
    wait for 100ns;
    M <= "101";
    wait for 100ns;
    M <= "110";
    wait for 100ns;
    M <= "111";
    wait;
    end process;

end Behavioral;
