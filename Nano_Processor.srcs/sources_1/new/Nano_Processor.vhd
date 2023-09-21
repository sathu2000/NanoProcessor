----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/11/2022 04:11:13 AM
-- Design Name: 
-- Module Name: Nano_Processor - Behavioral
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

entity Nano_Processor is
 Port (  Res : in STD_LOGIC;
         Clk_in : in std_logic;
         OvrFlw : out STD_LOGIC;
         Zero : out STD_LOGIC;
         R7LED : out STD_LOGIC_VECTOR (3 downto 0);
         sev_out : out STD_LOGIC_VECTOR (6 downto 0);
         anode : out STD_LOGIC_VECTOR (3 downto 0)
         );
end Nano_Processor;

architecture Behavioral of Nano_Processor is
-- program counter
component PC 
port(Mux_out : in STD_LOGIC_VECTOR (2 downto 0);
     Mem_S : out STD_LOGIC_VECTOR (2 downto 0);
     Res : in STD_LOGIC;
     Clk : in STD_LOGIC);
end component;
--Program Rom
component ProgramROM 
port(
     MemoryAddress : in STD_LOGIC_VECTOR (2 downto 0);
     Instruction: out STD_LOGIC_VECTOR (11 downto 0));
end component;
-- Instruction Decoder
component Instruction_Decoder
 port(
     ROM_Instruction : in STD_LOGIC_VECTOR (11 downto 0);
     Select_A : out STD_LOGIC_VECTOR (2 downto 0);
     Select_B : out STD_LOGIC_VECTOR (2 downto 0);
     Enable_Reg : out STD_LOGIC_VECTOR (2 downto 0);
     ImValue : out STD_LOGIC_VECTOR (3 downto 0);
     LoadSelect : out STD_LOGIC;
     AddSub : out STD_LOGIC;
     Jump_Flag : out STD_LOGIC;
     Jump_Address : out std_logic_vector (2 downto 0); 
     Check_Jump : in STD_LOGIC_VECTOR (3 downto 0));
end component;
--3bit Adder
component Adder_3
    port(
         A : in STD_LOGIC_VECTOR (2 downto 0);
         S : out STD_LOGIC_VECTOR (2 downto 0);
         B : in std_logic);
end component;
--2way 3 bit MUX
component Mux_2way_3bit 
port(
     S : in STD_LOGIC;
     IN0 : in STD_LOGIC_VECTOR (2 downto 0);
     IN1 : in STD_LOGIC_VECTOR (2 downto 0);
     OP : out STD_LOGIC_VECTOR (2 downto 0));
end component;
--2way 4 bit MUX
component Mux_2way_4bit 
port(
     S : in STD_LOGIC;
     IN0 : in STD_LOGIC_VECTOR (3 downto 0);
     IN1 : in STD_LOGIC_VECTOR (3 downto 0);
     OP : out STD_LOGIC_VECTOR (3 downto 0));
end component;
--8way 4bit mux
component Mux_8way_4bit port(
 S : in STD_LOGIC_VECTOR (2 downto 0);
 IN0 : in STD_LOGIC_VECTOR (3 downto 0);
 IN1 : in STD_LOGIC_VECTOR (3 downto 0);
 IN2 : in STD_LOGIC_VECTOR (3 downto 0);
 IN3 : in STD_LOGIC_VECTOR (3 downto 0);
 IN4 : in STD_LOGIC_VECTOR (3 downto 0);
 IN5 : in STD_LOGIC_VECTOR (3 downto 0);
 IN6 : in STD_LOGIC_VECTOR (3 downto 0);
 IN7 : in STD_LOGIC_VECTOR (3 downto 0);
 OP : out STD_LOGIC_VECTOR (3 downto 0));
end component;
--Register Bank
component Reg_bank 
port(
     clk  : in STD_LOGIC;
     sel  : in STD_LOGIC_VECTOR (2 downto 0);
     data : in STD_LOGIC_VECTOR (3 downto 0);
     res  : in STD_LOGIC;--?
     out0 : out STD_LOGIC_VECTOR (3 downto 0);
     out1 : out STD_LOGIC_VECTOR (3 downto 0);
     out2 : out STD_LOGIC_VECTOR (3 downto 0);
     out3 : out STD_LOGIC_VECTOR (3 downto 0);
     out4 : out STD_LOGIC_VECTOR (3 downto 0);
     out5 : out STD_LOGIC_VECTOR (3 downto 0);
     out6 : out STD_LOGIC_VECTOR (3 downto 0);
     out7 : out STD_LOGIC_VECTOR (3 downto 0));
end component;
--Adder Substractor(4bit)
component AdderSubtractor 
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           C_IN : in STD_LOGIC;
           S : inout STD_LOGIC_VECTOR (3 downto 0);
           Zero: out STD_LOGIC;
           C_OUT : out STD_LOGIC);
end component;
--Slow_Clock
component Slow_Clock port(
 clk_in : in STD_LOGIC;
 clk_out : out STD_LOGIC);
end component;

--7Segement For R7 Register
component Seven_Segment port(
 number : in STD_LOGIC_VECTOR (3 downto 0);
 output : out STD_LOGIC_VECTOR (6 downto 0));
end component;
--signals
signal slw_clk,OvrFlw0 : std_logic; -- slow clock Output,Overflow output
signal PROGRAM_COUNTER_Out : STD_LOGIC_VECTOR (2 downto 0); --PROGRAM_COUNTER output
signal RCA3_bit_Out : std_logic_vector (2 downto 0); -- send to 2 way 3 bit mux
signal twoway_mux_out : std_logic_vector (2 downto 0); -- send to PROGRAM_COUNTER
signal ROM_OUT : std_logic_vector (11 downto 0); -- send to PROGRAM_to insDecoder
--ROM signals
signal regSelmuxA,decoderVal,regSelmuxB,addressJMP : STD_LOGIC_VECTOR (2 downto 0);
signal imValue : STD_LOGIC_VECTOR (3 downto 0);
signal loadSel,addOrSub,jmpFlag : STD_LOGIC;
-- END
--Registers signal and MUX OUT
signal REGI_0,REGI_1,REGI_2,REGI_3,REGI_4,REGI_5,REGI_6,REGI_7,MUX_A,MUX_B,MUX_2_to_1_out,RCA_out : STD_LOGIC_VECTOR (3 downto 0); 
begin
--Maping Start
--Slow_Clock
Slow_Clock_0 : Slow_Clock
 port map(clk_in => Clk_in,
          clk_out => slw_clk);
          
 --PC           
PC_0 : PC
 port map (Mux_out=>twoway_mux_out,
           Mem_S=> PROGRAM_COUNTER_Out,
           Res => Res,
           Clk => slw_clk);
           
Adder_3_0 : Adder_3
 port map(
     A => PROGRAM_COUNTER_Out,
     S => RCA3_bit_Out,
     B => '1'); 
Mux_2way_3bit_0 : Mux_2way_3bit
 port map(
     S => jmpFlag,
     IN0 => RCA3_bit_Out,
     IN1 => addressJMP,
     OP => twoway_mux_out);
ROMS : ProgramROM
 port map(
 MemoryAddress => PROGRAM_COUNTER_Out,
 Instruction => ROM_OUT
 ); 
--Instruction Decoder
InstructionDecoder0: Instruction_Decoder
  port map(
     ROM_Instruction => ROM_OUT,
     Select_A => regSelmuxA,
     Select_B => regSelmuxB,
     Enable_Reg => decoderVal,
     ImValue => imValue,
     LoadSelect => loadSel,
     AddSub => addOrSub,
     Jump_Flag => jmpFlag,
     Jump_Address => addressJMP,
     Check_Jump => MUX_A);

--Register Bank
Reg_bank0: Reg_bank
 port map( clk => slw_clk,
           sel => decoderVal,
           data => MUX_2_to_1_out,
           res => Res,
           out0 => REGI_0,
           out1 => REGI_1,
           out2 => REGI_2,
           out3 => REGI_3,
           out4 => REGI_4,
           out5 => REGI_5,
           out6 => REGI_6,
           out7 => REGI_7); 
Mux_8way_4bit_A : Mux_8way_4bit
 port map(
 S => regSelmuxA,
 IN0 => REGI_0,
 IN1 => REGI_1,
 IN2 => REGI_2,
 IN3 => REGI_3,
 IN4 => REGI_4,
 IN5 => REGI_5,
 IN6 => REGI_6,
 IN7 => REGI_7,
 OP => MUX_A
 ); 
Mux_8way_4bit_B : Mux_8way_4bit
 port map(
 S => regSelmuxB,
 IN0 => REGI_0,
 IN1 => REGI_1,
 IN2 => REGI_2,
 IN3 => REGI_3,
 IN4 => REGI_4,
 IN5 => REGI_5,
 IN6 => REGI_6,
 IN7 => REGI_7,
 OP => MUX_B
 );
--Mux(2way,4bit)
Mux_2way_4bit_0 : Mux_2way_4bit
    port map(
         S => loadSel,
         IN0 => RCA_out,
         IN1 => imValue,
         OP => MUX_2_to_1_out); 
RCA_0 : AdderSubtractor
 port map(
 A => MUX_A,
 B => MUX_B,
 C_IN => addOrSub,
 C_OUT => OvrFlw0,
 S => RCA_out,
 Zero => Zero
 ); 
svenSeg_0 : Seven_Segment
 port map(
 number => REGI_7,
 output => sev_out );
 
R7LED <= REGI_7;
OvrFlw <= OvrFlw0;
anode <= "1110";
end Behavioral;




