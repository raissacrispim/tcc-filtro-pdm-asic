###############################################################################
# Change list, formatted for IC Compiler
#
# 
#
###############################################################################
current_instance
insert_buffer [get_ports {y_out[13]}] DELLN2X2_RVT -new_net_names {net_PTECO_HOLD_NET1} -new_cell_names {U_PTECO_HOLD_BUF1}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {y_out_reg_12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET2} -new_cell_names {U_PTECO_HOLD_BUF2}
current_instance
insert_buffer [get_ports {y_out[12]}] DELLN2X2_RVT -new_net_names {net_PTECO_HOLD_NET3} -new_cell_names {U_PTECO_HOLD_BUF3}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {y_out_reg_9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET4} -new_cell_names {U_PTECO_HOLD_BUF4}
current_instance
insert_buffer [get_ports {y_out[7]}] DELLN2X2_RVT -new_net_names {net_PTECO_HOLD_NET5} -new_cell_names {U_PTECO_HOLD_BUF5}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {y_out_reg_8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET6} -new_cell_names {U_PTECO_HOLD_BUF6}
insert_buffer [get_pins {copt_gre_h_inst_2275/A}] DELLN2X2_RVT -new_net_names {net_PTECO_HOLD_NET7} -new_cell_names {U_PTECO_HOLD_BUF7}
insert_buffer [get_pins {y_out_reg_13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET8} -new_cell_names {U_PTECO_HOLD_BUF8}
current_instance
insert_buffer [get_pins {copt_h_inst_2274/A}] DELLN2X2_RVT -new_net_names {net_PTECO_HOLD_NET9} -new_cell_names {U_PTECO_HOLD_BUF9}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {y_out_reg_6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET10} -new_cell_names {U_PTECO_HOLD_BUF10}
insert_buffer [get_pins {HFSBUF_34_69/A}] DELLN2X2_RVT -new_net_names {net_PTECO_HOLD_NET11} -new_cell_names {U_PTECO_HOLD_BUF11}
insert_buffer [get_pins {y_out_reg_10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET12} -new_cell_names {U_PTECO_HOLD_BUF12}
insert_buffer [get_pins {HFSBUF_19_79/A}] DELLN2X2_RVT -new_net_names {net_PTECO_HOLD_NET13} -new_cell_names {U_PTECO_HOLD_BUF13}
insert_buffer [get_pins {y_out_reg_11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET14} -new_cell_names {U_PTECO_HOLD_BUF14}
insert_buffer [get_pins {HFSBUF_34_71/A}] DELLN2X2_RVT -new_net_names {net_PTECO_HOLD_NET15} -new_cell_names {U_PTECO_HOLD_BUF15}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int2_reg_0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET16} -new_cell_names {U_PTECO_HOLD_BUF16}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {HFSBUF_34_72/A}] DELLN2X2_RVT -new_net_names {net_PTECO_HOLD_NET17} -new_cell_names {U_PTECO_HOLD_BUF17}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int3_reg_0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET18} -new_cell_names {U_PTECO_HOLD_BUF18}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {HFSBUF_34_74/A}] DELLN2X2_RVT -new_net_names {net_PTECO_HOLD_NET19} -new_cell_names {U_PTECO_HOLD_BUF19}
insert_buffer [get_pins {y_out_reg_3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET20} -new_cell_names {U_PTECO_HOLD_BUF20}
insert_buffer [get_pins {HFSBUF_34_70/A}] DELLN2X2_RVT -new_net_names {net_PTECO_HOLD_NET21} -new_cell_names {U_PTECO_HOLD_BUF21}
current_instance
insert_buffer [get_pins {u_cic_u_decimador_count_reg_1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET22} -new_cell_names {U_PTECO_HOLD_BUF22}
insert_buffer [get_pins {HFSBUF_11_78/A}] DELLN2X2_RVT -new_net_names {net_PTECO_HOLD_NET23} -new_cell_names {U_PTECO_HOLD_BUF23}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {y_out_reg_2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET24} -new_cell_names {U_PTECO_HOLD_BUF24}
insert_buffer [get_pins {HFSBUF_19_73/A}] DELLN2X2_RVT -new_net_names {net_PTECO_HOLD_NET25} -new_cell_names {U_PTECO_HOLD_BUF25}
insert_buffer [get_pins {y_out_reg_14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET26} -new_cell_names {U_PTECO_HOLD_BUF26}
current_instance
insert_buffer [get_pins {HFSBUF_11_76/A}] DELLN2X2_RVT -new_net_names {net_PTECO_HOLD_NET27} -new_cell_names {U_PTECO_HOLD_BUF27}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {y_out_reg_5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET28} -new_cell_names {U_PTECO_HOLD_BUF28}
current_instance
insert_buffer [get_pins {HFSBUF_4_26/A}] DELLN2X2_RVT -new_net_names {net_PTECO_HOLD_NET29} -new_cell_names {U_PTECO_HOLD_BUF29}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_50__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET30} -new_cell_names {U_PTECO_HOLD_BUF30}
current_instance
insert_buffer [get_pins {HFSBUF_11_77/A}] DELLN2X2_RVT -new_net_names {net_PTECO_HOLD_NET31} -new_cell_names {U_PTECO_HOLD_BUF31}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {y_out_reg_7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET32} -new_cell_names {U_PTECO_HOLD_BUF32}
current_instance
insert_buffer [get_pins {HFSBUF_11_67/A}] DELLN2X2_RVT -new_net_names {net_PTECO_HOLD_NET33} -new_cell_names {U_PTECO_HOLD_BUF33}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_42__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET34} -new_cell_names {U_PTECO_HOLD_BUF34}
insert_buffer [get_pins {HFSBUF_34_75/A}] DELLN2X2_RVT -new_net_names {net_PTECO_HOLD_NET35} -new_cell_names {U_PTECO_HOLD_BUF35}
insert_buffer [get_pins {delay_reg_40__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET36} -new_cell_names {U_PTECO_HOLD_BUF36}
current_instance
insert_buffer [get_ports {y_out[18]}] DELLN2X2_RVT -new_net_names {net_PTECO_HOLD_NET37} -new_cell_names {U_PTECO_HOLD_BUF37}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {HFSBUF_34_68/A}] DELLN2X2_RVT -new_net_names {net_PTECO_HOLD_NET38} -new_cell_names {U_PTECO_HOLD_BUF38}
insert_buffer [get_pins {delay_reg_43__15_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET39} -new_cell_names {U_PTECO_HOLD_BUF39}
insert_buffer [get_pins {delay_reg_7__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET40} -new_cell_names {U_PTECO_HOLD_BUF40}
insert_buffer [get_pins {U2924/A2}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET41} -new_cell_names {U_PTECO_HOLD_BUF41}
insert_buffer [get_pins {delay_reg_61__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET42} -new_cell_names {U_PTECO_HOLD_BUF42}
insert_buffer [get_pins {U3875/A2}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET43} -new_cell_names {U_PTECO_HOLD_BUF43}
insert_buffer [get_pins {delay_reg_6__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET44} -new_cell_names {U_PTECO_HOLD_BUF44}
insert_buffer [get_pins {U2893/A2}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET45} -new_cell_names {U_PTECO_HOLD_BUF45}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_y_out_reg_7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET46} -new_cell_names {U_PTECO_HOLD_BUF46}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_10__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET47} -new_cell_names {U_PTECO_HOLD_BUF47}
insert_buffer [get_pins {delay_reg_5__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET48} -new_cell_names {U_PTECO_HOLD_BUF48}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_x_delay_reg_9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET49} -new_cell_names {U_PTECO_HOLD_BUF49}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_56__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET50} -new_cell_names {U_PTECO_HOLD_BUF50}
insert_buffer [get_pins {delay_reg_56__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET51} -new_cell_names {U_PTECO_HOLD_BUF51}
insert_buffer [get_pins {delay_reg_46__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET52} -new_cell_names {U_PTECO_HOLD_BUF52}
insert_buffer [get_pins {delay_reg_62__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET53} -new_cell_names {U_PTECO_HOLD_BUF53}
insert_buffer [get_pins {delay_reg_0__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET54} -new_cell_names {U_PTECO_HOLD_BUF54}
insert_buffer [get_pins {U3883/A2}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET55} -new_cell_names {U_PTECO_HOLD_BUF55}
insert_buffer [get_pins {delay_reg_27__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET56} -new_cell_names {U_PTECO_HOLD_BUF56}
insert_buffer [get_pins {delay_reg_47__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET57} -new_cell_names {U_PTECO_HOLD_BUF57}
insert_buffer [get_pins {delay_reg_46__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET58} -new_cell_names {U_PTECO_HOLD_BUF58}
insert_buffer [get_pins {delay_reg_63__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET59} -new_cell_names {U_PTECO_HOLD_BUF59}
insert_buffer [get_pins {delay_reg_1__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET60} -new_cell_names {U_PTECO_HOLD_BUF60}
insert_buffer [get_pins {delay_reg_58__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET61} -new_cell_names {U_PTECO_HOLD_BUF61}
insert_buffer [get_pins {delay_reg_39__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET62} -new_cell_names {U_PTECO_HOLD_BUF62}
insert_buffer [get_pins {delay_reg_54__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET63} -new_cell_names {U_PTECO_HOLD_BUF63}
insert_buffer [get_pins {delay_reg_8__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET64} -new_cell_names {U_PTECO_HOLD_BUF64}
insert_buffer [get_pins {delay_reg_51__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET65} -new_cell_names {U_PTECO_HOLD_BUF65}
insert_buffer [get_pins {delay_reg_62__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET66} -new_cell_names {U_PTECO_HOLD_BUF66}
insert_buffer [get_pins {delay_reg_53__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET67} -new_cell_names {U_PTECO_HOLD_BUF67}
insert_buffer [get_pins {delay_reg_7__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET68} -new_cell_names {U_PTECO_HOLD_BUF68}
insert_buffer [get_pins {delay_reg_2__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET69} -new_cell_names {U_PTECO_HOLD_BUF69}
insert_buffer [get_pins {delay_reg_53__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET70} -new_cell_names {U_PTECO_HOLD_BUF70}
insert_buffer [get_pins {delay_reg_61__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET71} -new_cell_names {U_PTECO_HOLD_BUF71}
insert_buffer [get_pins {delay_reg_1__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET72} -new_cell_names {U_PTECO_HOLD_BUF72}
insert_buffer [get_pins {delay_reg_52__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET73} -new_cell_names {U_PTECO_HOLD_BUF73}
insert_buffer [get_pins {delay_reg_61__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET74} -new_cell_names {U_PTECO_HOLD_BUF74}
insert_buffer [get_pins {delay_reg_57__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET75} -new_cell_names {U_PTECO_HOLD_BUF75}
insert_buffer [get_pins {delay_reg_7__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET76} -new_cell_names {U_PTECO_HOLD_BUF76}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int3_reg_1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET77} -new_cell_names {U_PTECO_HOLD_BUF77}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_55__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET78} -new_cell_names {U_PTECO_HOLD_BUF78}
insert_buffer [get_pins {delay_reg_51__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET79} -new_cell_names {U_PTECO_HOLD_BUF79}
insert_buffer [get_pins {delay_reg_2__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET80} -new_cell_names {U_PTECO_HOLD_BUF80}
insert_buffer [get_pins {delay_reg_5__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET81} -new_cell_names {U_PTECO_HOLD_BUF81}
insert_buffer [get_pins {delay_reg_62__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET82} -new_cell_names {U_PTECO_HOLD_BUF82}
insert_buffer [get_pins {delay_reg_55__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET83} -new_cell_names {U_PTECO_HOLD_BUF83}
insert_buffer [get_pins {delay_reg_4__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET84} -new_cell_names {U_PTECO_HOLD_BUF84}
insert_buffer [get_pins {delay_reg_6__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET85} -new_cell_names {U_PTECO_HOLD_BUF85}
insert_buffer [get_pins {delay_reg_55__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET86} -new_cell_names {U_PTECO_HOLD_BUF86}
insert_buffer [get_pins {delay_reg_10__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET87} -new_cell_names {U_PTECO_HOLD_BUF87}
insert_buffer [get_pins {delay_reg_59__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET88} -new_cell_names {U_PTECO_HOLD_BUF88}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_x_delay_reg_9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET89} -new_cell_names {U_PTECO_HOLD_BUF89}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_47__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET90} -new_cell_names {U_PTECO_HOLD_BUF90}
insert_buffer [get_pins {delay_reg_10__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET91} -new_cell_names {U_PTECO_HOLD_BUF91}
insert_buffer [get_pins {delay_reg_8__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET92} -new_cell_names {U_PTECO_HOLD_BUF92}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_y_out_reg_13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET93} -new_cell_names {U_PTECO_HOLD_BUF93}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_17__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET94} -new_cell_names {U_PTECO_HOLD_BUF94}
insert_buffer [get_pins {delay_reg_58__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET95} -new_cell_names {U_PTECO_HOLD_BUF95}
insert_buffer [get_pins {delay_reg_57__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET96} -new_cell_names {U_PTECO_HOLD_BUF96}
insert_buffer [get_pins {delay_reg_11__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET97} -new_cell_names {U_PTECO_HOLD_BUF97}
insert_buffer [get_pins {delay_reg_54__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET98} -new_cell_names {U_PTECO_HOLD_BUF98}
insert_buffer [get_pins {delay_reg_55__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET99} -new_cell_names {U_PTECO_HOLD_BUF99}
insert_buffer [get_pins {delay_reg_6__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET100} -new_cell_names {U_PTECO_HOLD_BUF100}
insert_buffer [get_pins {delay_reg_11__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET101} -new_cell_names {U_PTECO_HOLD_BUF101}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_x_delay_reg_0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET102} -new_cell_names {U_PTECO_HOLD_BUF102}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_59__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET103} -new_cell_names {U_PTECO_HOLD_BUF103}
insert_buffer [get_pins {delay_reg_60__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET104} -new_cell_names {U_PTECO_HOLD_BUF104}
insert_buffer [get_pins {delay_reg_1__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET105} -new_cell_names {U_PTECO_HOLD_BUF105}
insert_buffer [get_pins {delay_reg_5__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET106} -new_cell_names {U_PTECO_HOLD_BUF106}
insert_buffer [get_pins {delay_reg_59__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET107} -new_cell_names {U_PTECO_HOLD_BUF107}
insert_buffer [get_pins {delay_reg_2__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET108} -new_cell_names {U_PTECO_HOLD_BUF108}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_y_out_reg_8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET109} -new_cell_names {U_PTECO_HOLD_BUF109}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_57__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET110} -new_cell_names {U_PTECO_HOLD_BUF110}
insert_buffer [get_pins {delay_reg_60__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET111} -new_cell_names {U_PTECO_HOLD_BUF111}
insert_buffer [get_pins {delay_reg_10__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET112} -new_cell_names {U_PTECO_HOLD_BUF112}
insert_buffer [get_pins {delay_reg_7__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET113} -new_cell_names {U_PTECO_HOLD_BUF113}
insert_buffer [get_pins {delay_reg_54__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET114} -new_cell_names {U_PTECO_HOLD_BUF114}
insert_buffer [get_pins {delay_reg_9__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET115} -new_cell_names {U_PTECO_HOLD_BUF115}
insert_buffer [get_pins {delay_reg_0__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET116} -new_cell_names {U_PTECO_HOLD_BUF116}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_y_out_reg_4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET117} -new_cell_names {U_PTECO_HOLD_BUF117}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_56__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET118} -new_cell_names {U_PTECO_HOLD_BUF118}
insert_buffer [get_pins {delay_reg_7__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET119} -new_cell_names {U_PTECO_HOLD_BUF119}
insert_buffer [get_pins {delay_reg_8__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET120} -new_cell_names {U_PTECO_HOLD_BUF120}
insert_buffer [get_pins {delay_reg_52__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET121} -new_cell_names {U_PTECO_HOLD_BUF121}
insert_buffer [get_pins {delay_reg_4__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET122} -new_cell_names {U_PTECO_HOLD_BUF122}
insert_buffer [get_pins {delay_reg_54__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET123} -new_cell_names {U_PTECO_HOLD_BUF123}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int2_reg_3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET124} -new_cell_names {U_PTECO_HOLD_BUF124}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_5__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET125} -new_cell_names {U_PTECO_HOLD_BUF125}
insert_buffer [get_pins {delay_reg_58__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET126} -new_cell_names {U_PTECO_HOLD_BUF126}
insert_buffer [get_pins {delay_reg_52__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET127} -new_cell_names {U_PTECO_HOLD_BUF127}
insert_buffer [get_pins {delay_reg_3__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET128} -new_cell_names {U_PTECO_HOLD_BUF128}
insert_buffer [get_pins {delay_reg_60__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET129} -new_cell_names {U_PTECO_HOLD_BUF129}
insert_buffer [get_pins {delay_reg_59__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET130} -new_cell_names {U_PTECO_HOLD_BUF130}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int2_reg_4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET131} -new_cell_names {U_PTECO_HOLD_BUF131}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_62__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET132} -new_cell_names {U_PTECO_HOLD_BUF132}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_x_delay_reg_17_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET133} -new_cell_names {U_PTECO_HOLD_BUF133}
insert_buffer [get_pins {u_cic_u_combs_u_comb4_y_out_reg_17_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET134} -new_cell_names {U_PTECO_HOLD_BUF134}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_60__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET135} -new_cell_names {U_PTECO_HOLD_BUF135}
insert_buffer [get_pins {delay_reg_3__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET136} -new_cell_names {U_PTECO_HOLD_BUF136}
insert_buffer [get_pins {delay_reg_2__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET137} -new_cell_names {U_PTECO_HOLD_BUF137}
insert_buffer [get_pins {delay_reg_2__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET138} -new_cell_names {U_PTECO_HOLD_BUF138}
insert_buffer [get_pins {delay_reg_2__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET139} -new_cell_names {U_PTECO_HOLD_BUF139}
insert_buffer [get_pins {delay_reg_51__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET140} -new_cell_names {U_PTECO_HOLD_BUF140}
insert_buffer [get_pins {delay_reg_5__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET141} -new_cell_names {U_PTECO_HOLD_BUF141}
insert_buffer [get_pins {delay_reg_6__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET142} -new_cell_names {U_PTECO_HOLD_BUF142}
insert_buffer [get_pins {delay_reg_8__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET143} -new_cell_names {U_PTECO_HOLD_BUF143}
insert_buffer [get_pins {delay_reg_61__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET144} -new_cell_names {U_PTECO_HOLD_BUF144}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int3_reg_17_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET145} -new_cell_names {U_PTECO_HOLD_BUF145}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_53__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET146} -new_cell_names {U_PTECO_HOLD_BUF146}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_y_out_reg_14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET147} -new_cell_names {U_PTECO_HOLD_BUF147}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_52__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET148} -new_cell_names {U_PTECO_HOLD_BUF148}
insert_buffer [get_pins {delay_reg_53__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET149} -new_cell_names {U_PTECO_HOLD_BUF149}
insert_buffer [get_pins {delay_reg_4__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET150} -new_cell_names {U_PTECO_HOLD_BUF150}
insert_buffer [get_pins {delay_reg_2__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET151} -new_cell_names {U_PTECO_HOLD_BUF151}
insert_buffer [get_pins {delay_reg_63__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET152} -new_cell_names {U_PTECO_HOLD_BUF152}
insert_buffer [get_pins {delay_reg_4__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET153} -new_cell_names {U_PTECO_HOLD_BUF153}
insert_buffer [get_pins {delay_reg_6__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET154} -new_cell_names {U_PTECO_HOLD_BUF154}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int2_reg_1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET155} -new_cell_names {U_PTECO_HOLD_BUF155}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_5__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET156} -new_cell_names {U_PTECO_HOLD_BUF156}
insert_buffer [get_pins {delay_reg_55__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET157} -new_cell_names {U_PTECO_HOLD_BUF157}
insert_buffer [get_pins {delay_reg_59__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET158} -new_cell_names {U_PTECO_HOLD_BUF158}
insert_buffer [get_pins {delay_reg_53__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET159} -new_cell_names {U_PTECO_HOLD_BUF159}
insert_buffer [get_pins {delay_reg_7__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET160} -new_cell_names {U_PTECO_HOLD_BUF160}
insert_buffer [get_pins {delay_reg_53__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET161} -new_cell_names {U_PTECO_HOLD_BUF161}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int2_reg_2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET162} -new_cell_names {U_PTECO_HOLD_BUF162}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_0__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET163} -new_cell_names {U_PTECO_HOLD_BUF163}
insert_buffer [get_pins {delay_reg_11__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET164} -new_cell_names {U_PTECO_HOLD_BUF164}
insert_buffer [get_pins {delay_reg_5__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET165} -new_cell_names {U_PTECO_HOLD_BUF165}
insert_buffer [get_pins {delay_reg_0__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET166} -new_cell_names {U_PTECO_HOLD_BUF166}
insert_buffer [get_pins {delay_reg_62__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET167} -new_cell_names {U_PTECO_HOLD_BUF167}
insert_buffer [get_pins {delay_reg_63__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET168} -new_cell_names {U_PTECO_HOLD_BUF168}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_y_out_reg_4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET169} -new_cell_names {U_PTECO_HOLD_BUF169}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_8__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET170} -new_cell_names {U_PTECO_HOLD_BUF170}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int1_reg_15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET171} -new_cell_names {U_PTECO_HOLD_BUF171}
insert_buffer [get_pins {u_cic_u_integradores_int2_reg_15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET172} -new_cell_names {U_PTECO_HOLD_BUF172}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_4__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET173} -new_cell_names {U_PTECO_HOLD_BUF173}
insert_buffer [get_pins {delay_reg_1__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET174} -new_cell_names {U_PTECO_HOLD_BUF174}
insert_buffer [get_pins {delay_reg_63__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET175} -new_cell_names {U_PTECO_HOLD_BUF175}
insert_buffer [get_pins {delay_reg_62__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET176} -new_cell_names {U_PTECO_HOLD_BUF176}
insert_buffer [get_pins {delay_reg_54__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET177} -new_cell_names {U_PTECO_HOLD_BUF177}
current_instance
insert_buffer [get_pins {u_cic_u_decimador_valid_reg/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET178} -new_cell_names {U_PTECO_HOLD_BUF178}
insert_buffer [get_pins {u_cic_u_combs_u_comb2_x_delay_reg_5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET179} -new_cell_names {U_PTECO_HOLD_BUF179}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_9__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET180} -new_cell_names {U_PTECO_HOLD_BUF180}
insert_buffer [get_pins {delay_reg_35__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET181} -new_cell_names {U_PTECO_HOLD_BUF181}
insert_buffer [get_pins {delay_reg_60__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET182} -new_cell_names {U_PTECO_HOLD_BUF182}
insert_buffer [get_pins {delay_reg_55__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET183} -new_cell_names {U_PTECO_HOLD_BUF183}
insert_buffer [get_pins {delay_reg_11__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET184} -new_cell_names {U_PTECO_HOLD_BUF184}
insert_buffer [get_pins {delay_reg_23__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET185} -new_cell_names {U_PTECO_HOLD_BUF185}
insert_buffer [get_pins {delay_reg_58__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET186} -new_cell_names {U_PTECO_HOLD_BUF186}
insert_buffer [get_pins {delay_reg_62__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET187} -new_cell_names {U_PTECO_HOLD_BUF187}
insert_buffer [get_pins {delay_reg_10__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET188} -new_cell_names {U_PTECO_HOLD_BUF188}
insert_buffer [get_pins {delay_reg_9__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET189} -new_cell_names {U_PTECO_HOLD_BUF189}
insert_buffer [get_pins {delay_reg_51__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET190} -new_cell_names {U_PTECO_HOLD_BUF190}
insert_buffer [get_pins {delay_reg_3__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET191} -new_cell_names {U_PTECO_HOLD_BUF191}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int1_reg_5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET192} -new_cell_names {U_PTECO_HOLD_BUF192}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_2__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET193} -new_cell_names {U_PTECO_HOLD_BUF193}
insert_buffer [get_pins {delay_reg_51__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET194} -new_cell_names {U_PTECO_HOLD_BUF194}
insert_buffer [get_pins {delay_reg_57__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET195} -new_cell_names {U_PTECO_HOLD_BUF195}
insert_buffer [get_pins {delay_reg_11__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET196} -new_cell_names {U_PTECO_HOLD_BUF196}
insert_buffer [get_pins {delay_reg_50__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET197} -new_cell_names {U_PTECO_HOLD_BUF197}
insert_buffer [get_pins {delay_reg_55__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET198} -new_cell_names {U_PTECO_HOLD_BUF198}
insert_buffer [get_pins {delay_reg_57__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET199} -new_cell_names {U_PTECO_HOLD_BUF199}
insert_buffer [get_pins {delay_reg_39__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET200} -new_cell_names {U_PTECO_HOLD_BUF200}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_x_delay_reg_4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET201} -new_cell_names {U_PTECO_HOLD_BUF201}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_24__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET202} -new_cell_names {U_PTECO_HOLD_BUF202}
insert_buffer [get_pins {delay_reg_62__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET203} -new_cell_names {U_PTECO_HOLD_BUF203}
insert_buffer [get_pins {delay_reg_41__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET204} -new_cell_names {U_PTECO_HOLD_BUF204}
insert_buffer [get_pins {delay_reg_6__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET205} -new_cell_names {U_PTECO_HOLD_BUF205}
insert_buffer [get_pins {delay_reg_0__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET206} -new_cell_names {U_PTECO_HOLD_BUF206}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int4_reg_16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET207} -new_cell_names {U_PTECO_HOLD_BUF207}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_59__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET208} -new_cell_names {U_PTECO_HOLD_BUF208}
insert_buffer [get_pins {delay_reg_43__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET209} -new_cell_names {U_PTECO_HOLD_BUF209}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int3_reg_3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET210} -new_cell_names {U_PTECO_HOLD_BUF210}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_1__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET211} -new_cell_names {U_PTECO_HOLD_BUF211}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_x_delay_reg_6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET212} -new_cell_names {U_PTECO_HOLD_BUF212}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_10__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET213} -new_cell_names {U_PTECO_HOLD_BUF213}
insert_buffer [get_pins {delay_reg_8__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET214} -new_cell_names {U_PTECO_HOLD_BUF214}
insert_buffer [get_pins {delay_reg_61__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET215} -new_cell_names {U_PTECO_HOLD_BUF215}
insert_buffer [get_pins {delay_reg_51__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET216} -new_cell_names {U_PTECO_HOLD_BUF216}
insert_buffer [get_pins {delay_reg_26__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET217} -new_cell_names {U_PTECO_HOLD_BUF217}
insert_buffer [get_pins {delay_reg_52__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET218} -new_cell_names {U_PTECO_HOLD_BUF218}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_y_out_reg_5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET219} -new_cell_names {U_PTECO_HOLD_BUF219}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_5__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET220} -new_cell_names {U_PTECO_HOLD_BUF220}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_y_out_reg_6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET221} -new_cell_names {U_PTECO_HOLD_BUF221}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_62__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET222} -new_cell_names {U_PTECO_HOLD_BUF222}
insert_buffer [get_pins {delay_reg_51__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET223} -new_cell_names {U_PTECO_HOLD_BUF223}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int1_reg_6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET224} -new_cell_names {U_PTECO_HOLD_BUF224}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_59__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET225} -new_cell_names {U_PTECO_HOLD_BUF225}
insert_buffer [get_pins {delay_reg_59__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET226} -new_cell_names {U_PTECO_HOLD_BUF226}
insert_buffer [get_pins {delay_reg_51__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET227} -new_cell_names {U_PTECO_HOLD_BUF227}
insert_buffer [get_pins {delay_reg_61__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET228} -new_cell_names {U_PTECO_HOLD_BUF228}
insert_buffer [get_pins {delay_reg_9__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET229} -new_cell_names {U_PTECO_HOLD_BUF229}
insert_buffer [get_pins {delay_reg_7__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET230} -new_cell_names {U_PTECO_HOLD_BUF230}
insert_buffer [get_pins {delay_reg_50__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET231} -new_cell_names {U_PTECO_HOLD_BUF231}
insert_buffer [get_pins {delay_reg_50__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET232} -new_cell_names {U_PTECO_HOLD_BUF232}
insert_buffer [get_pins {delay_reg_8__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET233} -new_cell_names {U_PTECO_HOLD_BUF233}
insert_buffer [get_pins {delay_reg_27__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET234} -new_cell_names {U_PTECO_HOLD_BUF234}
insert_buffer [get_pins {delay_reg_9__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET235} -new_cell_names {U_PTECO_HOLD_BUF235}
insert_buffer [get_pins {delay_reg_6__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET236} -new_cell_names {U_PTECO_HOLD_BUF236}
insert_buffer [get_pins {delay_reg_0__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET237} -new_cell_names {U_PTECO_HOLD_BUF237}
insert_buffer [get_pins {delay_reg_3__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET238} -new_cell_names {U_PTECO_HOLD_BUF238}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_y_out_reg_4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET239} -new_cell_names {U_PTECO_HOLD_BUF239}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_63__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET240} -new_cell_names {U_PTECO_HOLD_BUF240}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_x_delay_reg_14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET241} -new_cell_names {U_PTECO_HOLD_BUF241}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_60__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET242} -new_cell_names {U_PTECO_HOLD_BUF242}
insert_buffer [get_pins {delay_reg_10__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET243} -new_cell_names {U_PTECO_HOLD_BUF243}
insert_buffer [get_pins {delay_reg_4__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET244} -new_cell_names {U_PTECO_HOLD_BUF244}
insert_buffer [get_pins {delay_reg_3__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET245} -new_cell_names {U_PTECO_HOLD_BUF245}
insert_buffer [get_pins {delay_reg_57__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET246} -new_cell_names {U_PTECO_HOLD_BUF246}
insert_buffer [get_pins {delay_reg_53__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET247} -new_cell_names {U_PTECO_HOLD_BUF247}
insert_buffer [get_pins {delay_reg_10__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET248} -new_cell_names {U_PTECO_HOLD_BUF248}
insert_buffer [get_pins {delay_reg_3__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET249} -new_cell_names {U_PTECO_HOLD_BUF249}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int3_reg_5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET250} -new_cell_names {U_PTECO_HOLD_BUF250}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_30__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET251} -new_cell_names {U_PTECO_HOLD_BUF251}
insert_buffer [get_pins {delay_reg_8__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET252} -new_cell_names {U_PTECO_HOLD_BUF252}
insert_buffer [get_pins {delay_reg_36__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET253} -new_cell_names {U_PTECO_HOLD_BUF253}
insert_buffer [get_pins {delay_reg_2__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET254} -new_cell_names {U_PTECO_HOLD_BUF254}
insert_buffer [get_pins {delay_reg_19__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET255} -new_cell_names {U_PTECO_HOLD_BUF255}
insert_buffer [get_pins {delay_reg_20__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET256} -new_cell_names {U_PTECO_HOLD_BUF256}
insert_buffer [get_pins {delay_reg_54__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET257} -new_cell_names {U_PTECO_HOLD_BUF257}
insert_buffer [get_pins {delay_reg_3__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET258} -new_cell_names {U_PTECO_HOLD_BUF258}
insert_buffer [get_pins {delay_reg_9__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET259} -new_cell_names {U_PTECO_HOLD_BUF259}
insert_buffer [get_pins {delay_reg_63__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET260} -new_cell_names {U_PTECO_HOLD_BUF260}
insert_buffer [get_pins {delay_reg_38__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET261} -new_cell_names {U_PTECO_HOLD_BUF261}
insert_buffer [get_pins {delay_reg_0__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET262} -new_cell_names {U_PTECO_HOLD_BUF262}
insert_buffer [get_pins {delay_reg_49__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET263} -new_cell_names {U_PTECO_HOLD_BUF263}
insert_buffer [get_pins {delay_reg_48__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET264} -new_cell_names {U_PTECO_HOLD_BUF264}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int2_reg_17_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET265} -new_cell_names {U_PTECO_HOLD_BUF265}
insert_buffer [get_pins {u_cic_u_combs_u_comb4_y_out_reg_12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET266} -new_cell_names {U_PTECO_HOLD_BUF266}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_36__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET267} -new_cell_names {U_PTECO_HOLD_BUF267}
insert_buffer [get_pins {delay_reg_54__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET268} -new_cell_names {U_PTECO_HOLD_BUF268}
insert_buffer [get_pins {delay_reg_6__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET269} -new_cell_names {U_PTECO_HOLD_BUF269}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_x_delay_reg_3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET270} -new_cell_names {U_PTECO_HOLD_BUF270}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_33__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET271} -new_cell_names {U_PTECO_HOLD_BUF271}
insert_buffer [get_pins {delay_reg_51__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET272} -new_cell_names {U_PTECO_HOLD_BUF272}
insert_buffer [get_pins {delay_reg_4__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET273} -new_cell_names {U_PTECO_HOLD_BUF273}
insert_buffer [get_pins {delay_reg_31__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET274} -new_cell_names {U_PTECO_HOLD_BUF274}
insert_buffer [get_pins {delay_reg_52__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET275} -new_cell_names {U_PTECO_HOLD_BUF275}
insert_buffer [get_pins {delay_reg_6__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET276} -new_cell_names {U_PTECO_HOLD_BUF276}
insert_buffer [get_pins {delay_reg_35__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET277} -new_cell_names {U_PTECO_HOLD_BUF277}
insert_buffer [get_pins {delay_reg_7__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET278} -new_cell_names {U_PTECO_HOLD_BUF278}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_y_out_reg_8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET279} -new_cell_names {U_PTECO_HOLD_BUF279}
insert_buffer [get_pins {u_cic_u_integradores_int2_reg_13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET280} -new_cell_names {U_PTECO_HOLD_BUF280}
insert_buffer [get_pins {u_cic_u_integradores_int3_reg_6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET281} -new_cell_names {U_PTECO_HOLD_BUF281}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_1__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET282} -new_cell_names {U_PTECO_HOLD_BUF282}
insert_buffer [get_pins {delay_reg_60__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET283} -new_cell_names {U_PTECO_HOLD_BUF283}
insert_buffer [get_pins {delay_reg_17__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET284} -new_cell_names {U_PTECO_HOLD_BUF284}
insert_buffer [get_pins {delay_reg_21__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET285} -new_cell_names {U_PTECO_HOLD_BUF285}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_x_delay_reg_14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET286} -new_cell_names {U_PTECO_HOLD_BUF286}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_34__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET287} -new_cell_names {U_PTECO_HOLD_BUF287}
insert_buffer [get_pins {delay_reg_34__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET288} -new_cell_names {U_PTECO_HOLD_BUF288}
insert_buffer [get_pins {delay_reg_11__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET289} -new_cell_names {U_PTECO_HOLD_BUF289}
insert_buffer [get_pins {delay_reg_21__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET290} -new_cell_names {U_PTECO_HOLD_BUF290}
insert_buffer [get_pins {delay_reg_23__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET291} -new_cell_names {U_PTECO_HOLD_BUF291}
insert_buffer [get_pins {delay_reg_7__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET292} -new_cell_names {U_PTECO_HOLD_BUF292}
insert_buffer [get_pins {delay_reg_32__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET293} -new_cell_names {U_PTECO_HOLD_BUF293}
insert_buffer [get_pins {delay_reg_33__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET294} -new_cell_names {U_PTECO_HOLD_BUF294}
insert_buffer [get_pins {delay_reg_52__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET295} -new_cell_names {U_PTECO_HOLD_BUF295}
insert_buffer [get_pins {delay_reg_11__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET296} -new_cell_names {U_PTECO_HOLD_BUF296}
insert_buffer [get_pins {delay_reg_12__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET297} -new_cell_names {U_PTECO_HOLD_BUF297}
insert_buffer [get_pins {delay_reg_20__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET298} -new_cell_names {U_PTECO_HOLD_BUF298}
insert_buffer [get_pins {delay_reg_51__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET299} -new_cell_names {U_PTECO_HOLD_BUF299}
insert_buffer [get_pins {delay_reg_6__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET300} -new_cell_names {U_PTECO_HOLD_BUF300}
insert_buffer [get_pins {delay_reg_19__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET301} -new_cell_names {U_PTECO_HOLD_BUF301}
insert_buffer [get_pins {delay_reg_29__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET302} -new_cell_names {U_PTECO_HOLD_BUF302}
insert_buffer [get_pins {delay_reg_57__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET303} -new_cell_names {U_PTECO_HOLD_BUF303}
insert_buffer [get_pins {delay_reg_2__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET304} -new_cell_names {U_PTECO_HOLD_BUF304}
insert_buffer [get_pins {delay_reg_1__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET305} -new_cell_names {U_PTECO_HOLD_BUF305}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_y_out_reg_3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET306} -new_cell_names {U_PTECO_HOLD_BUF306}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_6__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET307} -new_cell_names {U_PTECO_HOLD_BUF307}
insert_buffer [get_pins {delay_reg_44__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET308} -new_cell_names {U_PTECO_HOLD_BUF308}
insert_buffer [get_pins {delay_reg_19__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET309} -new_cell_names {U_PTECO_HOLD_BUF309}
insert_buffer [get_pins {delay_reg_21__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET310} -new_cell_names {U_PTECO_HOLD_BUF310}
insert_buffer [get_pins {delay_reg_15__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET311} -new_cell_names {U_PTECO_HOLD_BUF311}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_y_out_reg_7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET312} -new_cell_names {U_PTECO_HOLD_BUF312}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_12__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET313} -new_cell_names {U_PTECO_HOLD_BUF313}
insert_buffer [get_pins {delay_reg_37__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET314} -new_cell_names {U_PTECO_HOLD_BUF314}
current_instance
insert_buffer [get_pins {u_cic_u_decimador_count_reg_0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET315} -new_cell_names {U_PTECO_HOLD_BUF315}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_4__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET316} -new_cell_names {U_PTECO_HOLD_BUF316}
insert_buffer [get_pins {delay_reg_53__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET317} -new_cell_names {U_PTECO_HOLD_BUF317}
insert_buffer [get_pins {delay_reg_32__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET318} -new_cell_names {U_PTECO_HOLD_BUF318}
insert_buffer [get_pins {delay_reg_56__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET319} -new_cell_names {U_PTECO_HOLD_BUF319}
insert_buffer [get_pins {delay_reg_58__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET320} -new_cell_names {U_PTECO_HOLD_BUF320}
insert_buffer [get_pins {delay_reg_38__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET321} -new_cell_names {U_PTECO_HOLD_BUF321}
insert_buffer [get_pins {delay_reg_58__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET322} -new_cell_names {U_PTECO_HOLD_BUF322}
insert_buffer [get_pins {delay_reg_63__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET323} -new_cell_names {U_PTECO_HOLD_BUF323}
insert_buffer [get_pins {delay_reg_3__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET324} -new_cell_names {U_PTECO_HOLD_BUF324}
insert_buffer [get_pins {delay_reg_51__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET325} -new_cell_names {U_PTECO_HOLD_BUF325}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_y_out_reg_1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET326} -new_cell_names {U_PTECO_HOLD_BUF326}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_0__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET327} -new_cell_names {U_PTECO_HOLD_BUF327}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_x_delay_reg_15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET328} -new_cell_names {U_PTECO_HOLD_BUF328}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_56__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET329} -new_cell_names {U_PTECO_HOLD_BUF329}
insert_buffer [get_pins {delay_reg_52__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET330} -new_cell_names {U_PTECO_HOLD_BUF330}
insert_buffer [get_pins {delay_reg_36__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET331} -new_cell_names {U_PTECO_HOLD_BUF331}
insert_buffer [get_pins {delay_reg_40__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET332} -new_cell_names {U_PTECO_HOLD_BUF332}
insert_buffer [get_pins {delay_reg_1__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET333} -new_cell_names {U_PTECO_HOLD_BUF333}
insert_buffer [get_pins {delay_reg_58__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET334} -new_cell_names {U_PTECO_HOLD_BUF334}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int1_reg_17_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET335} -new_cell_names {U_PTECO_HOLD_BUF335}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_59__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET336} -new_cell_names {U_PTECO_HOLD_BUF336}
insert_buffer [get_pins {delay_reg_0__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET337} -new_cell_names {U_PTECO_HOLD_BUF337}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int2_reg_16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET338} -new_cell_names {U_PTECO_HOLD_BUF338}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_0__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET339} -new_cell_names {U_PTECO_HOLD_BUF339}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int2_reg_7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET340} -new_cell_names {U_PTECO_HOLD_BUF340}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_0__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET341} -new_cell_names {U_PTECO_HOLD_BUF341}
insert_buffer [get_pins {delay_reg_26__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET342} -new_cell_names {U_PTECO_HOLD_BUF342}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int3_reg_2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET343} -new_cell_names {U_PTECO_HOLD_BUF343}
insert_buffer [get_pins {u_cic_u_combs_u_comb1_y_out_reg_12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET344} -new_cell_names {U_PTECO_HOLD_BUF344}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_37__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET345} -new_cell_names {U_PTECO_HOLD_BUF345}
insert_buffer [get_pins {delay_reg_19__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET346} -new_cell_names {U_PTECO_HOLD_BUF346}
insert_buffer [get_pins {delay_reg_43__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET347} -new_cell_names {U_PTECO_HOLD_BUF347}
insert_buffer [get_pins {delay_reg_30__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET348} -new_cell_names {U_PTECO_HOLD_BUF348}
insert_buffer [get_pins {delay_reg_5__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET349} -new_cell_names {U_PTECO_HOLD_BUF349}
insert_buffer [get_pins {delay_reg_61__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET350} -new_cell_names {U_PTECO_HOLD_BUF350}
insert_buffer [get_pins {delay_reg_12__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET351} -new_cell_names {U_PTECO_HOLD_BUF351}
insert_buffer [get_pins {delay_reg_9__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET352} -new_cell_names {U_PTECO_HOLD_BUF352}
insert_buffer [get_pins {delay_reg_35__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET353} -new_cell_names {U_PTECO_HOLD_BUF353}
insert_buffer [get_pins {delay_reg_32__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET354} -new_cell_names {U_PTECO_HOLD_BUF354}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int2_reg_10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET355} -new_cell_names {U_PTECO_HOLD_BUF355}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_45__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET356} -new_cell_names {U_PTECO_HOLD_BUF356}
insert_buffer [get_pins {delay_reg_12__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET357} -new_cell_names {U_PTECO_HOLD_BUF357}
insert_buffer [get_pins {delay_reg_59__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET358} -new_cell_names {U_PTECO_HOLD_BUF358}
insert_buffer [get_pins {delay_reg_63__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET359} -new_cell_names {U_PTECO_HOLD_BUF359}
insert_buffer [get_pins {delay_reg_11__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET360} -new_cell_names {U_PTECO_HOLD_BUF360}
insert_buffer [get_pins {delay_reg_58__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET361} -new_cell_names {U_PTECO_HOLD_BUF361}
insert_buffer [get_pins {delay_reg_20__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET362} -new_cell_names {U_PTECO_HOLD_BUF362}
insert_buffer [get_pins {delay_reg_15__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET363} -new_cell_names {U_PTECO_HOLD_BUF363}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_x_delay_reg_1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET364} -new_cell_names {U_PTECO_HOLD_BUF364}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_63__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET365} -new_cell_names {U_PTECO_HOLD_BUF365}
insert_buffer [get_pins {delay_reg_60__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET366} -new_cell_names {U_PTECO_HOLD_BUF366}
current_instance
insert_buffer [get_pins {u_cic_u_decimador_count_reg_2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET367} -new_cell_names {U_PTECO_HOLD_BUF367}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_2__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET368} -new_cell_names {U_PTECO_HOLD_BUF368}
insert_buffer [get_pins {delay_reg_61__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET369} -new_cell_names {U_PTECO_HOLD_BUF369}
insert_buffer [get_pins {delay_reg_16__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET370} -new_cell_names {U_PTECO_HOLD_BUF370}
insert_buffer [get_pins {delay_reg_31__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET371} -new_cell_names {U_PTECO_HOLD_BUF371}
insert_buffer [get_pins {delay_reg_24__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET372} -new_cell_names {U_PTECO_HOLD_BUF372}
insert_buffer [get_pins {delay_reg_61__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET373} -new_cell_names {U_PTECO_HOLD_BUF373}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int4_reg_7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET374} -new_cell_names {U_PTECO_HOLD_BUF374}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_48__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET375} -new_cell_names {U_PTECO_HOLD_BUF375}
insert_buffer [get_pins {delay_reg_49__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET376} -new_cell_names {U_PTECO_HOLD_BUF376}
insert_buffer [get_pins {delay_reg_0__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET377} -new_cell_names {U_PTECO_HOLD_BUF377}
insert_buffer [get_pins {delay_reg_33__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET378} -new_cell_names {U_PTECO_HOLD_BUF378}
insert_buffer [get_pins {delay_reg_29__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET379} -new_cell_names {U_PTECO_HOLD_BUF379}
insert_buffer [get_pins {delay_reg_49__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET380} -new_cell_names {U_PTECO_HOLD_BUF380}
insert_buffer [get_pins {delay_reg_40__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET381} -new_cell_names {U_PTECO_HOLD_BUF381}
insert_buffer [get_pins {delay_reg_50__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET382} -new_cell_names {U_PTECO_HOLD_BUF382}
insert_buffer [get_pins {delay_reg_48__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET383} -new_cell_names {U_PTECO_HOLD_BUF383}
insert_buffer [get_pins {delay_reg_62__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET384} -new_cell_names {U_PTECO_HOLD_BUF384}
insert_buffer [get_pins {delay_reg_9__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET385} -new_cell_names {U_PTECO_HOLD_BUF385}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_y_out_reg_15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET386} -new_cell_names {U_PTECO_HOLD_BUF386}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_57__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET387} -new_cell_names {U_PTECO_HOLD_BUF387}
insert_buffer [get_pins {delay_reg_9__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET388} -new_cell_names {U_PTECO_HOLD_BUF388}
insert_buffer [get_pins {delay_reg_27__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET389} -new_cell_names {U_PTECO_HOLD_BUF389}
insert_buffer [get_pins {delay_reg_54__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET390} -new_cell_names {U_PTECO_HOLD_BUF390}
insert_buffer [get_pins {delay_reg_32__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET391} -new_cell_names {U_PTECO_HOLD_BUF391}
insert_buffer [get_pins {delay_reg_47__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET392} -new_cell_names {U_PTECO_HOLD_BUF392}
insert_buffer [get_pins {delay_reg_45__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET393} -new_cell_names {U_PTECO_HOLD_BUF393}
insert_buffer [get_pins {delay_reg_51__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET394} -new_cell_names {U_PTECO_HOLD_BUF394}
insert_buffer [get_pins {delay_reg_35__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET395} -new_cell_names {U_PTECO_HOLD_BUF395}
insert_buffer [get_pins {delay_reg_46__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET396} -new_cell_names {U_PTECO_HOLD_BUF396}
insert_buffer [get_pins {delay_reg_55__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET397} -new_cell_names {U_PTECO_HOLD_BUF397}
insert_buffer [get_pins {delay_reg_25__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET398} -new_cell_names {U_PTECO_HOLD_BUF398}
insert_buffer [get_pins {delay_reg_18__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET399} -new_cell_names {U_PTECO_HOLD_BUF399}
insert_buffer [get_pins {delay_reg_41__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET400} -new_cell_names {U_PTECO_HOLD_BUF400}
insert_buffer [get_pins {delay_reg_56__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET401} -new_cell_names {U_PTECO_HOLD_BUF401}
insert_buffer [get_pins {delay_reg_3__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET402} -new_cell_names {U_PTECO_HOLD_BUF402}
insert_buffer [get_pins {delay_reg_59__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET403} -new_cell_names {U_PTECO_HOLD_BUF403}
insert_buffer [get_pins {delay_reg_9__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET404} -new_cell_names {U_PTECO_HOLD_BUF404}
insert_buffer [get_pins {delay_reg_29__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET405} -new_cell_names {U_PTECO_HOLD_BUF405}
insert_buffer [get_pins {delay_reg_12__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET406} -new_cell_names {U_PTECO_HOLD_BUF406}
insert_buffer [get_pins {delay_reg_39__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET407} -new_cell_names {U_PTECO_HOLD_BUF407}
insert_buffer [get_pins {delay_reg_0__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET408} -new_cell_names {U_PTECO_HOLD_BUF408}
insert_buffer [get_pins {delay_reg_40__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET409} -new_cell_names {U_PTECO_HOLD_BUF409}
insert_buffer [get_pins {delay_reg_11__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET410} -new_cell_names {U_PTECO_HOLD_BUF410}
insert_buffer [get_pins {delay_reg_16__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET411} -new_cell_names {U_PTECO_HOLD_BUF411}
insert_buffer [get_pins {delay_reg_21__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET412} -new_cell_names {U_PTECO_HOLD_BUF412}
insert_buffer [get_pins {delay_reg_36__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET413} -new_cell_names {U_PTECO_HOLD_BUF413}
insert_buffer [get_pins {delay_reg_55__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET414} -new_cell_names {U_PTECO_HOLD_BUF414}
insert_buffer [get_pins {delay_reg_61__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET415} -new_cell_names {U_PTECO_HOLD_BUF415}
insert_buffer [get_pins {delay_reg_12__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET416} -new_cell_names {U_PTECO_HOLD_BUF416}
insert_buffer [get_pins {delay_reg_45__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET417} -new_cell_names {U_PTECO_HOLD_BUF417}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int1_reg_16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET418} -new_cell_names {U_PTECO_HOLD_BUF418}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_38__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET419} -new_cell_names {U_PTECO_HOLD_BUF419}
insert_buffer [get_pins {delay_reg_63__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET420} -new_cell_names {U_PTECO_HOLD_BUF420}
insert_buffer [get_pins {delay_reg_4__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET421} -new_cell_names {U_PTECO_HOLD_BUF421}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int1_reg_13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET422} -new_cell_names {U_PTECO_HOLD_BUF422}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_1__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET423} -new_cell_names {U_PTECO_HOLD_BUF423}
insert_buffer [get_pins {delay_reg_19__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET424} -new_cell_names {U_PTECO_HOLD_BUF424}
insert_buffer [get_pins {delay_reg_8__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET425} -new_cell_names {U_PTECO_HOLD_BUF425}
insert_buffer [get_pins {delay_reg_39__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET426} -new_cell_names {U_PTECO_HOLD_BUF426}
insert_buffer [get_pins {delay_reg_7__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET427} -new_cell_names {U_PTECO_HOLD_BUF427}
insert_buffer [get_pins {delay_reg_0__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET428} -new_cell_names {U_PTECO_HOLD_BUF428}
insert_buffer [get_pins {delay_reg_58__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET429} -new_cell_names {U_PTECO_HOLD_BUF429}
insert_buffer [get_pins {delay_reg_29__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET430} -new_cell_names {U_PTECO_HOLD_BUF430}
insert_buffer [get_pins {delay_reg_48__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET431} -new_cell_names {U_PTECO_HOLD_BUF431}
insert_buffer [get_pins {delay_reg_24__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET432} -new_cell_names {U_PTECO_HOLD_BUF432}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_x_delay_reg_11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET433} -new_cell_names {U_PTECO_HOLD_BUF433}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_26__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET434} -new_cell_names {U_PTECO_HOLD_BUF434}
insert_buffer [get_pins {delay_reg_18__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET435} -new_cell_names {U_PTECO_HOLD_BUF435}
insert_buffer [get_pins {delay_reg_29__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET436} -new_cell_names {U_PTECO_HOLD_BUF436}
insert_buffer [get_pins {delay_reg_3__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET437} -new_cell_names {U_PTECO_HOLD_BUF437}
insert_buffer [get_pins {delay_reg_33__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET438} -new_cell_names {U_PTECO_HOLD_BUF438}
insert_buffer [get_pins {delay_reg_37__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET439} -new_cell_names {U_PTECO_HOLD_BUF439}
insert_buffer [get_pins {delay_reg_60__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET440} -new_cell_names {U_PTECO_HOLD_BUF440}
insert_buffer [get_pins {delay_reg_15__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET441} -new_cell_names {U_PTECO_HOLD_BUF441}
insert_buffer [get_pins {delay_reg_14__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET442} -new_cell_names {U_PTECO_HOLD_BUF442}
insert_buffer [get_pins {delay_reg_51__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET443} -new_cell_names {U_PTECO_HOLD_BUF443}
insert_buffer [get_pins {delay_reg_37__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET444} -new_cell_names {U_PTECO_HOLD_BUF444}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_y_out_reg_6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET445} -new_cell_names {U_PTECO_HOLD_BUF445}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_15__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET446} -new_cell_names {U_PTECO_HOLD_BUF446}
insert_buffer [get_pins {delay_reg_34__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET447} -new_cell_names {U_PTECO_HOLD_BUF447}
insert_buffer [get_pins {delay_reg_36__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET448} -new_cell_names {U_PTECO_HOLD_BUF448}
insert_buffer [get_pins {delay_reg_63__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET449} -new_cell_names {U_PTECO_HOLD_BUF449}
insert_buffer [get_pins {delay_reg_19__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET450} -new_cell_names {U_PTECO_HOLD_BUF450}
insert_buffer [get_pins {delay_reg_20__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET451} -new_cell_names {U_PTECO_HOLD_BUF451}
insert_buffer [get_pins {delay_reg_62__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET452} -new_cell_names {U_PTECO_HOLD_BUF452}
insert_buffer [get_pins {delay_reg_31__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET453} -new_cell_names {U_PTECO_HOLD_BUF453}
insert_buffer [get_pins {delay_reg_12__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET454} -new_cell_names {U_PTECO_HOLD_BUF454}
insert_buffer [get_pins {delay_reg_15__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET455} -new_cell_names {U_PTECO_HOLD_BUF455}
insert_buffer [get_pins {delay_reg_50__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET456} -new_cell_names {U_PTECO_HOLD_BUF456}
insert_buffer [get_pins {delay_reg_35__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET457} -new_cell_names {U_PTECO_HOLD_BUF457}
insert_buffer [get_pins {delay_reg_23__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET458} -new_cell_names {U_PTECO_HOLD_BUF458}
insert_buffer [get_pins {delay_reg_45__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET459} -new_cell_names {U_PTECO_HOLD_BUF459}
insert_buffer [get_pins {delay_reg_55__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET460} -new_cell_names {U_PTECO_HOLD_BUF460}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_y_out_reg_2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET461} -new_cell_names {U_PTECO_HOLD_BUF461}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_45__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET462} -new_cell_names {U_PTECO_HOLD_BUF462}
insert_buffer [get_pins {delay_reg_45__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET463} -new_cell_names {U_PTECO_HOLD_BUF463}
insert_buffer [get_pins {delay_reg_29__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET464} -new_cell_names {U_PTECO_HOLD_BUF464}
insert_buffer [get_pins {delay_reg_24__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET465} -new_cell_names {U_PTECO_HOLD_BUF465}
insert_buffer [get_pins {delay_reg_25__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET466} -new_cell_names {U_PTECO_HOLD_BUF466}
insert_buffer [get_pins {delay_reg_20__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET467} -new_cell_names {U_PTECO_HOLD_BUF467}
insert_buffer [get_pins {delay_reg_56__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET468} -new_cell_names {U_PTECO_HOLD_BUF468}
insert_buffer [get_pins {delay_reg_8__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET469} -new_cell_names {U_PTECO_HOLD_BUF469}
insert_buffer [get_pins {delay_reg_16__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET470} -new_cell_names {U_PTECO_HOLD_BUF470}
insert_buffer [get_pins {delay_reg_42__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET471} -new_cell_names {U_PTECO_HOLD_BUF471}
insert_buffer [get_pins {delay_reg_12__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET472} -new_cell_names {U_PTECO_HOLD_BUF472}
insert_buffer [get_pins {delay_reg_53__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET473} -new_cell_names {U_PTECO_HOLD_BUF473}
insert_buffer [get_pins {delay_reg_5__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET474} -new_cell_names {U_PTECO_HOLD_BUF474}
insert_buffer [get_pins {delay_reg_49__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET475} -new_cell_names {U_PTECO_HOLD_BUF475}
insert_buffer [get_pins {delay_reg_52__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET476} -new_cell_names {U_PTECO_HOLD_BUF476}
insert_buffer [get_pins {delay_reg_42__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET477} -new_cell_names {U_PTECO_HOLD_BUF477}
insert_buffer [get_pins {delay_reg_4__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET478} -new_cell_names {U_PTECO_HOLD_BUF478}
insert_buffer [get_pins {delay_reg_27__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET479} -new_cell_names {U_PTECO_HOLD_BUF479}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int2_reg_12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET480} -new_cell_names {U_PTECO_HOLD_BUF480}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_57__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET481} -new_cell_names {U_PTECO_HOLD_BUF481}
insert_buffer [get_pins {delay_reg_30__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET482} -new_cell_names {U_PTECO_HOLD_BUF482}
insert_buffer [get_pins {delay_reg_31__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET483} -new_cell_names {U_PTECO_HOLD_BUF483}
insert_buffer [get_pins {delay_reg_26__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET484} -new_cell_names {U_PTECO_HOLD_BUF484}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_y_out_reg_3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET485} -new_cell_names {U_PTECO_HOLD_BUF485}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_20__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET486} -new_cell_names {U_PTECO_HOLD_BUF486}
insert_buffer [get_pins {delay_reg_63__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET487} -new_cell_names {U_PTECO_HOLD_BUF487}
insert_buffer [get_pins {delay_reg_52__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET488} -new_cell_names {U_PTECO_HOLD_BUF488}
insert_buffer [get_pins {delay_reg_45__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET489} -new_cell_names {U_PTECO_HOLD_BUF489}
insert_buffer [get_pins {delay_reg_61__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET490} -new_cell_names {U_PTECO_HOLD_BUF490}
insert_buffer [get_pins {delay_reg_6__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET491} -new_cell_names {U_PTECO_HOLD_BUF491}
insert_buffer [get_pins {delay_reg_44__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET492} -new_cell_names {U_PTECO_HOLD_BUF492}
insert_buffer [get_pins {delay_reg_34__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET493} -new_cell_names {U_PTECO_HOLD_BUF493}
insert_buffer [get_pins {delay_reg_57__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET494} -new_cell_names {U_PTECO_HOLD_BUF494}
insert_buffer [get_pins {delay_reg_18__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET495} -new_cell_names {U_PTECO_HOLD_BUF495}
insert_buffer [get_pins {delay_reg_1__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET496} -new_cell_names {U_PTECO_HOLD_BUF496}
insert_buffer [get_pins {delay_reg_49__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET497} -new_cell_names {U_PTECO_HOLD_BUF497}
insert_buffer [get_pins {delay_reg_44__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET498} -new_cell_names {U_PTECO_HOLD_BUF498}
insert_buffer [get_pins {delay_reg_33__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET499} -new_cell_names {U_PTECO_HOLD_BUF499}
insert_buffer [get_pins {delay_reg_35__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET500} -new_cell_names {U_PTECO_HOLD_BUF500}
insert_buffer [get_pins {delay_reg_27__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET501} -new_cell_names {U_PTECO_HOLD_BUF501}
insert_buffer [get_pins {delay_reg_28__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET502} -new_cell_names {U_PTECO_HOLD_BUF502}
insert_buffer [get_pins {delay_reg_20__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET503} -new_cell_names {U_PTECO_HOLD_BUF503}
insert_buffer [get_pins {delay_reg_42__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET504} -new_cell_names {U_PTECO_HOLD_BUF504}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int2_reg_11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET505} -new_cell_names {U_PTECO_HOLD_BUF505}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_0__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET506} -new_cell_names {U_PTECO_HOLD_BUF506}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int4_reg_0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET507} -new_cell_names {U_PTECO_HOLD_BUF507}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_55__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET508} -new_cell_names {U_PTECO_HOLD_BUF508}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_y_out_reg_10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET509} -new_cell_names {U_PTECO_HOLD_BUF509}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_35__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET510} -new_cell_names {U_PTECO_HOLD_BUF510}
insert_buffer [get_pins {delay_reg_22__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET511} -new_cell_names {U_PTECO_HOLD_BUF511}
insert_buffer [get_pins {delay_reg_12__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET512} -new_cell_names {U_PTECO_HOLD_BUF512}
insert_buffer [get_pins {delay_reg_54__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET513} -new_cell_names {U_PTECO_HOLD_BUF513}
insert_buffer [get_pins {delay_reg_17__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET514} -new_cell_names {U_PTECO_HOLD_BUF514}
insert_buffer [get_pins {delay_reg_43__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET515} -new_cell_names {U_PTECO_HOLD_BUF515}
insert_buffer [get_pins {delay_reg_54__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET516} -new_cell_names {U_PTECO_HOLD_BUF516}
insert_buffer [get_pins {delay_reg_24__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET517} -new_cell_names {U_PTECO_HOLD_BUF517}
insert_buffer [get_pins {delay_reg_20__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET518} -new_cell_names {U_PTECO_HOLD_BUF518}
insert_buffer [get_pins {delay_reg_18__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET519} -new_cell_names {U_PTECO_HOLD_BUF519}
insert_buffer [get_pins {delay_reg_1__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET520} -new_cell_names {U_PTECO_HOLD_BUF520}
insert_buffer [get_pins {delay_reg_36__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET521} -new_cell_names {U_PTECO_HOLD_BUF521}
insert_buffer [get_pins {delay_reg_13__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET522} -new_cell_names {U_PTECO_HOLD_BUF522}
insert_buffer [get_pins {y_out_reg_0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET523} -new_cell_names {U_PTECO_HOLD_BUF523}
insert_buffer [get_pins {delay_reg_34__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET524} -new_cell_names {U_PTECO_HOLD_BUF524}
insert_buffer [get_pins {delay_reg_11__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET525} -new_cell_names {U_PTECO_HOLD_BUF525}
insert_buffer [get_pins {delay_reg_29__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET526} -new_cell_names {U_PTECO_HOLD_BUF526}
insert_buffer [get_pins {delay_reg_40__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET527} -new_cell_names {U_PTECO_HOLD_BUF527}
insert_buffer [get_pins {delay_reg_4__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET528} -new_cell_names {U_PTECO_HOLD_BUF528}
insert_buffer [get_pins {delay_reg_8__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET529} -new_cell_names {U_PTECO_HOLD_BUF529}
insert_buffer [get_pins {delay_reg_21__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET530} -new_cell_names {U_PTECO_HOLD_BUF530}
insert_buffer [get_pins {delay_reg_58__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET531} -new_cell_names {U_PTECO_HOLD_BUF531}
insert_buffer [get_pins {delay_reg_6__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET532} -new_cell_names {U_PTECO_HOLD_BUF532}
insert_buffer [get_pins {delay_reg_30__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET533} -new_cell_names {U_PTECO_HOLD_BUF533}
insert_buffer [get_pins {delay_reg_10__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET534} -new_cell_names {U_PTECO_HOLD_BUF534}
insert_buffer [get_pins {delay_reg_35__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET535} -new_cell_names {U_PTECO_HOLD_BUF535}
insert_buffer [get_pins {delay_reg_33__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET536} -new_cell_names {U_PTECO_HOLD_BUF536}
insert_buffer [get_pins {delay_reg_15__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET537} -new_cell_names {U_PTECO_HOLD_BUF537}
insert_buffer [get_pins {delay_reg_30__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET538} -new_cell_names {U_PTECO_HOLD_BUF538}
insert_buffer [get_pins {delay_reg_13__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET539} -new_cell_names {U_PTECO_HOLD_BUF539}
insert_buffer [get_pins {delay_reg_10__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET540} -new_cell_names {U_PTECO_HOLD_BUF540}
insert_buffer [get_pins {delay_reg_33__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET541} -new_cell_names {U_PTECO_HOLD_BUF541}
insert_buffer [get_pins {delay_reg_56__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET542} -new_cell_names {U_PTECO_HOLD_BUF542}
insert_buffer [get_pins {delay_reg_57__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET543} -new_cell_names {U_PTECO_HOLD_BUF543}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_x_delay_reg_6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET544} -new_cell_names {U_PTECO_HOLD_BUF544}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_44__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET545} -new_cell_names {U_PTECO_HOLD_BUF545}
insert_buffer [get_pins {delay_reg_39__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET546} -new_cell_names {U_PTECO_HOLD_BUF546}
insert_buffer [get_pins {delay_reg_46__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET547} -new_cell_names {U_PTECO_HOLD_BUF547}
insert_buffer [get_pins {delay_reg_22__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET548} -new_cell_names {U_PTECO_HOLD_BUF548}
insert_buffer [get_pins {delay_reg_46__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET549} -new_cell_names {U_PTECO_HOLD_BUF549}
insert_buffer [get_pins {delay_reg_7__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET550} -new_cell_names {U_PTECO_HOLD_BUF550}
insert_buffer [get_pins {delay_reg_49__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET551} -new_cell_names {U_PTECO_HOLD_BUF551}
insert_buffer [get_pins {delay_reg_41__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET552} -new_cell_names {U_PTECO_HOLD_BUF552}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_y_out_reg_2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET553} -new_cell_names {U_PTECO_HOLD_BUF553}
insert_buffer [get_pins {u_cic_u_integradores_int3_reg_14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET554} -new_cell_names {U_PTECO_HOLD_BUF554}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_32__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET555} -new_cell_names {U_PTECO_HOLD_BUF555}
insert_buffer [get_pins {delay_reg_18__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET556} -new_cell_names {U_PTECO_HOLD_BUF556}
insert_buffer [get_pins {delay_reg_18__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET557} -new_cell_names {U_PTECO_HOLD_BUF557}
insert_buffer [get_pins {delay_reg_30__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET558} -new_cell_names {U_PTECO_HOLD_BUF558}
insert_buffer [get_pins {delay_reg_23__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET559} -new_cell_names {U_PTECO_HOLD_BUF559}
insert_buffer [get_pins {delay_reg_1__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET560} -new_cell_names {U_PTECO_HOLD_BUF560}
insert_buffer [get_pins {delay_reg_12__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET561} -new_cell_names {U_PTECO_HOLD_BUF561}
insert_buffer [get_pins {delay_reg_29__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET562} -new_cell_names {U_PTECO_HOLD_BUF562}
insert_buffer [get_pins {delay_reg_25__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET563} -new_cell_names {U_PTECO_HOLD_BUF563}
insert_buffer [get_pins {y_out_reg_15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET564} -new_cell_names {U_PTECO_HOLD_BUF564}
insert_buffer [get_pins {delay_reg_38__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET565} -new_cell_names {U_PTECO_HOLD_BUF565}
insert_buffer [get_pins {delay_reg_6__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET566} -new_cell_names {U_PTECO_HOLD_BUF566}
insert_buffer [get_pins {delay_reg_31__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET567} -new_cell_names {U_PTECO_HOLD_BUF567}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int3_reg_10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET568} -new_cell_names {U_PTECO_HOLD_BUF568}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_33__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET569} -new_cell_names {U_PTECO_HOLD_BUF569}
insert_buffer [get_pins {delay_reg_4__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET570} -new_cell_names {U_PTECO_HOLD_BUF570}
insert_buffer [get_pins {delay_reg_26__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET571} -new_cell_names {U_PTECO_HOLD_BUF571}
insert_buffer [get_pins {delay_reg_40__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET572} -new_cell_names {U_PTECO_HOLD_BUF572}
insert_buffer [get_pins {delay_reg_54__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET573} -new_cell_names {U_PTECO_HOLD_BUF573}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_x_delay_reg_15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET574} -new_cell_names {U_PTECO_HOLD_BUF574}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_37__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET575} -new_cell_names {U_PTECO_HOLD_BUF575}
insert_buffer [get_pins {delay_reg_41__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET576} -new_cell_names {U_PTECO_HOLD_BUF576}
insert_buffer [get_pins {delay_reg_55__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET577} -new_cell_names {U_PTECO_HOLD_BUF577}
insert_buffer [get_pins {delay_reg_55__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET578} -new_cell_names {U_PTECO_HOLD_BUF578}
insert_buffer [get_pins {delay_reg_12__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET579} -new_cell_names {U_PTECO_HOLD_BUF579}
insert_buffer [get_pins {delay_reg_43__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET580} -new_cell_names {U_PTECO_HOLD_BUF580}
insert_buffer [get_pins {delay_reg_5__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET581} -new_cell_names {U_PTECO_HOLD_BUF581}
insert_buffer [get_pins {delay_reg_42__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET582} -new_cell_names {U_PTECO_HOLD_BUF582}
insert_buffer [get_pins {delay_reg_18__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET583} -new_cell_names {U_PTECO_HOLD_BUF583}
insert_buffer [get_pins {delay_reg_46__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET584} -new_cell_names {U_PTECO_HOLD_BUF584}
insert_buffer [get_pins {delay_reg_44__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET585} -new_cell_names {U_PTECO_HOLD_BUF585}
insert_buffer [get_pins {delay_reg_41__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET586} -new_cell_names {U_PTECO_HOLD_BUF586}
insert_buffer [get_pins {delay_reg_10__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET587} -new_cell_names {U_PTECO_HOLD_BUF587}
insert_buffer [get_pins {delay_reg_25__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET588} -new_cell_names {U_PTECO_HOLD_BUF588}
insert_buffer [get_pins {delay_reg_31__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET589} -new_cell_names {U_PTECO_HOLD_BUF589}
insert_buffer [get_pins {delay_reg_52__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET590} -new_cell_names {U_PTECO_HOLD_BUF590}
insert_buffer [get_pins {delay_reg_28__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET591} -new_cell_names {U_PTECO_HOLD_BUF591}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int2_reg_9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET592} -new_cell_names {U_PTECO_HOLD_BUF592}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_52__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET593} -new_cell_names {U_PTECO_HOLD_BUF593}
insert_buffer [get_pins {delay_reg_53__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET594} -new_cell_names {U_PTECO_HOLD_BUF594}
insert_buffer [get_pins {delay_reg_55__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET595} -new_cell_names {U_PTECO_HOLD_BUF595}
insert_buffer [get_pins {delay_reg_16__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET596} -new_cell_names {U_PTECO_HOLD_BUF596}
insert_buffer [get_pins {delay_reg_37__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET597} -new_cell_names {U_PTECO_HOLD_BUF597}
insert_buffer [get_pins {delay_reg_13__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET598} -new_cell_names {U_PTECO_HOLD_BUF598}
insert_buffer [get_pins {delay_reg_47__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET599} -new_cell_names {U_PTECO_HOLD_BUF599}
insert_buffer [get_pins {delay_reg_12__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET600} -new_cell_names {U_PTECO_HOLD_BUF600}
insert_buffer [get_pins {delay_reg_57__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET601} -new_cell_names {U_PTECO_HOLD_BUF601}
insert_buffer [get_pins {delay_reg_56__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET602} -new_cell_names {U_PTECO_HOLD_BUF602}
insert_buffer [get_pins {delay_reg_53__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET603} -new_cell_names {U_PTECO_HOLD_BUF603}
insert_buffer [get_pins {delay_reg_15__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET604} -new_cell_names {U_PTECO_HOLD_BUF604}
insert_buffer [get_pins {delay_reg_9__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET605} -new_cell_names {U_PTECO_HOLD_BUF605}
insert_buffer [get_pins {delay_reg_8__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET606} -new_cell_names {U_PTECO_HOLD_BUF606}
insert_buffer [get_pins {delay_reg_51__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET607} -new_cell_names {U_PTECO_HOLD_BUF607}
insert_buffer [get_pins {delay_reg_22__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET608} -new_cell_names {U_PTECO_HOLD_BUF608}
insert_buffer [get_pins {delay_reg_2__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET609} -new_cell_names {U_PTECO_HOLD_BUF609}
insert_buffer [get_pins {delay_reg_54__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET610} -new_cell_names {U_PTECO_HOLD_BUF610}
insert_buffer [get_pins {delay_reg_36__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET611} -new_cell_names {U_PTECO_HOLD_BUF611}
insert_buffer [get_pins {delay_reg_25__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET612} -new_cell_names {U_PTECO_HOLD_BUF612}
insert_buffer [get_pins {delay_reg_19__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET613} -new_cell_names {U_PTECO_HOLD_BUF613}
insert_buffer [get_pins {delay_reg_33__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET614} -new_cell_names {U_PTECO_HOLD_BUF614}
insert_buffer [get_pins {delay_reg_19__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET615} -new_cell_names {U_PTECO_HOLD_BUF615}
insert_buffer [get_pins {delay_reg_14__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET616} -new_cell_names {U_PTECO_HOLD_BUF616}
insert_buffer [get_pins {delay_reg_41__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET617} -new_cell_names {U_PTECO_HOLD_BUF617}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_y_out_reg_13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET618} -new_cell_names {U_PTECO_HOLD_BUF618}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_33__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET619} -new_cell_names {U_PTECO_HOLD_BUF619}
insert_buffer [get_pins {delay_reg_22__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET620} -new_cell_names {U_PTECO_HOLD_BUF620}
insert_buffer [get_pins {delay_reg_19__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET621} -new_cell_names {U_PTECO_HOLD_BUF621}
insert_buffer [get_pins {delay_reg_34__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET622} -new_cell_names {U_PTECO_HOLD_BUF622}
insert_buffer [get_pins {delay_reg_33__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET623} -new_cell_names {U_PTECO_HOLD_BUF623}
insert_buffer [get_pins {delay_reg_16__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET624} -new_cell_names {U_PTECO_HOLD_BUF624}
insert_buffer [get_pins {delay_reg_35__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET625} -new_cell_names {U_PTECO_HOLD_BUF625}
insert_buffer [get_pins {delay_reg_18__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET626} -new_cell_names {U_PTECO_HOLD_BUF626}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_y_out_reg_6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET627} -new_cell_names {U_PTECO_HOLD_BUF627}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_63__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET628} -new_cell_names {U_PTECO_HOLD_BUF628}
insert_buffer [get_pins {delay_reg_19__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET629} -new_cell_names {U_PTECO_HOLD_BUF629}
insert_buffer [get_pins {delay_reg_3__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET630} -new_cell_names {U_PTECO_HOLD_BUF630}
insert_buffer [get_pins {delay_reg_1__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET631} -new_cell_names {U_PTECO_HOLD_BUF631}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_y_out_reg_1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET632} -new_cell_names {U_PTECO_HOLD_BUF632}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_38__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET633} -new_cell_names {U_PTECO_HOLD_BUF633}
insert_buffer [get_pins {delay_reg_29__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET634} -new_cell_names {U_PTECO_HOLD_BUF634}
insert_buffer [get_pins {delay_reg_3__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET635} -new_cell_names {U_PTECO_HOLD_BUF635}
insert_buffer [get_pins {delay_reg_60__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET636} -new_cell_names {U_PTECO_HOLD_BUF636}
insert_buffer [get_pins {delay_reg_16__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET637} -new_cell_names {U_PTECO_HOLD_BUF637}
insert_buffer [get_pins {delay_reg_18__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET638} -new_cell_names {U_PTECO_HOLD_BUF638}
insert_buffer [get_pins {delay_reg_40__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET639} -new_cell_names {U_PTECO_HOLD_BUF639}
insert_buffer [get_pins {delay_reg_30__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET640} -new_cell_names {U_PTECO_HOLD_BUF640}
insert_buffer [get_pins {delay_reg_54__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET641} -new_cell_names {U_PTECO_HOLD_BUF641}
insert_buffer [get_pins {delay_reg_23__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET642} -new_cell_names {U_PTECO_HOLD_BUF642}
insert_buffer [get_pins {delay_reg_11__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET643} -new_cell_names {U_PTECO_HOLD_BUF643}
insert_buffer [get_pins {delay_reg_18__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET644} -new_cell_names {U_PTECO_HOLD_BUF644}
insert_buffer [get_pins {delay_reg_11__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET645} -new_cell_names {U_PTECO_HOLD_BUF645}
insert_buffer [get_pins {y_out_reg_17_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET646} -new_cell_names {U_PTECO_HOLD_BUF646}
insert_buffer [get_pins {delay_reg_40__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET647} -new_cell_names {U_PTECO_HOLD_BUF647}
insert_buffer [get_pins {delay_reg_40__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET648} -new_cell_names {U_PTECO_HOLD_BUF648}
insert_buffer [get_pins {delay_reg_36__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET649} -new_cell_names {U_PTECO_HOLD_BUF649}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_y_out_reg_12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET650} -new_cell_names {U_PTECO_HOLD_BUF650}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_14__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET651} -new_cell_names {U_PTECO_HOLD_BUF651}
insert_buffer [get_pins {delay_reg_57__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET652} -new_cell_names {U_PTECO_HOLD_BUF652}
insert_buffer [get_pins {delay_reg_44__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET653} -new_cell_names {U_PTECO_HOLD_BUF653}
insert_buffer [get_pins {delay_reg_35__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET654} -new_cell_names {U_PTECO_HOLD_BUF654}
insert_buffer [get_pins {delay_reg_19__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET655} -new_cell_names {U_PTECO_HOLD_BUF655}
insert_buffer [get_pins {delay_reg_26__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET656} -new_cell_names {U_PTECO_HOLD_BUF656}
insert_buffer [get_pins {delay_reg_44__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET657} -new_cell_names {U_PTECO_HOLD_BUF657}
insert_buffer [get_pins {delay_reg_28__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET658} -new_cell_names {U_PTECO_HOLD_BUF658}
insert_buffer [get_pins {delay_reg_10__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET659} -new_cell_names {U_PTECO_HOLD_BUF659}
insert_buffer [get_pins {delay_reg_32__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET660} -new_cell_names {U_PTECO_HOLD_BUF660}
insert_buffer [get_pins {delay_reg_60__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET661} -new_cell_names {U_PTECO_HOLD_BUF661}
insert_buffer [get_pins {delay_reg_19__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET662} -new_cell_names {U_PTECO_HOLD_BUF662}
insert_buffer [get_pins {delay_reg_36__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET663} -new_cell_names {U_PTECO_HOLD_BUF663}
insert_buffer [get_pins {delay_reg_23__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET664} -new_cell_names {U_PTECO_HOLD_BUF664}
insert_buffer [get_pins {delay_reg_21__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET665} -new_cell_names {U_PTECO_HOLD_BUF665}
insert_buffer [get_pins {delay_reg_20__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET666} -new_cell_names {U_PTECO_HOLD_BUF666}
insert_buffer [get_pins {delay_reg_5__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET667} -new_cell_names {U_PTECO_HOLD_BUF667}
insert_buffer [get_pins {delay_reg_14__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET668} -new_cell_names {U_PTECO_HOLD_BUF668}
insert_buffer [get_pins {delay_reg_17__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET669} -new_cell_names {U_PTECO_HOLD_BUF669}
insert_buffer [get_pins {delay_reg_44__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET670} -new_cell_names {U_PTECO_HOLD_BUF670}
insert_buffer [get_pins {delay_reg_38__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET671} -new_cell_names {U_PTECO_HOLD_BUF671}
insert_buffer [get_pins {delay_reg_20__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET672} -new_cell_names {U_PTECO_HOLD_BUF672}
insert_buffer [get_pins {delay_reg_24__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET673} -new_cell_names {U_PTECO_HOLD_BUF673}
insert_buffer [get_pins {delay_reg_20__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET674} -new_cell_names {U_PTECO_HOLD_BUF674}
insert_buffer [get_pins {delay_reg_35__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET675} -new_cell_names {U_PTECO_HOLD_BUF675}
insert_buffer [get_pins {delay_reg_26__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET676} -new_cell_names {U_PTECO_HOLD_BUF676}
insert_buffer [get_pins {delay_reg_58__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET677} -new_cell_names {U_PTECO_HOLD_BUF677}
insert_buffer [get_pins {delay_reg_50__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET678} -new_cell_names {U_PTECO_HOLD_BUF678}
insert_buffer [get_pins {delay_reg_9__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET679} -new_cell_names {U_PTECO_HOLD_BUF679}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_y_out_reg_13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET680} -new_cell_names {U_PTECO_HOLD_BUF680}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_21__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET681} -new_cell_names {U_PTECO_HOLD_BUF681}
insert_buffer [get_pins {delay_reg_28__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET682} -new_cell_names {U_PTECO_HOLD_BUF682}
insert_buffer [get_pins {delay_reg_35__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET683} -new_cell_names {U_PTECO_HOLD_BUF683}
insert_buffer [get_pins {delay_reg_8__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET684} -new_cell_names {U_PTECO_HOLD_BUF684}
insert_buffer [get_pins {delay_reg_22__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET685} -new_cell_names {U_PTECO_HOLD_BUF685}
insert_buffer [get_pins {delay_reg_22__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET686} -new_cell_names {U_PTECO_HOLD_BUF686}
insert_buffer [get_pins {delay_reg_27__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET687} -new_cell_names {U_PTECO_HOLD_BUF687}
insert_buffer [get_pins {delay_reg_48__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET688} -new_cell_names {U_PTECO_HOLD_BUF688}
insert_buffer [get_pins {delay_reg_45__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET689} -new_cell_names {U_PTECO_HOLD_BUF689}
insert_buffer [get_pins {delay_reg_42__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET690} -new_cell_names {U_PTECO_HOLD_BUF690}
insert_buffer [get_pins {delay_reg_53__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET691} -new_cell_names {U_PTECO_HOLD_BUF691}
insert_buffer [get_pins {delay_reg_23__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET692} -new_cell_names {U_PTECO_HOLD_BUF692}
insert_buffer [get_pins {delay_reg_54__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET693} -new_cell_names {U_PTECO_HOLD_BUF693}
insert_buffer [get_pins {delay_reg_50__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET694} -new_cell_names {U_PTECO_HOLD_BUF694}
insert_buffer [get_pins {delay_reg_43__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET695} -new_cell_names {U_PTECO_HOLD_BUF695}
insert_buffer [get_pins {delay_reg_44__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET696} -new_cell_names {U_PTECO_HOLD_BUF696}
insert_buffer [get_pins {delay_reg_40__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET697} -new_cell_names {U_PTECO_HOLD_BUF697}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int3_reg_15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET698} -new_cell_names {U_PTECO_HOLD_BUF698}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_63__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET699} -new_cell_names {U_PTECO_HOLD_BUF699}
insert_buffer [get_pins {delay_reg_45__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET700} -new_cell_names {U_PTECO_HOLD_BUF700}
insert_buffer [get_pins {delay_reg_37__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET701} -new_cell_names {U_PTECO_HOLD_BUF701}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int2_reg_5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET702} -new_cell_names {U_PTECO_HOLD_BUF702}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_38__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET703} -new_cell_names {U_PTECO_HOLD_BUF703}
insert_buffer [get_pins {delay_reg_11__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET704} -new_cell_names {U_PTECO_HOLD_BUF704}
insert_buffer [get_pins {delay_reg_41__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET705} -new_cell_names {U_PTECO_HOLD_BUF705}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_y_out_reg_12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET706} -new_cell_names {U_PTECO_HOLD_BUF706}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_27__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET707} -new_cell_names {U_PTECO_HOLD_BUF707}
insert_buffer [get_pins {delay_reg_45__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET708} -new_cell_names {U_PTECO_HOLD_BUF708}
insert_buffer [get_pins {delay_reg_59__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET709} -new_cell_names {U_PTECO_HOLD_BUF709}
insert_buffer [get_pins {delay_reg_25__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET710} -new_cell_names {U_PTECO_HOLD_BUF710}
insert_buffer [get_pins {delay_reg_24__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET711} -new_cell_names {U_PTECO_HOLD_BUF711}
insert_buffer [get_pins {delay_reg_43__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET712} -new_cell_names {U_PTECO_HOLD_BUF712}
insert_buffer [get_pins {delay_reg_22__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET713} -new_cell_names {U_PTECO_HOLD_BUF713}
insert_buffer [get_pins {delay_reg_58__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET714} -new_cell_names {U_PTECO_HOLD_BUF714}
insert_buffer [get_pins {delay_reg_26__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET715} -new_cell_names {U_PTECO_HOLD_BUF715}
insert_buffer [get_pins {delay_reg_13__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET716} -new_cell_names {U_PTECO_HOLD_BUF716}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_y_out_reg_6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET717} -new_cell_names {U_PTECO_HOLD_BUF717}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_28__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET718} -new_cell_names {U_PTECO_HOLD_BUF718}
insert_buffer [get_pins {delay_reg_47__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET719} -new_cell_names {U_PTECO_HOLD_BUF719}
insert_buffer [get_pins {delay_reg_29__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET720} -new_cell_names {U_PTECO_HOLD_BUF720}
insert_buffer [get_pins {delay_reg_24__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET721} -new_cell_names {U_PTECO_HOLD_BUF721}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int4_reg_3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET722} -new_cell_names {U_PTECO_HOLD_BUF722}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_57__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET723} -new_cell_names {U_PTECO_HOLD_BUF723}
insert_buffer [get_pins {delay_reg_26__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET724} -new_cell_names {U_PTECO_HOLD_BUF724}
insert_buffer [get_pins {valid_out_reg/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET725} -new_cell_names {U_PTECO_HOLD_BUF725}
insert_buffer [get_pins {delay_reg_23__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET726} -new_cell_names {U_PTECO_HOLD_BUF726}
insert_buffer [get_pins {delay_reg_35__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET727} -new_cell_names {U_PTECO_HOLD_BUF727}
insert_buffer [get_pins {delay_reg_28__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET728} -new_cell_names {U_PTECO_HOLD_BUF728}
insert_buffer [get_pins {delay_reg_32__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET729} -new_cell_names {U_PTECO_HOLD_BUF729}
insert_buffer [get_pins {delay_reg_28__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET730} -new_cell_names {U_PTECO_HOLD_BUF730}
insert_buffer [get_pins {delay_reg_12__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET731} -new_cell_names {U_PTECO_HOLD_BUF731}
insert_buffer [get_pins {delay_reg_50__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET732} -new_cell_names {U_PTECO_HOLD_BUF732}
insert_buffer [get_pins {delay_reg_32__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET733} -new_cell_names {U_PTECO_HOLD_BUF733}
insert_buffer [get_pins {delay_reg_11__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET734} -new_cell_names {U_PTECO_HOLD_BUF734}
insert_buffer [get_pins {delay_reg_59__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET735} -new_cell_names {U_PTECO_HOLD_BUF735}
insert_buffer [get_pins {delay_reg_21__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET736} -new_cell_names {U_PTECO_HOLD_BUF736}
insert_buffer [get_pins {delay_reg_46__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET737} -new_cell_names {U_PTECO_HOLD_BUF737}
insert_buffer [get_pins {delay_reg_50__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET738} -new_cell_names {U_PTECO_HOLD_BUF738}
insert_buffer [get_pins {delay_reg_28__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET739} -new_cell_names {U_PTECO_HOLD_BUF739}
insert_buffer [get_pins {delay_reg_57__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET740} -new_cell_names {U_PTECO_HOLD_BUF740}
insert_buffer [get_pins {delay_reg_40__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET741} -new_cell_names {U_PTECO_HOLD_BUF741}
insert_buffer [get_pins {delay_reg_27__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET742} -new_cell_names {U_PTECO_HOLD_BUF742}
insert_buffer [get_pins {delay_reg_39__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET743} -new_cell_names {U_PTECO_HOLD_BUF743}
insert_buffer [get_pins {delay_reg_28__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET744} -new_cell_names {U_PTECO_HOLD_BUF744}
insert_buffer [get_pins {delay_reg_48__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET745} -new_cell_names {U_PTECO_HOLD_BUF745}
insert_buffer [get_pins {delay_reg_7__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET746} -new_cell_names {U_PTECO_HOLD_BUF746}
insert_buffer [get_pins {delay_reg_42__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET747} -new_cell_names {U_PTECO_HOLD_BUF747}
insert_buffer [get_pins {delay_reg_32__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET748} -new_cell_names {U_PTECO_HOLD_BUF748}
insert_buffer [get_pins {delay_reg_18__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET749} -new_cell_names {U_PTECO_HOLD_BUF749}
insert_buffer [get_pins {delay_reg_23__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET750} -new_cell_names {U_PTECO_HOLD_BUF750}
insert_buffer [get_pins {delay_reg_48__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET751} -new_cell_names {U_PTECO_HOLD_BUF751}
insert_buffer [get_pins {delay_reg_18__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET752} -new_cell_names {U_PTECO_HOLD_BUF752}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_y_out_reg_15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET753} -new_cell_names {U_PTECO_HOLD_BUF753}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_13__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET754} -new_cell_names {U_PTECO_HOLD_BUF754}
insert_buffer [get_pins {delay_reg_17__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET755} -new_cell_names {U_PTECO_HOLD_BUF755}
insert_buffer [get_pins {delay_reg_24__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET756} -new_cell_names {U_PTECO_HOLD_BUF756}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_x_delay_reg_17_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET757} -new_cell_names {U_PTECO_HOLD_BUF757}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_7__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET758} -new_cell_names {U_PTECO_HOLD_BUF758}
insert_buffer [get_pins {delay_reg_53__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET759} -new_cell_names {U_PTECO_HOLD_BUF759}
insert_buffer [get_pins {delay_reg_15__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET760} -new_cell_names {U_PTECO_HOLD_BUF760}
insert_buffer [get_pins {delay_reg_34__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET761} -new_cell_names {U_PTECO_HOLD_BUF761}
insert_buffer [get_pins {delay_reg_5__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET762} -new_cell_names {U_PTECO_HOLD_BUF762}
insert_buffer [get_pins {delay_reg_26__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET763} -new_cell_names {U_PTECO_HOLD_BUF763}
insert_buffer [get_pins {delay_reg_27__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET764} -new_cell_names {U_PTECO_HOLD_BUF764}
insert_buffer [get_pins {delay_reg_53__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET765} -new_cell_names {U_PTECO_HOLD_BUF765}
insert_buffer [get_pins {delay_reg_62__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET766} -new_cell_names {U_PTECO_HOLD_BUF766}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_x_delay_reg_8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET767} -new_cell_names {U_PTECO_HOLD_BUF767}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_15__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET768} -new_cell_names {U_PTECO_HOLD_BUF768}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_x_delay_reg_13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET769} -new_cell_names {U_PTECO_HOLD_BUF769}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_48__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET770} -new_cell_names {U_PTECO_HOLD_BUF770}
insert_buffer [get_pins {delay_reg_42__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET771} -new_cell_names {U_PTECO_HOLD_BUF771}
insert_buffer [get_pins {delay_reg_9__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET772} -new_cell_names {U_PTECO_HOLD_BUF772}
insert_buffer [get_pins {delay_reg_29__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET773} -new_cell_names {U_PTECO_HOLD_BUF773}
insert_buffer [get_pins {delay_reg_10__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET774} -new_cell_names {U_PTECO_HOLD_BUF774}
insert_buffer [get_pins {delay_reg_1__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET775} -new_cell_names {U_PTECO_HOLD_BUF775}
insert_buffer [get_pins {delay_reg_26__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET776} -new_cell_names {U_PTECO_HOLD_BUF776}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_x_delay_reg_16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET777} -new_cell_names {U_PTECO_HOLD_BUF777}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_26__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET778} -new_cell_names {U_PTECO_HOLD_BUF778}
insert_buffer [get_pins {delay_reg_47__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET779} -new_cell_names {U_PTECO_HOLD_BUF779}
insert_buffer [get_pins {delay_reg_33__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET780} -new_cell_names {U_PTECO_HOLD_BUF780}
insert_buffer [get_pins {delay_reg_24__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET781} -new_cell_names {U_PTECO_HOLD_BUF781}
insert_buffer [get_pins {delay_reg_42__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET782} -new_cell_names {U_PTECO_HOLD_BUF782}
insert_buffer [get_pins {delay_reg_49__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET783} -new_cell_names {U_PTECO_HOLD_BUF783}
insert_buffer [get_pins {delay_reg_17__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET784} -new_cell_names {U_PTECO_HOLD_BUF784}
insert_buffer [get_pins {delay_reg_59__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET785} -new_cell_names {U_PTECO_HOLD_BUF785}
insert_buffer [get_pins {delay_reg_38__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET786} -new_cell_names {U_PTECO_HOLD_BUF786}
insert_buffer [get_pins {delay_reg_20__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET787} -new_cell_names {U_PTECO_HOLD_BUF787}
insert_buffer [get_pins {delay_reg_23__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET788} -new_cell_names {U_PTECO_HOLD_BUF788}
insert_buffer [get_pins {delay_reg_20__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET789} -new_cell_names {U_PTECO_HOLD_BUF789}
insert_buffer [get_pins {delay_reg_14__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET790} -new_cell_names {U_PTECO_HOLD_BUF790}
insert_buffer [get_pins {delay_reg_15__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET791} -new_cell_names {U_PTECO_HOLD_BUF791}
insert_buffer [get_pins {delay_reg_44__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET792} -new_cell_names {U_PTECO_HOLD_BUF792}
insert_buffer [get_pins {delay_reg_51__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET793} -new_cell_names {U_PTECO_HOLD_BUF793}
insert_buffer [get_pins {delay_reg_62__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET794} -new_cell_names {U_PTECO_HOLD_BUF794}
insert_buffer [get_pins {delay_reg_18__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET795} -new_cell_names {U_PTECO_HOLD_BUF795}
insert_buffer [get_pins {delay_reg_58__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET796} -new_cell_names {U_PTECO_HOLD_BUF796}
insert_buffer [get_pins {delay_reg_60__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET797} -new_cell_names {U_PTECO_HOLD_BUF797}
insert_buffer [get_pins {delay_reg_28__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET798} -new_cell_names {U_PTECO_HOLD_BUF798}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_y_out_reg_9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET799} -new_cell_names {U_PTECO_HOLD_BUF799}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_13__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET800} -new_cell_names {U_PTECO_HOLD_BUF800}
insert_buffer [get_pins {delay_reg_38__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET801} -new_cell_names {U_PTECO_HOLD_BUF801}
insert_buffer [get_pins {delay_reg_48__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET802} -new_cell_names {U_PTECO_HOLD_BUF802}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_y_out_reg_11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET803} -new_cell_names {U_PTECO_HOLD_BUF803}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_52__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET804} -new_cell_names {U_PTECO_HOLD_BUF804}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int3_reg_12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET805} -new_cell_names {U_PTECO_HOLD_BUF805}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_17__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET806} -new_cell_names {U_PTECO_HOLD_BUF806}
insert_buffer [get_pins {delay_reg_10__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET807} -new_cell_names {U_PTECO_HOLD_BUF807}
insert_buffer [get_pins {delay_reg_62__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET808} -new_cell_names {U_PTECO_HOLD_BUF808}
insert_buffer [get_pins {delay_reg_22__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET809} -new_cell_names {U_PTECO_HOLD_BUF809}
insert_buffer [get_pins {delay_reg_14__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET810} -new_cell_names {U_PTECO_HOLD_BUF810}
insert_buffer [get_pins {delay_reg_4__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET811} -new_cell_names {U_PTECO_HOLD_BUF811}
insert_buffer [get_pins {delay_reg_46__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET812} -new_cell_names {U_PTECO_HOLD_BUF812}
insert_buffer [get_pins {delay_reg_14__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET813} -new_cell_names {U_PTECO_HOLD_BUF813}
insert_buffer [get_pins {delay_reg_23__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET814} -new_cell_names {U_PTECO_HOLD_BUF814}
insert_buffer [get_pins {delay_reg_14__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET815} -new_cell_names {U_PTECO_HOLD_BUF815}
insert_buffer [get_pins {delay_reg_38__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET816} -new_cell_names {U_PTECO_HOLD_BUF816}
insert_buffer [get_pins {delay_reg_15__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET817} -new_cell_names {U_PTECO_HOLD_BUF817}
insert_buffer [get_pins {delay_reg_29__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET818} -new_cell_names {U_PTECO_HOLD_BUF818}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_y_out_reg_11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET819} -new_cell_names {U_PTECO_HOLD_BUF819}
insert_buffer [get_pins {u_cic_u_combs_u_comb1_x_delay_reg_7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET820} -new_cell_names {U_PTECO_HOLD_BUF820}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_25__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET821} -new_cell_names {U_PTECO_HOLD_BUF821}
insert_buffer [get_pins {delay_reg_16__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET822} -new_cell_names {U_PTECO_HOLD_BUF822}
insert_buffer [get_pins {delay_reg_34__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET823} -new_cell_names {U_PTECO_HOLD_BUF823}
insert_buffer [get_pins {delay_reg_62__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET824} -new_cell_names {U_PTECO_HOLD_BUF824}
insert_buffer [get_pins {delay_reg_25__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET825} -new_cell_names {U_PTECO_HOLD_BUF825}
insert_buffer [get_pins {delay_reg_13__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET826} -new_cell_names {U_PTECO_HOLD_BUF826}
insert_buffer [get_pins {delay_reg_36__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET827} -new_cell_names {U_PTECO_HOLD_BUF827}
insert_buffer [get_pins {delay_reg_48__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET828} -new_cell_names {U_PTECO_HOLD_BUF828}
insert_buffer [get_pins {delay_reg_40__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET829} -new_cell_names {U_PTECO_HOLD_BUF829}
insert_buffer [get_pins {delay_reg_35__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET830} -new_cell_names {U_PTECO_HOLD_BUF830}
insert_buffer [get_pins {delay_reg_49__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET831} -new_cell_names {U_PTECO_HOLD_BUF831}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_y_out_reg_10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET832} -new_cell_names {U_PTECO_HOLD_BUF832}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_46__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET833} -new_cell_names {U_PTECO_HOLD_BUF833}
insert_buffer [get_pins {delay_reg_18__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET834} -new_cell_names {U_PTECO_HOLD_BUF834}
insert_buffer [get_pins {delay_reg_16__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET835} -new_cell_names {U_PTECO_HOLD_BUF835}
insert_buffer [get_pins {delay_reg_17__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET836} -new_cell_names {U_PTECO_HOLD_BUF836}
insert_buffer [get_pins {delay_reg_34__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET837} -new_cell_names {U_PTECO_HOLD_BUF837}
insert_buffer [get_pins {delay_reg_26__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET838} -new_cell_names {U_PTECO_HOLD_BUF838}
insert_buffer [get_pins {delay_reg_16__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET839} -new_cell_names {U_PTECO_HOLD_BUF839}
insert_buffer [get_pins {delay_reg_30__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET840} -new_cell_names {U_PTECO_HOLD_BUF840}
insert_buffer [get_pins {delay_reg_44__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET841} -new_cell_names {U_PTECO_HOLD_BUF841}
insert_buffer [get_pins {delay_reg_34__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET842} -new_cell_names {U_PTECO_HOLD_BUF842}
insert_buffer [get_pins {delay_reg_47__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET843} -new_cell_names {U_PTECO_HOLD_BUF843}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_y_out_reg_7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET844} -new_cell_names {U_PTECO_HOLD_BUF844}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_5__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET845} -new_cell_names {U_PTECO_HOLD_BUF845}
insert_buffer [get_pins {delay_reg_13__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET846} -new_cell_names {U_PTECO_HOLD_BUF846}
insert_buffer [get_pins {delay_reg_38__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET847} -new_cell_names {U_PTECO_HOLD_BUF847}
insert_buffer [get_pins {delay_reg_20__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET848} -new_cell_names {U_PTECO_HOLD_BUF848}
insert_buffer [get_pins {delay_reg_41__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET849} -new_cell_names {U_PTECO_HOLD_BUF849}
insert_buffer [get_pins {delay_reg_56__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET850} -new_cell_names {U_PTECO_HOLD_BUF850}
insert_buffer [get_pins {delay_reg_49__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET851} -new_cell_names {U_PTECO_HOLD_BUF851}
insert_buffer [get_pins {delay_reg_20__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET852} -new_cell_names {U_PTECO_HOLD_BUF852}
insert_buffer [get_pins {delay_reg_30__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET853} -new_cell_names {U_PTECO_HOLD_BUF853}
insert_buffer [get_pins {delay_reg_38__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET854} -new_cell_names {U_PTECO_HOLD_BUF854}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int4_reg_2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET855} -new_cell_names {U_PTECO_HOLD_BUF855}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_8__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET856} -new_cell_names {U_PTECO_HOLD_BUF856}
insert_buffer [get_pins {delay_reg_18__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET857} -new_cell_names {U_PTECO_HOLD_BUF857}
insert_buffer [get_pins {delay_reg_16__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET858} -new_cell_names {U_PTECO_HOLD_BUF858}
insert_buffer [get_pins {delay_reg_43__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET859} -new_cell_names {U_PTECO_HOLD_BUF859}
insert_buffer [get_pins {delay_reg_36__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET860} -new_cell_names {U_PTECO_HOLD_BUF860}
insert_buffer [get_pins {delay_reg_21__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET861} -new_cell_names {U_PTECO_HOLD_BUF861}
insert_buffer [get_pins {delay_reg_0__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET862} -new_cell_names {U_PTECO_HOLD_BUF862}
insert_buffer [get_pins {delay_reg_27__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET863} -new_cell_names {U_PTECO_HOLD_BUF863}
insert_buffer [get_pins {delay_reg_8__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET864} -new_cell_names {U_PTECO_HOLD_BUF864}
insert_buffer [get_pins {delay_reg_31__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET865} -new_cell_names {U_PTECO_HOLD_BUF865}
insert_buffer [get_pins {delay_reg_17__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET866} -new_cell_names {U_PTECO_HOLD_BUF866}
insert_buffer [get_pins {delay_reg_27__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET867} -new_cell_names {U_PTECO_HOLD_BUF867}
insert_buffer [get_pins {delay_reg_45__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET868} -new_cell_names {U_PTECO_HOLD_BUF868}
insert_buffer [get_pins {delay_reg_25__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET869} -new_cell_names {U_PTECO_HOLD_BUF869}
insert_buffer [get_pins {delay_reg_14__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET870} -new_cell_names {U_PTECO_HOLD_BUF870}
insert_buffer [get_pins {delay_reg_24__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET871} -new_cell_names {U_PTECO_HOLD_BUF871}
insert_buffer [get_pins {delay_reg_21__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET872} -new_cell_names {U_PTECO_HOLD_BUF872}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int3_reg_8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET873} -new_cell_names {U_PTECO_HOLD_BUF873}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_38__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET874} -new_cell_names {U_PTECO_HOLD_BUF874}
insert_buffer [get_pins {delay_reg_57__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET875} -new_cell_names {U_PTECO_HOLD_BUF875}
insert_buffer [get_pins {delay_reg_5__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET876} -new_cell_names {U_PTECO_HOLD_BUF876}
insert_buffer [get_pins {delay_reg_11__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET877} -new_cell_names {U_PTECO_HOLD_BUF877}
insert_buffer [get_pins {delay_reg_24__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET878} -new_cell_names {U_PTECO_HOLD_BUF878}
insert_buffer [get_pins {delay_reg_19__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET879} -new_cell_names {U_PTECO_HOLD_BUF879}
insert_buffer [get_pins {delay_reg_7__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET880} -new_cell_names {U_PTECO_HOLD_BUF880}
insert_buffer [get_pins {delay_reg_49__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET881} -new_cell_names {U_PTECO_HOLD_BUF881}
insert_buffer [get_pins {delay_reg_14__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET882} -new_cell_names {U_PTECO_HOLD_BUF882}
insert_buffer [get_pins {delay_reg_27__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET883} -new_cell_names {U_PTECO_HOLD_BUF883}
insert_buffer [get_pins {delay_reg_28__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET884} -new_cell_names {U_PTECO_HOLD_BUF884}
insert_buffer [get_pins {delay_reg_35__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET885} -new_cell_names {U_PTECO_HOLD_BUF885}
insert_buffer [get_pins {delay_reg_39__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET886} -new_cell_names {U_PTECO_HOLD_BUF886}
insert_buffer [get_pins {delay_reg_13__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET887} -new_cell_names {U_PTECO_HOLD_BUF887}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_y_out_reg_10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET888} -new_cell_names {U_PTECO_HOLD_BUF888}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_39__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET889} -new_cell_names {U_PTECO_HOLD_BUF889}
insert_buffer [get_pins {delay_reg_50__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET890} -new_cell_names {U_PTECO_HOLD_BUF890}
insert_buffer [get_pins {delay_reg_34__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET891} -new_cell_names {U_PTECO_HOLD_BUF891}
insert_buffer [get_pins {delay_reg_43__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET892} -new_cell_names {U_PTECO_HOLD_BUF892}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_y_out_reg_11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET893} -new_cell_names {U_PTECO_HOLD_BUF893}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_10__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET894} -new_cell_names {U_PTECO_HOLD_BUF894}
insert_buffer [get_pins {delay_reg_58__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET895} -new_cell_names {U_PTECO_HOLD_BUF895}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_y_out_reg_5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET896} -new_cell_names {U_PTECO_HOLD_BUF896}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_42__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET897} -new_cell_names {U_PTECO_HOLD_BUF897}
insert_buffer [get_pins {delay_reg_2__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET898} -new_cell_names {U_PTECO_HOLD_BUF898}
insert_buffer [get_pins {delay_reg_49__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET899} -new_cell_names {U_PTECO_HOLD_BUF899}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_x_delay_reg_10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET900} -new_cell_names {U_PTECO_HOLD_BUF900}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_43__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET901} -new_cell_names {U_PTECO_HOLD_BUF901}
insert_buffer [get_pins {delay_reg_43__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET902} -new_cell_names {U_PTECO_HOLD_BUF902}
insert_buffer [get_pins {delay_reg_30__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET903} -new_cell_names {U_PTECO_HOLD_BUF903}
insert_buffer [get_pins {delay_reg_47__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET904} -new_cell_names {U_PTECO_HOLD_BUF904}
insert_buffer [get_pins {delay_reg_31__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET905} -new_cell_names {U_PTECO_HOLD_BUF905}
insert_buffer [get_pins {delay_reg_12__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET906} -new_cell_names {U_PTECO_HOLD_BUF906}
insert_buffer [get_pins {delay_reg_33__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET907} -new_cell_names {U_PTECO_HOLD_BUF907}
insert_buffer [get_pins {delay_reg_19__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET908} -new_cell_names {U_PTECO_HOLD_BUF908}
insert_buffer [get_pins {delay_reg_46__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET909} -new_cell_names {U_PTECO_HOLD_BUF909}
insert_buffer [get_pins {delay_reg_25__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET910} -new_cell_names {U_PTECO_HOLD_BUF910}
insert_buffer [get_pins {delay_reg_36__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET911} -new_cell_names {U_PTECO_HOLD_BUF911}
insert_buffer [get_pins {delay_reg_37__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET912} -new_cell_names {U_PTECO_HOLD_BUF912}
insert_buffer [get_pins {delay_reg_54__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET913} -new_cell_names {U_PTECO_HOLD_BUF913}
insert_buffer [get_pins {delay_reg_34__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET914} -new_cell_names {U_PTECO_HOLD_BUF914}
insert_buffer [get_pins {delay_reg_52__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET915} -new_cell_names {U_PTECO_HOLD_BUF915}
insert_buffer [get_pins {delay_reg_51__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET916} -new_cell_names {U_PTECO_HOLD_BUF916}
insert_buffer [get_pins {delay_reg_20__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET917} -new_cell_names {U_PTECO_HOLD_BUF917}
insert_buffer [get_pins {delay_reg_19__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET918} -new_cell_names {U_PTECO_HOLD_BUF918}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_x_delay_reg_4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET919} -new_cell_names {U_PTECO_HOLD_BUF919}
insert_buffer [get_pins {u_cic_u_integradores_int4_reg_4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET920} -new_cell_names {U_PTECO_HOLD_BUF920}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_44__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET921} -new_cell_names {U_PTECO_HOLD_BUF921}
insert_buffer [get_pins {delay_reg_29__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET922} -new_cell_names {U_PTECO_HOLD_BUF922}
insert_buffer [get_pins {delay_reg_21__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET923} -new_cell_names {U_PTECO_HOLD_BUF923}
insert_buffer [get_pins {delay_reg_56__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET924} -new_cell_names {U_PTECO_HOLD_BUF924}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_x_delay_reg_5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET925} -new_cell_names {U_PTECO_HOLD_BUF925}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_39__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET926} -new_cell_names {U_PTECO_HOLD_BUF926}
insert_buffer [get_pins {delay_reg_48__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET927} -new_cell_names {U_PTECO_HOLD_BUF927}
insert_buffer [get_pins {delay_reg_41__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET928} -new_cell_names {U_PTECO_HOLD_BUF928}
insert_buffer [get_pins {delay_reg_61__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET929} -new_cell_names {U_PTECO_HOLD_BUF929}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_x_delay_reg_4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET930} -new_cell_names {U_PTECO_HOLD_BUF930}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_13__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET931} -new_cell_names {U_PTECO_HOLD_BUF931}
insert_buffer [get_pins {delay_reg_46__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET932} -new_cell_names {U_PTECO_HOLD_BUF932}
insert_buffer [get_pins {delay_reg_29__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET933} -new_cell_names {U_PTECO_HOLD_BUF933}
insert_buffer [get_pins {delay_reg_28__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET934} -new_cell_names {U_PTECO_HOLD_BUF934}
insert_buffer [get_pins {delay_reg_24__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET935} -new_cell_names {U_PTECO_HOLD_BUF935}
insert_buffer [get_pins {delay_reg_34__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET936} -new_cell_names {U_PTECO_HOLD_BUF936}
insert_buffer [get_pins {delay_reg_12__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET937} -new_cell_names {U_PTECO_HOLD_BUF937}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_y_out_reg_1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET938} -new_cell_names {U_PTECO_HOLD_BUF938}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_15__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET939} -new_cell_names {U_PTECO_HOLD_BUF939}
insert_buffer [get_pins {delay_reg_37__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET940} -new_cell_names {U_PTECO_HOLD_BUF940}
insert_buffer [get_pins {delay_reg_37__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET941} -new_cell_names {U_PTECO_HOLD_BUF941}
insert_buffer [get_pins {delay_reg_58__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET942} -new_cell_names {U_PTECO_HOLD_BUF942}
insert_buffer [get_pins {delay_reg_23__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET943} -new_cell_names {U_PTECO_HOLD_BUF943}
insert_buffer [get_pins {delay_reg_61__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET944} -new_cell_names {U_PTECO_HOLD_BUF944}
insert_buffer [get_pins {delay_reg_22__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET945} -new_cell_names {U_PTECO_HOLD_BUF945}
insert_buffer [get_pins {delay_reg_26__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET946} -new_cell_names {U_PTECO_HOLD_BUF946}
insert_buffer [get_pins {delay_reg_38__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET947} -new_cell_names {U_PTECO_HOLD_BUF947}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_x_delay_reg_15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET948} -new_cell_names {U_PTECO_HOLD_BUF948}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_43__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET949} -new_cell_names {U_PTECO_HOLD_BUF949}
insert_buffer [get_pins {delay_reg_33__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET950} -new_cell_names {U_PTECO_HOLD_BUF950}
insert_buffer [get_pins {delay_reg_45__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET951} -new_cell_names {U_PTECO_HOLD_BUF951}
insert_buffer [get_pins {delay_reg_49__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET952} -new_cell_names {U_PTECO_HOLD_BUF952}
insert_buffer [get_pins {delay_reg_44__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET953} -new_cell_names {U_PTECO_HOLD_BUF953}
insert_buffer [get_pins {delay_reg_4__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET954} -new_cell_names {U_PTECO_HOLD_BUF954}
insert_buffer [get_pins {delay_reg_22__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET955} -new_cell_names {U_PTECO_HOLD_BUF955}
insert_buffer [get_pins {delay_reg_29__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET956} -new_cell_names {U_PTECO_HOLD_BUF956}
insert_buffer [get_pins {delay_reg_47__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET957} -new_cell_names {U_PTECO_HOLD_BUF957}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int3_reg_9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET958} -new_cell_names {U_PTECO_HOLD_BUF958}
insert_buffer [get_pins {u_cic_u_combs_u_comb2_y_out_reg_3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET959} -new_cell_names {U_PTECO_HOLD_BUF959}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_30__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET960} -new_cell_names {U_PTECO_HOLD_BUF960}
insert_buffer [get_pins {delay_reg_39__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET961} -new_cell_names {U_PTECO_HOLD_BUF961}
insert_buffer [get_pins {delay_reg_26__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET962} -new_cell_names {U_PTECO_HOLD_BUF962}
insert_buffer [get_pins {delay_reg_19__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET963} -new_cell_names {U_PTECO_HOLD_BUF963}
insert_buffer [get_pins {delay_reg_17__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET964} -new_cell_names {U_PTECO_HOLD_BUF964}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_x_delay_reg_4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET965} -new_cell_names {U_PTECO_HOLD_BUF965}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_27__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET966} -new_cell_names {U_PTECO_HOLD_BUF966}
insert_buffer [get_pins {delay_reg_42__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET967} -new_cell_names {U_PTECO_HOLD_BUF967}
insert_buffer [get_pins {delay_reg_44__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET968} -new_cell_names {U_PTECO_HOLD_BUF968}
insert_buffer [get_pins {delay_reg_14__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET969} -new_cell_names {U_PTECO_HOLD_BUF969}
insert_buffer [get_pins {delay_reg_36__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET970} -new_cell_names {U_PTECO_HOLD_BUF970}
insert_buffer [get_pins {delay_reg_43__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET971} -new_cell_names {U_PTECO_HOLD_BUF971}
insert_buffer [get_pins {delay_reg_46__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET972} -new_cell_names {U_PTECO_HOLD_BUF972}
insert_buffer [get_pins {delay_reg_50__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET973} -new_cell_names {U_PTECO_HOLD_BUF973}
insert_buffer [get_pins {delay_reg_23__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET974} -new_cell_names {U_PTECO_HOLD_BUF974}
insert_buffer [get_pins {delay_reg_30__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET975} -new_cell_names {U_PTECO_HOLD_BUF975}
insert_buffer [get_pins {delay_reg_2__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET976} -new_cell_names {U_PTECO_HOLD_BUF976}
insert_buffer [get_pins {delay_reg_32__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET977} -new_cell_names {U_PTECO_HOLD_BUF977}
insert_buffer [get_pins {delay_reg_10__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET978} -new_cell_names {U_PTECO_HOLD_BUF978}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_x_delay_reg_13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET979} -new_cell_names {U_PTECO_HOLD_BUF979}
insert_buffer [get_pins {u_cic_u_combs_u_comb2_y_out_reg_2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET980} -new_cell_names {U_PTECO_HOLD_BUF980}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_22__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET981} -new_cell_names {U_PTECO_HOLD_BUF981}
insert_buffer [get_pins {delay_reg_33__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET982} -new_cell_names {U_PTECO_HOLD_BUF982}
insert_buffer [get_pins {delay_reg_46__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET983} -new_cell_names {U_PTECO_HOLD_BUF983}
insert_buffer [get_pins {delay_reg_36__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET984} -new_cell_names {U_PTECO_HOLD_BUF984}
insert_buffer [get_pins {delay_reg_26__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET985} -new_cell_names {U_PTECO_HOLD_BUF985}
insert_buffer [get_pins {delay_reg_34__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET986} -new_cell_names {U_PTECO_HOLD_BUF986}
insert_buffer [get_pins {delay_reg_2__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET987} -new_cell_names {U_PTECO_HOLD_BUF987}
insert_buffer [get_pins {delay_reg_41__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET988} -new_cell_names {U_PTECO_HOLD_BUF988}
insert_buffer [get_pins {delay_reg_41__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET989} -new_cell_names {U_PTECO_HOLD_BUF989}
insert_buffer [get_pins {delay_reg_48__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET990} -new_cell_names {U_PTECO_HOLD_BUF990}
insert_buffer [get_pins {delay_reg_39__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET991} -new_cell_names {U_PTECO_HOLD_BUF991}
insert_buffer [get_pins {delay_reg_21__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET992} -new_cell_names {U_PTECO_HOLD_BUF992}
insert_buffer [get_pins {delay_reg_28__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET993} -new_cell_names {U_PTECO_HOLD_BUF993}
insert_buffer [get_pins {delay_reg_27__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET994} -new_cell_names {U_PTECO_HOLD_BUF994}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_y_out_reg_9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET995} -new_cell_names {U_PTECO_HOLD_BUF995}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_37__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET996} -new_cell_names {U_PTECO_HOLD_BUF996}
insert_buffer [get_pins {delay_reg_48__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET997} -new_cell_names {U_PTECO_HOLD_BUF997}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_y_out_reg_9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET998} -new_cell_names {U_PTECO_HOLD_BUF998}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_49__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET999} -new_cell_names {U_PTECO_HOLD_BUF999}
insert_buffer [get_pins {delay_reg_40__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1000} -new_cell_names {U_PTECO_HOLD_BUF1000}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_y_out_reg_16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1001} -new_cell_names {U_PTECO_HOLD_BUF1001}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_32__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1002} -new_cell_names {U_PTECO_HOLD_BUF1002}
insert_buffer [get_pins {delay_reg_24__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1003} -new_cell_names {U_PTECO_HOLD_BUF1003}
insert_buffer [get_pins {y_out_reg_16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1004} -new_cell_names {U_PTECO_HOLD_BUF1004}
insert_buffer [get_pins {delay_reg_30__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1005} -new_cell_names {U_PTECO_HOLD_BUF1005}
insert_buffer [get_pins {delay_reg_15__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1006} -new_cell_names {U_PTECO_HOLD_BUF1006}
insert_buffer [get_pins {delay_reg_31__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1007} -new_cell_names {U_PTECO_HOLD_BUF1007}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_x_delay_reg_8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1008} -new_cell_names {U_PTECO_HOLD_BUF1008}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_34__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1009} -new_cell_names {U_PTECO_HOLD_BUF1009}
insert_buffer [get_pins {delay_reg_46__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1010} -new_cell_names {U_PTECO_HOLD_BUF1010}
insert_buffer [get_pins {delay_reg_41__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1011} -new_cell_names {U_PTECO_HOLD_BUF1011}
insert_buffer [get_pins {delay_reg_47__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1012} -new_cell_names {U_PTECO_HOLD_BUF1012}
insert_buffer [get_pins {delay_reg_41__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1013} -new_cell_names {U_PTECO_HOLD_BUF1013}
insert_buffer [get_pins {delay_reg_23__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1014} -new_cell_names {U_PTECO_HOLD_BUF1014}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int4_reg_12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1015} -new_cell_names {U_PTECO_HOLD_BUF1015}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_31__16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1016} -new_cell_names {U_PTECO_HOLD_BUF1016}
insert_buffer [get_pins {delay_reg_25__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1017} -new_cell_names {U_PTECO_HOLD_BUF1017}
insert_buffer [get_pins {delay_reg_33__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1018} -new_cell_names {U_PTECO_HOLD_BUF1018}
insert_buffer [get_pins {delay_reg_25__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1019} -new_cell_names {U_PTECO_HOLD_BUF1019}
insert_buffer [get_pins {delay_reg_24__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1020} -new_cell_names {U_PTECO_HOLD_BUF1020}
insert_buffer [get_pins {delay_reg_25__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1021} -new_cell_names {U_PTECO_HOLD_BUF1021}
insert_buffer [get_pins {delay_reg_60__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1022} -new_cell_names {U_PTECO_HOLD_BUF1022}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_y_out_reg_17_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1023} -new_cell_names {U_PTECO_HOLD_BUF1023}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_21__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1024} -new_cell_names {U_PTECO_HOLD_BUF1024}
insert_buffer [get_pins {delay_reg_2__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1025} -new_cell_names {U_PTECO_HOLD_BUF1025}
insert_buffer [get_pins {delay_reg_37__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1026} -new_cell_names {U_PTECO_HOLD_BUF1026}
insert_buffer [get_pins {delay_reg_36__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1027} -new_cell_names {U_PTECO_HOLD_BUF1027}
insert_buffer [get_pins {delay_reg_42__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1028} -new_cell_names {U_PTECO_HOLD_BUF1028}
insert_buffer [get_pins {delay_reg_56__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1029} -new_cell_names {U_PTECO_HOLD_BUF1029}
insert_buffer [get_pins {delay_reg_15__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1030} -new_cell_names {U_PTECO_HOLD_BUF1030}
insert_buffer [get_pins {delay_reg_28__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1031} -new_cell_names {U_PTECO_HOLD_BUF1031}
insert_buffer [get_pins {delay_reg_59__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1032} -new_cell_names {U_PTECO_HOLD_BUF1032}
insert_buffer [get_pins {delay_reg_42__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1033} -new_cell_names {U_PTECO_HOLD_BUF1033}
insert_buffer [get_pins {delay_reg_46__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1034} -new_cell_names {U_PTECO_HOLD_BUF1034}
insert_buffer [get_pins {delay_reg_28__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1035} -new_cell_names {U_PTECO_HOLD_BUF1035}
insert_buffer [get_pins {delay_reg_40__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1036} -new_cell_names {U_PTECO_HOLD_BUF1036}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_x_delay_reg_2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1037} -new_cell_names {U_PTECO_HOLD_BUF1037}
insert_buffer [get_pins {u_cic_u_combs_u_comb1_valid_out_reg/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1038} -new_cell_names {U_PTECO_HOLD_BUF1038}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_33__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1039} -new_cell_names {U_PTECO_HOLD_BUF1039}
insert_buffer [get_pins {delay_reg_3__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1040} -new_cell_names {U_PTECO_HOLD_BUF1040}
insert_buffer [get_pins {delay_reg_31__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1041} -new_cell_names {U_PTECO_HOLD_BUF1041}
insert_buffer [get_pins {delay_reg_22__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1042} -new_cell_names {U_PTECO_HOLD_BUF1042}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_y_out_reg_8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1043} -new_cell_names {U_PTECO_HOLD_BUF1043}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_25__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1044} -new_cell_names {U_PTECO_HOLD_BUF1044}
insert_buffer [get_pins {delay_reg_53__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1045} -new_cell_names {U_PTECO_HOLD_BUF1045}
insert_buffer [get_pins {delay_reg_5__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1046} -new_cell_names {U_PTECO_HOLD_BUF1046}
insert_buffer [get_pins {delay_reg_43__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1047} -new_cell_names {U_PTECO_HOLD_BUF1047}
insert_buffer [get_pins {delay_reg_14__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1048} -new_cell_names {U_PTECO_HOLD_BUF1048}
insert_buffer [get_pins {delay_reg_27__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1049} -new_cell_names {U_PTECO_HOLD_BUF1049}
insert_buffer [get_pins {delay_reg_43__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1050} -new_cell_names {U_PTECO_HOLD_BUF1050}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int4_reg_13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1051} -new_cell_names {U_PTECO_HOLD_BUF1051}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_54__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1052} -new_cell_names {U_PTECO_HOLD_BUF1052}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_x_delay_reg_14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1053} -new_cell_names {U_PTECO_HOLD_BUF1053}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_22__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1054} -new_cell_names {U_PTECO_HOLD_BUF1054}
insert_buffer [get_pins {delay_reg_14__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1055} -new_cell_names {U_PTECO_HOLD_BUF1055}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_y_out_reg_4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1056} -new_cell_names {U_PTECO_HOLD_BUF1056}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_29__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1057} -new_cell_names {U_PTECO_HOLD_BUF1057}
insert_buffer [get_pins {delay_reg_52__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1058} -new_cell_names {U_PTECO_HOLD_BUF1058}
insert_buffer [get_pins {delay_reg_4__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1059} -new_cell_names {U_PTECO_HOLD_BUF1059}
insert_buffer [get_pins {delay_reg_22__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1060} -new_cell_names {U_PTECO_HOLD_BUF1060}
insert_buffer [get_pins {delay_reg_45__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1061} -new_cell_names {U_PTECO_HOLD_BUF1061}
insert_buffer [get_pins {delay_reg_40__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1062} -new_cell_names {U_PTECO_HOLD_BUF1062}
insert_buffer [get_pins {delay_reg_35__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1063} -new_cell_names {U_PTECO_HOLD_BUF1063}
insert_buffer [get_pins {delay_reg_24__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1064} -new_cell_names {U_PTECO_HOLD_BUF1064}
insert_buffer [get_pins {delay_reg_38__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1065} -new_cell_names {U_PTECO_HOLD_BUF1065}
insert_buffer [get_pins {delay_reg_41__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1066} -new_cell_names {U_PTECO_HOLD_BUF1066}
insert_buffer [get_pins {delay_reg_28__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1067} -new_cell_names {U_PTECO_HOLD_BUF1067}
insert_buffer [get_pins {delay_reg_44__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1068} -new_cell_names {U_PTECO_HOLD_BUF1068}
insert_buffer [get_pins {delay_reg_39__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1069} -new_cell_names {U_PTECO_HOLD_BUF1069}
insert_buffer [get_pins {delay_reg_20__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1070} -new_cell_names {U_PTECO_HOLD_BUF1070}
insert_buffer [get_pins {delay_reg_14__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1071} -new_cell_names {U_PTECO_HOLD_BUF1071}
insert_buffer [get_pins {delay_reg_52__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1072} -new_cell_names {U_PTECO_HOLD_BUF1072}
insert_buffer [get_pins {delay_reg_60__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1073} -new_cell_names {U_PTECO_HOLD_BUF1073}
insert_buffer [get_pins {delay_reg_48__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1074} -new_cell_names {U_PTECO_HOLD_BUF1074}
insert_buffer [get_pins {delay_reg_38__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1075} -new_cell_names {U_PTECO_HOLD_BUF1075}
insert_buffer [get_pins {delay_reg_14__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1076} -new_cell_names {U_PTECO_HOLD_BUF1076}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_y_out_reg_7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1077} -new_cell_names {U_PTECO_HOLD_BUF1077}
insert_buffer [get_pins {u_cic_u_combs_u_comb2_x_delay_reg_11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1078} -new_cell_names {U_PTECO_HOLD_BUF1078}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_13__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1079} -new_cell_names {U_PTECO_HOLD_BUF1079}
insert_buffer [get_pins {delay_reg_18__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1080} -new_cell_names {U_PTECO_HOLD_BUF1080}
insert_buffer [get_pins {delay_reg_30__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1081} -new_cell_names {U_PTECO_HOLD_BUF1081}
insert_buffer [get_pins {delay_reg_39__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1082} -new_cell_names {U_PTECO_HOLD_BUF1082}
insert_buffer [get_pins {delay_reg_27__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1083} -new_cell_names {U_PTECO_HOLD_BUF1083}
insert_buffer [get_pins {delay_reg_21__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1084} -new_cell_names {U_PTECO_HOLD_BUF1084}
insert_buffer [get_pins {delay_reg_56__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1085} -new_cell_names {U_PTECO_HOLD_BUF1085}
insert_buffer [get_pins {delay_reg_13__8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1086} -new_cell_names {U_PTECO_HOLD_BUF1086}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_y_out_reg_2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1087} -new_cell_names {U_PTECO_HOLD_BUF1087}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_21__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1088} -new_cell_names {U_PTECO_HOLD_BUF1088}
insert_buffer [get_pins {delay_reg_28__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1089} -new_cell_names {U_PTECO_HOLD_BUF1089}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_x_delay_reg_2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1090} -new_cell_names {U_PTECO_HOLD_BUF1090}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_1__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1091} -new_cell_names {U_PTECO_HOLD_BUF1091}
insert_buffer [get_pins {delay_reg_49__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1092} -new_cell_names {U_PTECO_HOLD_BUF1092}
insert_buffer [get_pins {delay_reg_32__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1093} -new_cell_names {U_PTECO_HOLD_BUF1093}
insert_buffer [get_pins {delay_reg_17__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1094} -new_cell_names {U_PTECO_HOLD_BUF1094}
insert_buffer [get_pins {delay_reg_21__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1095} -new_cell_names {U_PTECO_HOLD_BUF1095}
insert_buffer [get_pins {delay_reg_17__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1096} -new_cell_names {U_PTECO_HOLD_BUF1096}
insert_buffer [get_pins {delay_reg_48__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1097} -new_cell_names {U_PTECO_HOLD_BUF1097}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_x_delay_reg_8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1098} -new_cell_names {U_PTECO_HOLD_BUF1098}
insert_buffer [get_pins {u_cic_u_combs_u_comb2_y_out_reg_5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1099} -new_cell_names {U_PTECO_HOLD_BUF1099}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_39__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1100} -new_cell_names {U_PTECO_HOLD_BUF1100}
insert_buffer [get_pins {delay_reg_43__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1101} -new_cell_names {U_PTECO_HOLD_BUF1101}
insert_buffer [get_pins {delay_reg_27__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1102} -new_cell_names {U_PTECO_HOLD_BUF1102}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int4_reg_8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1103} -new_cell_names {U_PTECO_HOLD_BUF1103}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_37__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1104} -new_cell_names {U_PTECO_HOLD_BUF1104}
insert_buffer [get_pins {delay_reg_40__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1105} -new_cell_names {U_PTECO_HOLD_BUF1105}
insert_buffer [get_pins {delay_reg_30__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1106} -new_cell_names {U_PTECO_HOLD_BUF1106}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_x_delay_reg_2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1107} -new_cell_names {U_PTECO_HOLD_BUF1107}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_55__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1108} -new_cell_names {U_PTECO_HOLD_BUF1108}
insert_buffer [get_pins {delay_reg_23__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1109} -new_cell_names {U_PTECO_HOLD_BUF1109}
insert_buffer [get_pins {delay_reg_46__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1110} -new_cell_names {U_PTECO_HOLD_BUF1110}
insert_buffer [get_pins {delay_reg_50__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1111} -new_cell_names {U_PTECO_HOLD_BUF1111}
insert_buffer [get_pins {delay_reg_16__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1112} -new_cell_names {U_PTECO_HOLD_BUF1112}
insert_buffer [get_pins {delay_reg_13__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1113} -new_cell_names {U_PTECO_HOLD_BUF1113}
insert_buffer [get_pins {delay_reg_6__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1114} -new_cell_names {U_PTECO_HOLD_BUF1114}
insert_buffer [get_pins {delay_reg_42__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1115} -new_cell_names {U_PTECO_HOLD_BUF1115}
insert_buffer [get_pins {delay_reg_36__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1116} -new_cell_names {U_PTECO_HOLD_BUF1116}
insert_buffer [get_pins {delay_reg_42__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1117} -new_cell_names {U_PTECO_HOLD_BUF1117}
insert_buffer [get_pins {delay_reg_45__14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1118} -new_cell_names {U_PTECO_HOLD_BUF1118}
insert_buffer [get_pins {delay_reg_7__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1119} -new_cell_names {U_PTECO_HOLD_BUF1119}
insert_buffer [get_pins {delay_reg_16__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1120} -new_cell_names {U_PTECO_HOLD_BUF1120}
insert_buffer [get_pins {delay_reg_47__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1121} -new_cell_names {U_PTECO_HOLD_BUF1121}
insert_buffer [get_pins {delay_reg_30__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1122} -new_cell_names {U_PTECO_HOLD_BUF1122}
insert_buffer [get_pins {delay_reg_32__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1123} -new_cell_names {U_PTECO_HOLD_BUF1123}
insert_buffer [get_pins {delay_reg_23__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1124} -new_cell_names {U_PTECO_HOLD_BUF1124}
insert_buffer [get_pins {delay_reg_1__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1125} -new_cell_names {U_PTECO_HOLD_BUF1125}
insert_buffer [get_pins {delay_reg_42__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1126} -new_cell_names {U_PTECO_HOLD_BUF1126}
insert_buffer [get_pins {delay_reg_25__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1127} -new_cell_names {U_PTECO_HOLD_BUF1127}
insert_buffer [get_pins {delay_reg_58__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1128} -new_cell_names {U_PTECO_HOLD_BUF1128}
insert_buffer [get_pins {delay_reg_32__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1129} -new_cell_names {U_PTECO_HOLD_BUF1129}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_x_delay_reg_17_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1130} -new_cell_names {U_PTECO_HOLD_BUF1130}
insert_buffer [get_pins {u_cic_u_combs_u_comb1_x_delay_reg_0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1131} -new_cell_names {U_PTECO_HOLD_BUF1131}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_56__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1132} -new_cell_names {U_PTECO_HOLD_BUF1132}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_y_out_reg_13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1133} -new_cell_names {U_PTECO_HOLD_BUF1133}
insert_buffer [get_pins {u_cic_u_combs_u_comb1_x_delay_reg_16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1134} -new_cell_names {U_PTECO_HOLD_BUF1134}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_59__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1135} -new_cell_names {U_PTECO_HOLD_BUF1135}
insert_buffer [get_pins {delay_reg_9__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1136} -new_cell_names {U_PTECO_HOLD_BUF1136}
insert_buffer [get_pins {delay_reg_39__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1137} -new_cell_names {U_PTECO_HOLD_BUF1137}
insert_buffer [get_pins {delay_reg_17__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1138} -new_cell_names {U_PTECO_HOLD_BUF1138}
insert_buffer [get_pins {delay_reg_13__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1139} -new_cell_names {U_PTECO_HOLD_BUF1139}
insert_buffer [get_pins {delay_reg_9__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1140} -new_cell_names {U_PTECO_HOLD_BUF1140}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_x_delay_reg_11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1141} -new_cell_names {U_PTECO_HOLD_BUF1141}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_0__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1142} -new_cell_names {U_PTECO_HOLD_BUF1142}
insert_buffer [get_pins {delay_reg_49__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1143} -new_cell_names {U_PTECO_HOLD_BUF1143}
insert_buffer [get_pins {delay_reg_62__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1144} -new_cell_names {U_PTECO_HOLD_BUF1144}
insert_buffer [get_pins {delay_reg_22__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1145} -new_cell_names {U_PTECO_HOLD_BUF1145}
insert_buffer [get_pins {delay_reg_34__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1146} -new_cell_names {U_PTECO_HOLD_BUF1146}
insert_buffer [get_pins {delay_reg_50__6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1147} -new_cell_names {U_PTECO_HOLD_BUF1147}
insert_buffer [get_pins {delay_reg_37__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1148} -new_cell_names {U_PTECO_HOLD_BUF1148}
insert_buffer [get_pins {delay_reg_25__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1149} -new_cell_names {U_PTECO_HOLD_BUF1149}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_y_out_reg_1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1150} -new_cell_names {U_PTECO_HOLD_BUF1150}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_47__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1151} -new_cell_names {U_PTECO_HOLD_BUF1151}
insert_buffer [get_pins {delay_reg_60__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1152} -new_cell_names {U_PTECO_HOLD_BUF1152}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_y_out_reg_0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1153} -new_cell_names {U_PTECO_HOLD_BUF1153}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_12__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1154} -new_cell_names {U_PTECO_HOLD_BUF1154}
insert_buffer [get_pins {delay_reg_3__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1155} -new_cell_names {U_PTECO_HOLD_BUF1155}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_x_delay_reg_10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1156} -new_cell_names {U_PTECO_HOLD_BUF1156}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_14__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1157} -new_cell_names {U_PTECO_HOLD_BUF1157}
insert_buffer [get_pins {delay_reg_24__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1158} -new_cell_names {U_PTECO_HOLD_BUF1158}
insert_buffer [get_pins {delay_reg_31__5_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1159} -new_cell_names {U_PTECO_HOLD_BUF1159}
insert_buffer [get_pins {delay_reg_56__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1160} -new_cell_names {U_PTECO_HOLD_BUF1160}
insert_buffer [get_pins {delay_reg_51__16_/Q}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1161} -new_cell_names {U_PTECO_HOLD_BUF1161}
insert_buffer [get_pins {delay_reg_41__7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1162} -new_cell_names {U_PTECO_HOLD_BUF1162}
insert_buffer [get_pins {delay_reg_37__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1163} -new_cell_names {U_PTECO_HOLD_BUF1163}
insert_buffer [get_pins {delay_reg_48__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1164} -new_cell_names {U_PTECO_HOLD_BUF1164}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_y_out_reg_0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1165} -new_cell_names {U_PTECO_HOLD_BUF1165}
insert_buffer [get_pins {u_cic_u_combs_u_comb2_x_delay_reg_16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1166} -new_cell_names {U_PTECO_HOLD_BUF1166}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_50__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1167} -new_cell_names {U_PTECO_HOLD_BUF1167}
insert_buffer [get_pins {delay_reg_16__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1168} -new_cell_names {U_PTECO_HOLD_BUF1168}
insert_buffer [get_pins {delay_reg_17__4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1169} -new_cell_names {U_PTECO_HOLD_BUF1169}
insert_buffer [get_pins {delay_reg_60__12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1170} -new_cell_names {U_PTECO_HOLD_BUF1170}
insert_buffer [get_pins {delay_reg_37__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1171} -new_cell_names {U_PTECO_HOLD_BUF1171}
insert_buffer [get_pins {delay_reg_17__13_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1172} -new_cell_names {U_PTECO_HOLD_BUF1172}
insert_buffer [get_pins {delay_reg_48__10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1173} -new_cell_names {U_PTECO_HOLD_BUF1173}
insert_buffer [get_pins {delay_reg_30__15_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1174} -new_cell_names {U_PTECO_HOLD_BUF1174}
insert_buffer [get_pins {delay_reg_32__2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1175} -new_cell_names {U_PTECO_HOLD_BUF1175}
insert_buffer [get_pins {delay_reg_35__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1176} -new_cell_names {U_PTECO_HOLD_BUF1176}
insert_buffer [get_pins {delay_reg_15__0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1177} -new_cell_names {U_PTECO_HOLD_BUF1177}
insert_buffer [get_pins {delay_reg_9__1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1178} -new_cell_names {U_PTECO_HOLD_BUF1178}
insert_buffer [get_pins {delay_reg_50__11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1179} -new_cell_names {U_PTECO_HOLD_BUF1179}
insert_buffer [get_pins {delay_reg_25__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1180} -new_cell_names {U_PTECO_HOLD_BUF1180}
insert_buffer [get_pins {delay_reg_55__3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1181} -new_cell_names {U_PTECO_HOLD_BUF1181}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_x_delay_reg_12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1182} -new_cell_names {U_PTECO_HOLD_BUF1182}
insert_buffer [get_pins {u_cic_u_integradores_int3_reg_16_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1183} -new_cell_names {U_PTECO_HOLD_BUF1183}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_49__9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1184} -new_cell_names {U_PTECO_HOLD_BUF1184}
current_instance
insert_buffer [get_pins {u_cic_u_decimador_count_reg_3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1185} -new_cell_names {U_PTECO_HOLD_BUF1185}
insert_buffer [get_pins {u_cic_u_integradores_int1_reg_0_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1186} -new_cell_names {U_PTECO_HOLD_BUF1186}
insert_buffer [get_pins {u_cic_u_integradores_int1_reg_10_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1187} -new_cell_names {U_PTECO_HOLD_BUF1187}
insert_buffer [get_pins {u_cic_u_integradores_int1_reg_2_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1188} -new_cell_names {U_PTECO_HOLD_BUF1188}
insert_buffer [get_pins {u_cic_u_combs_u_comb2_x_delay_reg_6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1189} -new_cell_names {U_PTECO_HOLD_BUF1189}
insert_buffer [get_pins {u_cic_u_integradores_int1_reg_3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1190} -new_cell_names {U_PTECO_HOLD_BUF1190}
insert_buffer [get_pins {u_cic_u_integradores_int1_reg_4_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1191} -new_cell_names {U_PTECO_HOLD_BUF1191}
insert_buffer [get_pins {u_cic_u_integradores_int1_reg_1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1192} -new_cell_names {U_PTECO_HOLD_BUF1192}
insert_buffer [get_pins {u_cic_u_integradores_int1_reg_7_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1193} -new_cell_names {U_PTECO_HOLD_BUF1193}
insert_buffer [get_pins {u_cic_u_integradores_int2_reg_6_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1194} -new_cell_names {U_PTECO_HOLD_BUF1194}
insert_buffer [get_pins {u_cic_u_integradores_int1_reg_8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1195} -new_cell_names {U_PTECO_HOLD_BUF1195}
insert_buffer [get_pins {u_cic_u_integradores_int1_reg_14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1196} -new_cell_names {U_PTECO_HOLD_BUF1196}
insert_buffer [get_pins {u_cic_u_integradores_int1_reg_9_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1197} -new_cell_names {U_PTECO_HOLD_BUF1197}
insert_buffer [get_pins {u_cic_u_integradores_int1_reg_12_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1198} -new_cell_names {U_PTECO_HOLD_BUF1198}
insert_buffer [get_pins {u_cic_u_combs_u_comb1_x_delay_reg_3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1199} -new_cell_names {U_PTECO_HOLD_BUF1199}
insert_buffer [get_pins {u_cic_u_combs_u_comb2_x_delay_reg_1_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1200} -new_cell_names {U_PTECO_HOLD_BUF1200}
insert_buffer [get_pins {u_cic_u_integradores_int2_reg_8_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1201} -new_cell_names {U_PTECO_HOLD_BUF1201}
insert_buffer [get_pins {u_cic_u_integradores_int2_reg_14_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1202} -new_cell_names {U_PTECO_HOLD_BUF1202}
insert_buffer [get_pins {u_cic_u_integradores_int1_reg_11_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1203} -new_cell_names {U_PTECO_HOLD_BUF1203}
insert_buffer [get_pins {u_cic_u_combs_u_comb3_x_delay_reg_3_/SI}] DELLN1X2_RVT -new_net_names {net_PTECO_HOLD_NET1204} -new_cell_names {U_PTECO_HOLD_BUF1204}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_52__14_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1205} -new_cell_names {U_PTECO_HOLD_BUF1205}
insert_buffer [get_pins {delay_reg_56__4_/SI}] NBUFFX8_RVT -new_net_names {net_PTECO_HOLD_NET1206} -new_cell_names {U_PTECO_HOLD_BUF1206}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int4_reg_11_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1207} -new_cell_names {U_PTECO_HOLD_BUF1207}
insert_buffer [get_pins {u_cic_u_integradores_int4_reg_14_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1208} -new_cell_names {U_PTECO_HOLD_BUF1208}
insert_buffer [get_pins {u_cic_u_integradores_int4_reg_17_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1209} -new_cell_names {U_PTECO_HOLD_BUF1209}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_31__4_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1210} -new_cell_names {U_PTECO_HOLD_BUF1210}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int4_reg_15_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1211} -new_cell_names {U_PTECO_HOLD_BUF1211}
insert_buffer [get_pins {u_cic_u_combs_u_comb1_x_delay_reg_17_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1212} -new_cell_names {U_PTECO_HOLD_BUF1212}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_58__8_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1213} -new_cell_names {U_PTECO_HOLD_BUF1213}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int3_reg_13_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1214} -new_cell_names {U_PTECO_HOLD_BUF1214}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_47__13_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1215} -new_cell_names {U_PTECO_HOLD_BUF1215}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int3_reg_11_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1216} -new_cell_names {U_PTECO_HOLD_BUF1216}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_61__1_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1217} -new_cell_names {U_PTECO_HOLD_BUF1217}
insert_buffer [get_pins {delay_reg_6__3_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1218} -new_cell_names {U_PTECO_HOLD_BUF1218}
insert_buffer [get_pins {delay_reg_53__15_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1219} -new_cell_names {U_PTECO_HOLD_BUF1219}
insert_buffer [get_pins {y_out_reg_18_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1220} -new_cell_names {U_PTECO_HOLD_BUF1220}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_x_delay_reg_0_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1221} -new_cell_names {U_PTECO_HOLD_BUF1221}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_31__3_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1222} -new_cell_names {U_PTECO_HOLD_BUF1222}
insert_buffer [get_pins {delay_reg_4__11_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1223} -new_cell_names {U_PTECO_HOLD_BUF1223}
insert_buffer [get_pins {delay_reg_55__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1224} -new_cell_names {U_PTECO_HOLD_BUF1224}
insert_buffer [get_pins {delay_reg_61__13_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1225} -new_cell_names {U_PTECO_HOLD_BUF1225}
insert_buffer [get_pins {delay_reg_3__8_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1226} -new_cell_names {U_PTECO_HOLD_BUF1226}
insert_buffer [get_pins {delay_reg_3__13_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1227} -new_cell_names {U_PTECO_HOLD_BUF1227}
insert_buffer [get_pins {delay_reg_11__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1228} -new_cell_names {U_PTECO_HOLD_BUF1228}
insert_buffer [get_pins {delay_reg_8__14_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1229} -new_cell_names {U_PTECO_HOLD_BUF1229}
insert_buffer [get_pins {delay_reg_61__11_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1230} -new_cell_names {U_PTECO_HOLD_BUF1230}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_x_delay_reg_1_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1231} -new_cell_names {U_PTECO_HOLD_BUF1231}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_60__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1232} -new_cell_names {U_PTECO_HOLD_BUF1232}
insert_buffer [get_pins {delay_reg_63__6_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1233} -new_cell_names {U_PTECO_HOLD_BUF1233}
insert_buffer [get_pins {delay_reg_53__14_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1234} -new_cell_names {U_PTECO_HOLD_BUF1234}
insert_buffer [get_pins {delay_reg_45__13_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1235} -new_cell_names {U_PTECO_HOLD_BUF1235}
insert_buffer [get_pins {delay_reg_54__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1236} -new_cell_names {U_PTECO_HOLD_BUF1236}
insert_buffer [get_pins {delay_reg_63__9_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1237} -new_cell_names {U_PTECO_HOLD_BUF1237}
insert_buffer [get_pins {delay_reg_2__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1238} -new_cell_names {U_PTECO_HOLD_BUF1238}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_x_delay_reg_11_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1239} -new_cell_names {U_PTECO_HOLD_BUF1239}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_57__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1240} -new_cell_names {U_PTECO_HOLD_BUF1240}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_x_delay_reg_3_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1241} -new_cell_names {U_PTECO_HOLD_BUF1241}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_63__10_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1242} -new_cell_names {U_PTECO_HOLD_BUF1242}
insert_buffer [get_pins {delay_reg_59__15_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1243} -new_cell_names {U_PTECO_HOLD_BUF1243}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_x_delay_reg_12_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1244} -new_cell_names {U_PTECO_HOLD_BUF1244}
insert_buffer [get_pins {u_cic_u_combs_u_comb3_x_delay_reg_12_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1245} -new_cell_names {U_PTECO_HOLD_BUF1245}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_39__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1246} -new_cell_names {U_PTECO_HOLD_BUF1246}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_x_delay_reg_10_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1247} -new_cell_names {U_PTECO_HOLD_BUF1247}
insert_buffer [get_pins {u_cic_u_integradores_int4_reg_5_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1248} -new_cell_names {U_PTECO_HOLD_BUF1248}
insert_buffer [get_pins {u_cic_u_combs_u_comb4_x_delay_reg_13_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1249} -new_cell_names {U_PTECO_HOLD_BUF1249}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_32__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1250} -new_cell_names {U_PTECO_HOLD_BUF1250}
insert_buffer [get_pins {delay_reg_47__15_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1251} -new_cell_names {U_PTECO_HOLD_BUF1251}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_x_delay_reg_13_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1252} -new_cell_names {U_PTECO_HOLD_BUF1252}
insert_buffer [get_pins {u_cic_u_combs_u_comb1_x_delay_reg_6_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1253} -new_cell_names {U_PTECO_HOLD_BUF1253}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {y_out_reg_1_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1254} -new_cell_names {U_PTECO_HOLD_BUF1254}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int4_reg_10_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1255} -new_cell_names {U_PTECO_HOLD_BUF1255}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_41__15_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1256} -new_cell_names {U_PTECO_HOLD_BUF1256}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_y_out_reg_14_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1257} -new_cell_names {U_PTECO_HOLD_BUF1257}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_13__15_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1258} -new_cell_names {U_PTECO_HOLD_BUF1258}
insert_buffer [get_pins {delay_reg_8__13_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1259} -new_cell_names {U_PTECO_HOLD_BUF1259}
insert_buffer [get_pins {delay_reg_44__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1260} -new_cell_names {U_PTECO_HOLD_BUF1260}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_y_out_reg_11_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1261} -new_cell_names {U_PTECO_HOLD_BUF1261}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_42__15_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1262} -new_cell_names {U_PTECO_HOLD_BUF1262}
insert_buffer [get_pins {delay_reg_39__15_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1263} -new_cell_names {U_PTECO_HOLD_BUF1263}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_y_out_reg_17_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1264} -new_cell_names {U_PTECO_HOLD_BUF1264}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_40__15_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1265} -new_cell_names {U_PTECO_HOLD_BUF1265}
insert_buffer [get_pins {delay_reg_36__15_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1266} -new_cell_names {U_PTECO_HOLD_BUF1266}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_y_out_reg_10_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1267} -new_cell_names {U_PTECO_HOLD_BUF1267}
insert_buffer [get_pins {u_cic_u_combs_u_comb1_x_delay_reg_8_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1268} -new_cell_names {U_PTECO_HOLD_BUF1268}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_22__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1269} -new_cell_names {U_PTECO_HOLD_BUF1269}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int4_reg_1_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1270} -new_cell_names {U_PTECO_HOLD_BUF1270}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_17__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1271} -new_cell_names {U_PTECO_HOLD_BUF1271}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_x_delay_reg_5_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1272} -new_cell_names {U_PTECO_HOLD_BUF1272}
insert_buffer [get_pins {u_cic_u_combs_u_comb4_x_delay_reg_5_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1273} -new_cell_names {U_PTECO_HOLD_BUF1273}
insert_buffer [get_pins {u_cic_u_combs_u_comb2_x_delay_reg_10_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1274} -new_cell_names {U_PTECO_HOLD_BUF1274}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_7__14_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1275} -new_cell_names {U_PTECO_HOLD_BUF1275}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_x_delay_reg_14_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1276} -new_cell_names {U_PTECO_HOLD_BUF1276}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_5__3_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1277} -new_cell_names {U_PTECO_HOLD_BUF1277}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int4_reg_9_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1278} -new_cell_names {U_PTECO_HOLD_BUF1278}
insert_buffer [get_pins {u_cic_u_combs_u_comb1_x_delay_reg_12_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1279} -new_cell_names {U_PTECO_HOLD_BUF1279}
insert_buffer [get_pins {u_cic_u_integradores_int3_reg_4_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1280} -new_cell_names {U_PTECO_HOLD_BUF1280}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_32__15_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1281} -new_cell_names {U_PTECO_HOLD_BUF1281}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_x_delay_reg_1_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1282} -new_cell_names {U_PTECO_HOLD_BUF1282}
insert_buffer [get_pins {u_cic_u_combs_u_comb1_y_out_reg_9_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1283} -new_cell_names {U_PTECO_HOLD_BUF1283}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_22__13_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1284} -new_cell_names {U_PTECO_HOLD_BUF1284}
insert_buffer [get_pins {y_out_reg_4_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1285} -new_cell_names {U_PTECO_HOLD_BUF1285}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_x_delay_reg_9_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1286} -new_cell_names {U_PTECO_HOLD_BUF1286}
insert_buffer [get_pins {u_cic_u_combs_u_comb3_valid_out_reg/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1287} -new_cell_names {U_PTECO_HOLD_BUF1287}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_16__15_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1288} -new_cell_names {U_PTECO_HOLD_BUF1288}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_x_delay_reg_7_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1289} -new_cell_names {U_PTECO_HOLD_BUF1289}
insert_buffer [get_pins {u_cic_u_combs_u_comb2_x_delay_reg_9_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1290} -new_cell_names {U_PTECO_HOLD_BUF1290}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_3__14_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1291} -new_cell_names {U_PTECO_HOLD_BUF1291}
insert_buffer [get_pins {delay_reg_50__15_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1292} -new_cell_names {U_PTECO_HOLD_BUF1292}
insert_buffer [get_pins {delay_reg_19__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1293} -new_cell_names {U_PTECO_HOLD_BUF1293}
insert_buffer [get_pins {delay_reg_10__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1294} -new_cell_names {U_PTECO_HOLD_BUF1294}
insert_buffer [get_pins {delay_reg_14__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1295} -new_cell_names {U_PTECO_HOLD_BUF1295}
insert_buffer [get_pins {delay_reg_29__15_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1296} -new_cell_names {U_PTECO_HOLD_BUF1296}
insert_buffer [get_pins {delay_reg_49__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1297} -new_cell_names {U_PTECO_HOLD_BUF1297}
insert_buffer [get_pins {delay_reg_62__14_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1298} -new_cell_names {U_PTECO_HOLD_BUF1298}
insert_buffer [get_pins {delay_reg_18__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1299} -new_cell_names {U_PTECO_HOLD_BUF1299}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_valid_out_reg/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1300} -new_cell_names {U_PTECO_HOLD_BUF1300}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_13__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1301} -new_cell_names {U_PTECO_HOLD_BUF1301}
insert_buffer [get_pins {delay_reg_15__15_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1302} -new_cell_names {U_PTECO_HOLD_BUF1302}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_x_delay_reg_7_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1303} -new_cell_names {U_PTECO_HOLD_BUF1303}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_31__10_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1304} -new_cell_names {U_PTECO_HOLD_BUF1304}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_y_out_reg_5_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1305} -new_cell_names {U_PTECO_HOLD_BUF1305}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_21__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1306} -new_cell_names {U_PTECO_HOLD_BUF1306}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_x_delay_reg_2_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1307} -new_cell_names {U_PTECO_HOLD_BUF1307}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_44__13_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1308} -new_cell_names {U_PTECO_HOLD_BUF1308}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_y_out_reg_14_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1309} -new_cell_names {U_PTECO_HOLD_BUF1309}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_4__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1310} -new_cell_names {U_PTECO_HOLD_BUF1310}
insert_buffer [get_pins {delay_reg_16__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1311} -new_cell_names {U_PTECO_HOLD_BUF1311}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_x_delay_reg_15_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1312} -new_cell_names {U_PTECO_HOLD_BUF1312}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_38__14_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1313} -new_cell_names {U_PTECO_HOLD_BUF1313}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_x_delay_reg_7_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1314} -new_cell_names {U_PTECO_HOLD_BUF1314}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_43__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1315} -new_cell_names {U_PTECO_HOLD_BUF1315}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_y_out_reg_15_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1316} -new_cell_names {U_PTECO_HOLD_BUF1316}
insert_buffer [get_pins {u_cic_u_combs_u_comb3_y_out_reg_14_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1317} -new_cell_names {U_PTECO_HOLD_BUF1317}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_26__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1318} -new_cell_names {U_PTECO_HOLD_BUF1318}
current_instance
insert_buffer [get_pins {u_cic_u_integradores_int4_reg_6_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1319} -new_cell_names {U_PTECO_HOLD_BUF1319}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_45__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1320} -new_cell_names {U_PTECO_HOLD_BUF1320}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_y_out_reg_16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1321} -new_cell_names {U_PTECO_HOLD_BUF1321}
insert_buffer [get_pins {u_cic_u_combs_u_comb3_y_out_reg_17_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1322} -new_cell_names {U_PTECO_HOLD_BUF1322}
insert_buffer [get_pins {u_cic_u_combs_u_comb4_x_delay_reg_16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1323} -new_cell_names {U_PTECO_HOLD_BUF1323}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_6__5_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1324} -new_cell_names {U_PTECO_HOLD_BUF1324}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_y_out_reg_15_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1325} -new_cell_names {U_PTECO_HOLD_BUF1325}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_15__8_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1326} -new_cell_names {U_PTECO_HOLD_BUF1326}
insert_buffer [get_pins {delay_reg_7__15_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1327} -new_cell_names {U_PTECO_HOLD_BUF1327}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_y_out_reg_16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1328} -new_cell_names {U_PTECO_HOLD_BUF1328}
insert_buffer [get_pins {u_cic_u_combs_u_comb3_y_out_reg_16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1329} -new_cell_names {U_PTECO_HOLD_BUF1329}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_46__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1330} -new_cell_names {U_PTECO_HOLD_BUF1330}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_y_out_reg_3_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1331} -new_cell_names {U_PTECO_HOLD_BUF1331}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_56__8_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1332} -new_cell_names {U_PTECO_HOLD_BUF1332}
insert_buffer [get_pins {delay_reg_41__13_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1333} -new_cell_names {U_PTECO_HOLD_BUF1333}
insert_buffer [get_pins {delay_reg_9__15_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1334} -new_cell_names {U_PTECO_HOLD_BUF1334}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb1_y_out_reg_8_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1335} -new_cell_names {U_PTECO_HOLD_BUF1335}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_23__15_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1336} -new_cell_names {U_PTECO_HOLD_BUF1336}
insert_buffer [get_pins {delay_reg_1__14_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1337} -new_cell_names {U_PTECO_HOLD_BUF1337}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb3_y_out_reg_0_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1338} -new_cell_names {U_PTECO_HOLD_BUF1338}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_61__12_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1339} -new_cell_names {U_PTECO_HOLD_BUF1339}
insert_buffer [get_pins {delay_reg_34__14_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1340} -new_cell_names {U_PTECO_HOLD_BUF1340}
insert_buffer [get_pins {delay_reg_47__6_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1341} -new_cell_names {U_PTECO_HOLD_BUF1341}
insert_buffer [get_pins {delay_reg_16__6_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1342} -new_cell_names {U_PTECO_HOLD_BUF1342}
insert_buffer [get_pins {delay_reg_37__16_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1343} -new_cell_names {U_PTECO_HOLD_BUF1343}
insert_buffer [get_pins {delay_reg_31__2_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1344} -new_cell_names {U_PTECO_HOLD_BUF1344}
insert_buffer [get_pins {delay_reg_47__10_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1345} -new_cell_names {U_PTECO_HOLD_BUF1345}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb4_valid_out_reg/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1346} -new_cell_names {U_PTECO_HOLD_BUF1346}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_45__15_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1347} -new_cell_names {U_PTECO_HOLD_BUF1347}
current_instance
insert_buffer [get_pins {u_cic_u_combs_u_comb2_x_delay_reg_0_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1348} -new_cell_names {U_PTECO_HOLD_BUF1348}
insert_buffer [get_pins {u_cic_u_integradores_int3_reg_7_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1349} -new_cell_names {U_PTECO_HOLD_BUF1349}
current_instance
current_instance {u_fir}
insert_buffer [get_pins {delay_reg_47__12_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1350} -new_cell_names {U_PTECO_HOLD_BUF1350}
insert_buffer [get_pins {delay_reg_16__9_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1351} -new_cell_names {U_PTECO_HOLD_BUF1351}
insert_buffer [get_pins {delay_reg_17__9_/SI}] NBUFFX2_RVT -new_net_names {net_PTECO_HOLD_NET1352} -new_cell_names {U_PTECO_HOLD_BUF1352}
current_instance
insert_buffer [get_ports {scan_out}] DELLN2X2_RVT -new_net_names {net_PTECO_HOLD_NET1353} -new_cell_names {U_PTECO_HOLD_BUF1353}
