----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/08/2022 07:42:34 PM
-- Design Name: 
-- Module Name: InstructionDecoder - Behavioral
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

entity InstructionDecoder is
    Port ( ROM_Instruction : in STD_LOGIC_VECTOR (11 downto 0); -- instruction from program ROM
           Check_Jump : in STD_LOGIC_VECTOR (3 downto 0);  -- register check for jump
           Select_A : out STD_LOGIC_VECTOR (2 downto 0);   --send the register to select to 1st MUX
           Select_B : out STD_LOGIC_VECTOR (2 downto 0);  --send the register to select to 1st MUX
           Enable_Reg : out STD_LOGIC_VECTOR (2 downto 0);  --enable correct register
           AddSub : out STD_LOGIC; --if want to add enable 0, else if you want 2's complement enable 1
           Jump_Flag : out STD_LOGIC; --to indicate whether jump instruction is enabled or not
           Jump_Address : out STD_LOGIC_VECTOR (2 downto 0);  --address to which we need to jump
           LoadSelect : out STD_LOGIC;  --enable the mux connected to register bank
           ImValue : out STD_LOGIC_VECTOR (3 downto 0));  --immediate value
end InstructionDecoder;

architecture Behavioral of InstructionDecoder is

signal instruction:STD_LOGIC_VECTOR (1 downto 0);  
--00 - ADD
--01 - NEG
--10 - MOVI
--11 - JNZ
signal reg1:STD_LOGIC_VECTOR (2 downto 0); 
signal reg2:STD_LOGIC_VECTOR (2 downto 0); 
signal data:STD_LOGIC_VECTOR (3 downto 0);

begin
instruction<=ROM_Instruction(11 downto 10);  --first two bit
reg1<=ROM_Instruction(9 downto 7);  --next 3 bits indicating register
reg2<=ROM_Instruction(6 downto 4);  --next 3 bits indicating register
data<=ROM_Instruction(3 downto 0);  --last 4 bits

process (instruction, reg1, reg2,data)
    begin
    if instruction="00" then --ADD
       -- as it is add operation both mux connected to RCA should be selected
       Select_A<=reg1;  
       Select_B <=reg2;
       Enable_Reg<=reg1;  --enabled to store output
       AddSub<='0'; -- as ADD instruction, value is set to 0
       Jump_Flag<='0';
       Jump_Address<="000";
       LoadSelect<='0';
       ImValue<="0000"; -- no immediate value
    elsif instruction="01" then --NEG
        -- involve RCA
        -- in order to find 2's compliment first mux is loaded with all zero and AddSub is set to 1
       Select_A<="000";
       Select_B <=reg1;
       Enable_Reg<=reg1;  -- enabled to store output
       AddSub<='1';
       Jump_Flag<='0';
       Jump_Address<="000";
       LoadSelect<='0';
       ImValue<="0000"; -- no immediate value
    elsif instruction="10" then --MOVI
       -- does not involve RCA
       Select_A<="000";
       Select_B <="000";
       Enable_Reg<=reg1;  --enable to store immediate value
       AddSub<='0';
       Jump_Flag<='0';
       Jump_Address<="000";
       LoadSelect<='1'; --immediate value present
       ImValue<=data;  --immediate value present
    elsif instruction="11" then  --JZR
       Select_A<=reg1;
       Select_B <="000";
       Enable_Reg<=reg1;
       AddSub<='0';
       LoadSelect<='0';
       ImValue<="0000"; -- no immediate value
       if Check_Jump="0000" then
           Jump_Flag<='1';
           Jump_Address<=ROM_Instruction(2 downto 0);
       else
           Jump_Flag<='0';
           Jump_Address<="000";
       end if;
    end if;
end process;

end Behavioral;
