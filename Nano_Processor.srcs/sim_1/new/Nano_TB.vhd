----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/11/2022 06:06:58 AM
-- Design Name: 
-- Module Name: Nano_TB - Behavioral
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

entity Nano_TB is
--  Port ( );
end Nano_TB;

architecture Behavioral of Nano_TB is
component Nano_Processor
 Port (  Res : in STD_LOGIC;
        Clk_in : in std_logic;
        OvrFlw : out STD_LOGIC;
        Zero : out STD_LOGIC;
        R7LED : out STD_LOGIC_VECTOR (3 downto 0);
        sev_out : out STD_LOGIC_VECTOR (6 downto 0));
end component;
signal Res,OvrFlw,Zero:std_logic;
signal R7LED:STD_LOGIC_VECTOR (3 downto 0);
signal sev_out:STD_LOGIC_VECTOR (6 downto 0);
signal Clk_in:std_logic:='0';
begin
UUT: Nano_Processor
    port map(
        Res=>Res,
        Clk_in=>Clk_in,
        Ovrflw=>Ovrflw,
        Zero=>Zero,
        R7LED=>R7LED,
        sev_out=>sev_out
       );
process
    begin
    wait for 5ns;
    Clk_in<=not(Clk_in);
end process;
process
    begin
    Res<='1';
    wait for 50ns;
    Res<='0';
    wait for 400ns;
    Res<='1';
    wait for 50ns;
    Res <='0';
    wait;
    
end process;
end Behavioral;
