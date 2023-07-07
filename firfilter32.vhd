----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:14:26 02/21/2023 
-- Design Name: 
-- Module Name:    firfilter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity firfilter is
	port (clk                             :   IN    std_logic;
         filter_in1                      :   IN    std_logic_vector(1 DOWNTO 0); -- sfix16_En15 
			filter_in2                      :   IN    std_logic_vector(1 DOWNTO 0); -- sfix16_En15
			filter_in3                      :   IN    std_logic_vector(1 DOWNTO 0);
			filter_in4                      :   IN    std_logic_vector(1 DOWNTO 0);
			filter_in5                      :   IN    std_logic_vector(1 DOWNTO 0); -- sfix16_En15 
			filter_in6                      :   IN    std_logic_vector(1 DOWNTO 0); -- sfix16_En15
			filter_in7                      :   IN    std_logic_vector(1 DOWNTO 0);
			filter_in8                      :   IN    std_logic_vector(1 DOWNTO 0);
			filter_in9                      :   IN    std_logic_vector(1 DOWNTO 0); -- sfix16_En15 
			filter_in10                      :   IN    std_logic_vector(1 DOWNTO 0); -- sfix16_En15
			filter_in11                      :   IN    std_logic_vector(1 DOWNTO 0);
			filter_in12                      :   IN    std_logic_vector(1 DOWNTO 0);
			filter_in13                     :   IN    std_logic_vector(1 DOWNTO 0); -- sfix16_En15 
			filter_in14                      :   IN    std_logic_vector(1 DOWNTO 0); -- sfix16_En15
			filter_in15                      :   IN    std_logic_vector(1 DOWNTO 0);
			filter_in16                      :   IN    std_logic_vector(1 DOWNTO 0);
			filter_in17                      :   IN    std_logic_vector(1 DOWNTO 0); -- sfix16_En15 
			filter_in18                      :   IN    std_logic_vector(1 DOWNTO 0); -- sfix16_En15
			filter_in19                      :   IN    std_logic_vector(1 DOWNTO 0);
			filter_in20                      :   IN    std_logic_vector(1 DOWNTO 0);
			filter_in21                      :   IN    std_logic_vector(1 DOWNTO 0); -- sfix16_En15 
			filter_in22                     :   IN    std_logic_vector(1 DOWNTO 0); -- sfix16_En15
			filter_in23                      :   IN    std_logic_vector(1 DOWNTO 0);
			filter_in24                      :   IN    std_logic_vector(1 DOWNTO 0);
			filter_in25                      :   IN    std_logic_vector(1 DOWNTO 0); -- sfix16_En15 
			filter_in26                      :   IN    std_logic_vector(1 DOWNTO 0); -- sfix16_En15
			filter_in27                      :   IN    std_logic_vector(1 DOWNTO 0);
			filter_in28                      :   IN    std_logic_vector(1 DOWNTO 0);
			filter_in29                     :   IN    std_logic_vector(1 DOWNTO 0); -- sfix16_En15 
			filter_in30                      :   IN    std_logic_vector(1 DOWNTO 0); -- sfix16_En15
			filter_in31                      :   IN    std_logic_vector(1 DOWNTO 0);
			filter_in32                      :   IN    std_logic_vector(1 DOWNTO 0);
			filter_out                     :   OUT   std_logic_vector(63 DOWNTO 0)
			);
end firfilter;

architecture Behavioral of firfilter is

component booth_multiplier2 is
		GENERIC (x : INTEGER:=2;
		 y : INTEGER:=2);
	
		PORT(m : IN STD_LOGIC_VECTOR(x - 1 DOWNTO 0);
	     r : IN STD_LOGIC_VECTOR(y - 1 DOWNTO 0);
		  clk: IN STD_LOGIC;
	     result : OUT STD_LOGIC_VECTOR(x + y - 1 DOWNTO 0));
end component;

component booth_multiplier4 is
		GENERIC (x : INTEGER:=4;
		 y : INTEGER:=4);
	
		PORT(m : IN STD_LOGIC_VECTOR(x - 1 DOWNTO 0);
	     r : IN STD_LOGIC_VECTOR(y - 1 DOWNTO 0);
		  clk: IN STD_LOGIC;
	     result : OUT STD_LOGIC_VECTOR(x + y - 1 DOWNTO 0));
end component;

component booth_multiplier8 is
		GENERIC (x : INTEGER:=8;
		 y : INTEGER:=8);
	
		PORT(m : IN STD_LOGIC_VECTOR(x - 1 DOWNTO 0);
	     r : IN STD_LOGIC_VECTOR(y - 1 DOWNTO 0);
		  clk: IN STD_LOGIC;
	     result : OUT STD_LOGIC_VECTOR(x + y - 1 DOWNTO 0));
end component;

component booth_multiplier16 is
		GENERIC (x : INTEGER:=16;
		 y : INTEGER:=16);
	
		PORT(m : IN STD_LOGIC_VECTOR(x - 1 DOWNTO 0);
	     r : IN STD_LOGIC_VECTOR(y - 1 DOWNTO 0);
		  clk: IN STD_LOGIC;
	     result : OUT STD_LOGIC_VECTOR(x + y - 1 DOWNTO 0));
end component;

component booth_multiplier32 is
		GENERIC (x : INTEGER:=32;
		 y : INTEGER:=32);
	
		PORT(m : IN STD_LOGIC_VECTOR(x - 1 DOWNTO 0);
	     r : IN STD_LOGIC_VECTOR(y - 1 DOWNTO 0);
		  clk: IN STD_LOGIC;
	     result : OUT STD_LOGIC_VECTOR(x + y - 1 DOWNTO 0));
end component;

SIGNAL filter_in_regtype1                : std_logic_vector(1 downto 0); -- sfix16_En15
SIGNAL filter_in_regtype2                : std_logic_vector(1 downto 0); -- sfix16_En15
SIGNAL filter_in_regtype3                : std_logic_vector(1 downto 0);
SIGNAL filter_in_regtype4                : std_logic_vector(1 downto 0);
SIGNAL filter_in_regtype5                : std_logic_vector(1 downto 0); -- sfix16_En15
SIGNAL filter_in_regtype6                : std_logic_vector(1 downto 0); -- sfix16_En15
SIGNAL filter_in_regtype7                : std_logic_vector(1 downto 0);
SIGNAL filter_in_regtype8                : std_logic_vector(1 downto 0);
SIGNAL filter_in_regtype9                : std_logic_vector(1 downto 0); -- sfix16_En15
SIGNAL filter_in_regtype10                : std_logic_vector(1 downto 0); -- sfix16_En15
SIGNAL filter_in_regtype11                : std_logic_vector(1 downto 0);
SIGNAL filter_in_regtype12                : std_logic_vector(1 downto 0);
SIGNAL filter_in_regtype13                : std_logic_vector(1 downto 0); -- sfix16_En15
SIGNAL filter_in_regtype14                : std_logic_vector(1 downto 0); -- sfix16_En15
SIGNAL filter_in_regtype15                : std_logic_vector(1 downto 0);
SIGNAL filter_in_regtype16                : std_logic_vector(1 downto 0);
SIGNAL filter_in_regtype17                : std_logic_vector(1 downto 0); -- sfix16_En15
SIGNAL filter_in_regtype18               : std_logic_vector(1 downto 0); -- sfix16_En15
SIGNAL filter_in_regtype19                : std_logic_vector(1 downto 0);
SIGNAL filter_in_regtype20                : std_logic_vector(1 downto 0);
SIGNAL filter_in_regtype21                : std_logic_vector(1 downto 0); -- sfix16_En15
SIGNAL filter_in_regtype22                : std_logic_vector(1 downto 0); -- sfix16_En15
SIGNAL filter_in_regtype23                : std_logic_vector(1 downto 0);
SIGNAL filter_in_regtype24                : std_logic_vector(1 downto 0);
SIGNAL filter_in_regtype25                : std_logic_vector(1 downto 0); -- sfix16_En15
SIGNAL filter_in_regtype26                : std_logic_vector(1 downto 0); -- sfix16_En15
SIGNAL filter_in_regtype27                : std_logic_vector(1 downto 0);
SIGNAL filter_in_regtype28                : std_logic_vector(1 downto 0);
SIGNAL filter_in_regtype29                : std_logic_vector(1 downto 0); -- sfix16_En15
SIGNAL filter_in_regtype30                : std_logic_vector(1 downto 0); -- sfix16_En15
SIGNAL filter_in_regtype31                : std_logic_vector(1 downto 0);
SIGNAL filter_in_regtype32                : std_logic_vector(1 downto 0);


SIGNAL mul_temp_11                : std_logic_vector(3 downto 0); -- sfix16_En15
SIGNAL mul_temp_12                : std_logic_vector(3 downto 0); -- sfix16_En15
SIGNAL mul_temp_13                : std_logic_vector(3 downto 0);
SIGNAL mul_temp_14                : std_logic_vector(3 downto 0);
SIGNAL mul_temp_15                : std_logic_vector(3 downto 0); -- sfix16_En15
SIGNAL mul_temp_16                : std_logic_vector(3 downto 0); -- sfix16_En15
SIGNAL mul_temp_17                : std_logic_vector(3 downto 0);
SIGNAL mul_temp_18                : std_logic_vector(3 downto 0);
SIGNAL mul_temp_19                : std_logic_vector(3 downto 0); -- sfix16_En15
SIGNAL mul_temp_110                : std_logic_vector(3 downto 0); -- sfix16_En15
SIGNAL mul_temp_111               : std_logic_vector(3 downto 0);
SIGNAL mul_temp_112                : std_logic_vector(3 downto 0);
SIGNAL mul_temp_113                : std_logic_vector(3 downto 0); -- sfix16_En15
SIGNAL mul_temp_114                : std_logic_vector(3 downto 0); -- sfix16_En15
SIGNAL mul_temp_115                : std_logic_vector(3 downto 0);
SIGNAL mul_temp_116                : std_logic_vector(3 downto 0);

SIGNAL mul_temp_21                       : std_logic_vector(7 DOWNTO 0); -- sfix32_En31
SIGNAL mul_temp_22                       : std_logic_vector(7 DOWNTO 0); -- sfix32_En31
SIGNAL mul_temp_23                       : std_logic_vector(7 DOWNTO 0); -- sfix32_En31
SIGNAL mul_temp_24                       : std_logic_vector(7 DOWNTO 0); -- sfix32_En31
SIGNAL mul_temp_25                       : std_logic_vector(7 DOWNTO 0); -- sfix32_En31
SIGNAL mul_temp_26                       : std_logic_vector(7 DOWNTO 0); -- sfix32_En31
SIGNAL mul_temp_27                       : std_logic_vector(7 DOWNTO 0); -- sfix32_En31
SIGNAL mul_temp_28                       : std_logic_vector(7 DOWNTO 0); -- sfix32_En31

SIGNAL mul_temp_31                       : std_logic_vector(15 DOWNTO 0); -- sfix32_En31
SIGNAL mul_temp_32                       : std_logic_vector(15 DOWNTO 0); -- sfix32_En31
SIGNAL mul_temp_33                       : std_logic_vector(15 DOWNTO 0); -- sfix32_En31
SIGNAL mul_temp_34                       : std_logic_vector(15 DOWNTO 0); -- sfix32_En31

SIGNAL mul_temp_41                       : std_logic_vector(31 DOWNTO 0); -- sfix32_En31
SIGNAL mul_temp_42                       : std_logic_vector(31 DOWNTO 0); -- sfix32_En31

SIGNAL mul_temp_51                       : std_logic_vector(63 DOWNTO 0); -- sfix32_En31

begin

		filter_in_regtype1 <= std_logic_vector(filter_in1);
		filter_in_regtype2 <= std_logic_vector(filter_in2);
		filter_in_regtype3 <= std_logic_vector(filter_in3);
		filter_in_regtype4 <= std_logic_vector(filter_in4);		
		filter_in_regtype5 <= std_logic_vector(filter_in5);
		filter_in_regtype6 <= std_logic_vector(filter_in6);
		filter_in_regtype7 <= std_logic_vector(filter_in7);
		filter_in_regtype8 <= std_logic_vector(filter_in8);
		filter_in_regtype9 <= std_logic_vector(filter_in9);
		filter_in_regtype10 <= std_logic_vector(filter_in10);
		filter_in_regtype11 <= std_logic_vector(filter_in11);
		filter_in_regtype12 <= std_logic_vector(filter_in12);		
		filter_in_regtype13 <= std_logic_vector(filter_in13);
		filter_in_regtype14 <= std_logic_vector(filter_in14);
		filter_in_regtype15 <= std_logic_vector(filter_in15);
		filter_in_regtype16 <= std_logic_vector(filter_in16);
		filter_in_regtype17 <= std_logic_vector(filter_in17);
		filter_in_regtype18 <= std_logic_vector(filter_in18);
		filter_in_regtype19 <= std_logic_vector(filter_in19);
		filter_in_regtype20 <= std_logic_vector(filter_in20);		
		filter_in_regtype21 <= std_logic_vector(filter_in21);
		filter_in_regtype22 <= std_logic_vector(filter_in22);
		filter_in_regtype23 <= std_logic_vector(filter_in23);
		filter_in_regtype24 <= std_logic_vector(filter_in24);
		filter_in_regtype25 <= std_logic_vector(filter_in25);
		filter_in_regtype26 <= std_logic_vector(filter_in26);
		filter_in_regtype27 <= std_logic_vector(filter_in27);
		filter_in_regtype28 <= std_logic_vector(filter_in28);		
		filter_in_regtype29 <= std_logic_vector(filter_in29);
		filter_in_regtype30 <= std_logic_vector(filter_in30);
		filter_in_regtype31 <= std_logic_vector(filter_in31);
		filter_in_regtype32 <= std_logic_vector(filter_in32);

		x1: booth_multiplier2 generic map(x=>2,y=>2) port map (filter_in_regtype1,filter_in_regtype2,clk,mul_temp_11);
		x2: booth_multiplier2 generic map(x=>2,y=>2) port map (filter_in_regtype3,filter_in_regtype4,clk,mul_temp_12);
		x3: booth_multiplier2 generic map(x=>2,y=>2) port map (filter_in_regtype5,filter_in_regtype6,clk,mul_temp_13);
		x4: booth_multiplier2 generic map(x=>2,y=>2) port map (filter_in_regtype7,filter_in_regtype8,clk,mul_temp_14);
		x5: booth_multiplier2 generic map(x=>2,y=>2) port map (filter_in_regtype9,filter_in_regtype10,clk,mul_temp_15);
		x6: booth_multiplier2 generic map(x=>2,y=>2) port map (filter_in_regtype11,filter_in_regtype12,clk,mul_temp_16);
		x7: booth_multiplier2 generic map(x=>2,y=>2) port map (filter_in_regtype13,filter_in_regtype14,clk,mul_temp_17);
		x8: booth_multiplier2 generic map(x=>2,y=>2) port map (filter_in_regtype15,filter_in_regtype16,clk,mul_temp_18);
		x9: booth_multiplier2 generic map(x=>2,y=>2) port map (filter_in_regtype17,filter_in_regtype18,clk,mul_temp_19);
		x10: booth_multiplier2 generic map(x=>2,y=>2) port map (filter_in_regtype19,filter_in_regtype20,clk,mul_temp_110);
		x11: booth_multiplier2 generic map(x=>2,y=>2) port map (filter_in_regtype21,filter_in_regtype22,clk,mul_temp_111);
		x12: booth_multiplier2 generic map(x=>2,y=>2) port map (filter_in_regtype23,filter_in_regtype24,clk,mul_temp_112);
		x13: booth_multiplier2 generic map(x=>2,y=>2) port map (filter_in_regtype25,filter_in_regtype26,clk,mul_temp_113);
		x14: booth_multiplier2 generic map(x=>2,y=>2) port map (filter_in_regtype27,filter_in_regtype28,clk,mul_temp_114);
		x15: booth_multiplier2 generic map(x=>2,y=>2) port map (filter_in_regtype29,filter_in_regtype30,clk,mul_temp_115);
		x16: booth_multiplier2 generic map(x=>2,y=>2) port map (filter_in_regtype31,filter_in_regtype32,clk,mul_temp_116);
		
		
		x17: booth_multiplier4 generic map(x=>4,y=>4) port map (mul_temp_11,mul_temp_12,clk,mul_temp_21);
		x18: booth_multiplier4 generic map(x=>4,y=>4) port map (mul_temp_13,mul_temp_14,clk,mul_temp_22);
		x19: booth_multiplier4 generic map(x=>4,y=>4) port map (mul_temp_15,mul_temp_16,clk,mul_temp_23);
		x20: booth_multiplier4 generic map(x=>4,y=>4) port map (mul_temp_17,mul_temp_18,clk,mul_temp_24);
		x21: booth_multiplier4 generic map(x=>4,y=>4) port map (mul_temp_19,mul_temp_110,clk,mul_temp_25);
		x22: booth_multiplier4 generic map(x=>4,y=>4) port map (mul_temp_111,mul_temp_112,clk,mul_temp_26);
		x23: booth_multiplier4 generic map(x=>4,y=>4) port map (mul_temp_113,mul_temp_114,clk,mul_temp_27);
		x24: booth_multiplier4 generic map(x=>4,y=>4) port map (mul_temp_115,mul_temp_116,clk,mul_temp_28);
		
		
		x25: booth_multiplier8 generic map(x=>8,y=>8) port map (mul_temp_21,mul_temp_22,clk,mul_temp_31);
		x26: booth_multiplier8 generic map(x=>8,y=>8) port map (mul_temp_23,mul_temp_24,clk,mul_temp_32);
		x27: booth_multiplier8 generic map(x=>8,y=>8) port map (mul_temp_25,mul_temp_26,clk,mul_temp_33);
		x28: booth_multiplier8 generic map(x=>8,y=>8) port map (mul_temp_27,mul_temp_28,clk,mul_temp_34);
	
		x29: booth_multiplier16 generic map(x=>16,y=>16) port map (mul_temp_31,mul_temp_32,clk,mul_temp_41);
		x30: booth_multiplier16 generic map(x=>16,y=>16) port map (mul_temp_33,mul_temp_34,clk,mul_temp_42);
		
		y: booth_multiplier32 generic map(x=>32,y=>32) port map (mul_temp_41,mul_temp_42,clk,mul_temp_51);	

		filter_out <= std_logic_vector(mul_temp_51);
end Behavioral;

