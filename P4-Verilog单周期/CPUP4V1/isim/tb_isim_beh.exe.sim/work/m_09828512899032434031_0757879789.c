/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/co-eda/Documents/ise/CPUP4V1/NPC.v";
static int ng1[] = {4, 0};
static unsigned int ng2[] = {0U, 0U};
static unsigned int ng3[] = {1U, 0U};
static int ng4[] = {14, 0};
static unsigned int ng5[] = {2U, 0U};
static unsigned int ng6[] = {3U, 0U};



static void Cont_31_0(char *t0)
{
    char t4[8];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;

LAB0:    t1 = (t0 + 3160U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(31, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng1)));
    memset(t4, 0, 8);
    xsi_vlog_unsigned_add(t4, 32, t3, 32, t2, 32);
    t5 = (t0 + 3824);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t4, 8);
    xsi_driver_vfirst_trans(t5, 0, 31);
    t10 = (t0 + 3728);
    *((int *)t10) = 1;

LAB1:    return;
}

static void Cont_32_1(char *t0)
{
    char t3[8];
    char t4[8];
    char t6[8];
    char t35[8];
    char t40[8];
    char t41[8];
    char t44[8];
    char t62[8];
    char t78[8];
    char t123[8];
    char t124[8];
    char t126[8];
    char t136[8];
    char t140[8];
    char t148[8];
    char t153[8];
    char t154[8];
    char t157[8];
    char t175[8];
    char t191[8];
    char t236[8];
    char t241[8];
    char t242[8];
    char t245[8];
    char t272[8];
    char t276[8];
    char t289[8];
    char t290[8];
    char t293[8];
    char t327[8];
    char *t1;
    char *t2;
    char *t5;
    char *t7;
    char *t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    char *t28;
    char *t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    char *t33;
    char *t34;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    char *t42;
    char *t43;
    char *t45;
    char *t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    char *t59;
    char *t60;
    char *t61;
    char *t63;
    char *t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    unsigned int t72;
    unsigned int t73;
    unsigned int t74;
    unsigned int t75;
    unsigned int t76;
    char *t77;
    unsigned int t79;
    unsigned int t80;
    unsigned int t81;
    char *t82;
    char *t83;
    char *t84;
    unsigned int t85;
    unsigned int t86;
    unsigned int t87;
    unsigned int t88;
    unsigned int t89;
    unsigned int t90;
    unsigned int t91;
    char *t92;
    char *t93;
    unsigned int t94;
    unsigned int t95;
    unsigned int t96;
    unsigned int t97;
    unsigned int t98;
    unsigned int t99;
    unsigned int t100;
    unsigned int t101;
    int t102;
    int t103;
    unsigned int t104;
    unsigned int t105;
    unsigned int t106;
    unsigned int t107;
    unsigned int t108;
    unsigned int t109;
    char *t110;
    unsigned int t111;
    unsigned int t112;
    unsigned int t113;
    unsigned int t114;
    unsigned int t115;
    char *t116;
    char *t117;
    unsigned int t118;
    unsigned int t119;
    unsigned int t120;
    char *t121;
    char *t122;
    char *t125;
    char *t127;
    char *t128;
    char *t129;
    unsigned int t130;
    unsigned int t131;
    unsigned int t132;
    unsigned int t133;
    unsigned int t134;
    unsigned int t135;
    char *t137;
    char *t138;
    char *t139;
    char *t141;
    unsigned int t142;
    unsigned int t143;
    unsigned int t144;
    unsigned int t145;
    unsigned int t146;
    unsigned int t147;
    unsigned int t149;
    unsigned int t150;
    unsigned int t151;
    unsigned int t152;
    char *t155;
    char *t156;
    char *t158;
    char *t159;
    unsigned int t160;
    unsigned int t161;
    unsigned int t162;
    unsigned int t163;
    unsigned int t164;
    unsigned int t165;
    unsigned int t166;
    unsigned int t167;
    unsigned int t168;
    unsigned int t169;
    unsigned int t170;
    unsigned int t171;
    char *t172;
    char *t173;
    char *t174;
    char *t176;
    char *t177;
    unsigned int t178;
    unsigned int t179;
    unsigned int t180;
    unsigned int t181;
    unsigned int t182;
    unsigned int t183;
    unsigned int t184;
    unsigned int t185;
    unsigned int t186;
    unsigned int t187;
    unsigned int t188;
    unsigned int t189;
    char *t190;
    unsigned int t192;
    unsigned int t193;
    unsigned int t194;
    char *t195;
    char *t196;
    char *t197;
    unsigned int t198;
    unsigned int t199;
    unsigned int t200;
    unsigned int t201;
    unsigned int t202;
    unsigned int t203;
    unsigned int t204;
    char *t205;
    char *t206;
    unsigned int t207;
    unsigned int t208;
    unsigned int t209;
    unsigned int t210;
    unsigned int t211;
    unsigned int t212;
    unsigned int t213;
    unsigned int t214;
    int t215;
    int t216;
    unsigned int t217;
    unsigned int t218;
    unsigned int t219;
    unsigned int t220;
    unsigned int t221;
    unsigned int t222;
    char *t223;
    unsigned int t224;
    unsigned int t225;
    unsigned int t226;
    unsigned int t227;
    unsigned int t228;
    char *t229;
    char *t230;
    unsigned int t231;
    unsigned int t232;
    unsigned int t233;
    char *t234;
    char *t235;
    unsigned int t237;
    unsigned int t238;
    unsigned int t239;
    unsigned int t240;
    char *t243;
    char *t244;
    char *t246;
    char *t247;
    unsigned int t248;
    unsigned int t249;
    unsigned int t250;
    unsigned int t251;
    unsigned int t252;
    unsigned int t253;
    unsigned int t254;
    unsigned int t255;
    unsigned int t256;
    unsigned int t257;
    unsigned int t258;
    unsigned int t259;
    char *t260;
    char *t261;
    unsigned int t262;
    unsigned int t263;
    unsigned int t264;
    unsigned int t265;
    unsigned int t266;
    char *t267;
    char *t268;
    unsigned int t269;
    unsigned int t270;
    unsigned int t271;
    char *t273;
    char *t274;
    char *t275;
    char *t277;
    char *t278;
    unsigned int t279;
    unsigned int t280;
    unsigned int t281;
    unsigned int t282;
    unsigned int t283;
    unsigned int t284;
    unsigned int t285;
    unsigned int t286;
    unsigned int t287;
    unsigned int t288;
    char *t291;
    char *t292;
    char *t294;
    char *t295;
    unsigned int t296;
    unsigned int t297;
    unsigned int t298;
    unsigned int t299;
    unsigned int t300;
    unsigned int t301;
    unsigned int t302;
    unsigned int t303;
    unsigned int t304;
    unsigned int t305;
    unsigned int t306;
    unsigned int t307;
    char *t308;
    char *t309;
    unsigned int t310;
    unsigned int t311;
    unsigned int t312;
    unsigned int t313;
    unsigned int t314;
    char *t315;
    char *t316;
    unsigned int t317;
    unsigned int t318;
    unsigned int t319;
    char *t320;
    char *t321;
    unsigned int t322;
    unsigned int t323;
    unsigned int t324;
    unsigned int t325;
    char *t326;
    char *t328;
    char *t329;
    char *t330;
    char *t331;
    char *t332;
    char *t333;

LAB0:    t1 = (t0 + 3408U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(32, ng0);
    t2 = (t0 + 1688U);
    t5 = *((char **)t2);
    t2 = ((char*)((ng2)));
    memset(t6, 0, 8);
    t7 = (t5 + 4);
    t8 = (t2 + 4);
    t9 = *((unsigned int *)t5);
    t10 = *((unsigned int *)t2);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t7);
    t13 = *((unsigned int *)t8);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t7);
    t17 = *((unsigned int *)t8);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB7;

LAB4:    if (t18 != 0)
        goto LAB6;

LAB5:    *((unsigned int *)t6) = 1;

LAB7:    memset(t4, 0, 8);
    t22 = (t6 + 4);
    t23 = *((unsigned int *)t22);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 & 1U);
    if (t27 != 0)
        goto LAB8;

LAB9:    if (*((unsigned int *)t22) != 0)
        goto LAB10;

LAB11:    t29 = (t4 + 4);
    t30 = *((unsigned int *)t4);
    t31 = *((unsigned int *)t29);
    t32 = (t30 || t31);
    if (t32 > 0)
        goto LAB12;

LAB13:    t36 = *((unsigned int *)t4);
    t37 = (~(t36));
    t38 = *((unsigned int *)t29);
    t39 = (t37 || t38);
    if (t39 > 0)
        goto LAB14;

LAB15:    if (*((unsigned int *)t29) > 0)
        goto LAB16;

LAB17:    if (*((unsigned int *)t4) > 0)
        goto LAB18;

LAB19:    memcpy(t3, t40, 8);

LAB20:    t328 = (t0 + 3888);
    t329 = (t328 + 56U);
    t330 = *((char **)t329);
    t331 = (t330 + 56U);
    t332 = *((char **)t331);
    memcpy(t332, t3, 8);
    xsi_driver_vfirst_trans(t328, 0, 31);
    t333 = (t0 + 3744);
    *((int *)t333) = 1;

LAB1:    return;
LAB6:    t21 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB7;

LAB8:    *((unsigned int *)t4) = 1;
    goto LAB11;

LAB10:    t28 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t28) = 1;
    goto LAB11;

LAB12:    t33 = (t0 + 1048U);
    t34 = *((char **)t33);
    t33 = ((char*)((ng1)));
    memset(t35, 0, 8);
    xsi_vlog_unsigned_add(t35, 32, t34, 32, t33, 32);
    goto LAB13;

LAB14:    t42 = (t0 + 1688U);
    t43 = *((char **)t42);
    t42 = ((char*)((ng3)));
    memset(t44, 0, 8);
    t45 = (t43 + 4);
    t46 = (t42 + 4);
    t47 = *((unsigned int *)t43);
    t48 = *((unsigned int *)t42);
    t49 = (t47 ^ t48);
    t50 = *((unsigned int *)t45);
    t51 = *((unsigned int *)t46);
    t52 = (t50 ^ t51);
    t53 = (t49 | t52);
    t54 = *((unsigned int *)t45);
    t55 = *((unsigned int *)t46);
    t56 = (t54 | t55);
    t57 = (~(t56));
    t58 = (t53 & t57);
    if (t58 != 0)
        goto LAB24;

LAB21:    if (t56 != 0)
        goto LAB23;

LAB22:    *((unsigned int *)t44) = 1;

LAB24:    t60 = (t0 + 1528U);
    t61 = *((char **)t60);
    t60 = ((char*)((ng3)));
    memset(t62, 0, 8);
    t63 = (t61 + 4);
    t64 = (t60 + 4);
    t65 = *((unsigned int *)t61);
    t66 = *((unsigned int *)t60);
    t67 = (t65 ^ t66);
    t68 = *((unsigned int *)t63);
    t69 = *((unsigned int *)t64);
    t70 = (t68 ^ t69);
    t71 = (t67 | t70);
    t72 = *((unsigned int *)t63);
    t73 = *((unsigned int *)t64);
    t74 = (t72 | t73);
    t75 = (~(t74));
    t76 = (t71 & t75);
    if (t76 != 0)
        goto LAB28;

LAB25:    if (t74 != 0)
        goto LAB27;

LAB26:    *((unsigned int *)t62) = 1;

LAB28:    t79 = *((unsigned int *)t44);
    t80 = *((unsigned int *)t62);
    t81 = (t79 & t80);
    *((unsigned int *)t78) = t81;
    t82 = (t44 + 4);
    t83 = (t62 + 4);
    t84 = (t78 + 4);
    t85 = *((unsigned int *)t82);
    t86 = *((unsigned int *)t83);
    t87 = (t85 | t86);
    *((unsigned int *)t84) = t87;
    t88 = *((unsigned int *)t84);
    t89 = (t88 != 0);
    if (t89 == 1)
        goto LAB29;

LAB30:
LAB31:    memset(t41, 0, 8);
    t110 = (t78 + 4);
    t111 = *((unsigned int *)t110);
    t112 = (~(t111));
    t113 = *((unsigned int *)t78);
    t114 = (t113 & t112);
    t115 = (t114 & 1U);
    if (t115 != 0)
        goto LAB32;

LAB33:    if (*((unsigned int *)t110) != 0)
        goto LAB34;

LAB35:    t117 = (t41 + 4);
    t118 = *((unsigned int *)t41);
    t119 = *((unsigned int *)t117);
    t120 = (t118 || t119);
    if (t120 > 0)
        goto LAB36;

LAB37:    t149 = *((unsigned int *)t41);
    t150 = (~(t149));
    t151 = *((unsigned int *)t117);
    t152 = (t150 || t151);
    if (t152 > 0)
        goto LAB38;

LAB39:    if (*((unsigned int *)t117) > 0)
        goto LAB40;

LAB41:    if (*((unsigned int *)t41) > 0)
        goto LAB42;

LAB43:    memcpy(t40, t153, 8);

LAB44:    goto LAB15;

LAB16:    xsi_vlog_unsigned_bit_combine(t3, 32, t35, 32, t40, 32);
    goto LAB20;

LAB18:    memcpy(t3, t35, 8);
    goto LAB20;

LAB23:    t59 = (t44 + 4);
    *((unsigned int *)t44) = 1;
    *((unsigned int *)t59) = 1;
    goto LAB24;

LAB27:    t77 = (t62 + 4);
    *((unsigned int *)t62) = 1;
    *((unsigned int *)t77) = 1;
    goto LAB28;

LAB29:    t90 = *((unsigned int *)t78);
    t91 = *((unsigned int *)t84);
    *((unsigned int *)t78) = (t90 | t91);
    t92 = (t44 + 4);
    t93 = (t62 + 4);
    t94 = *((unsigned int *)t44);
    t95 = (~(t94));
    t96 = *((unsigned int *)t92);
    t97 = (~(t96));
    t98 = *((unsigned int *)t62);
    t99 = (~(t98));
    t100 = *((unsigned int *)t93);
    t101 = (~(t100));
    t102 = (t95 & t97);
    t103 = (t99 & t101);
    t104 = (~(t102));
    t105 = (~(t103));
    t106 = *((unsigned int *)t84);
    *((unsigned int *)t84) = (t106 & t104);
    t107 = *((unsigned int *)t84);
    *((unsigned int *)t84) = (t107 & t105);
    t108 = *((unsigned int *)t78);
    *((unsigned int *)t78) = (t108 & t104);
    t109 = *((unsigned int *)t78);
    *((unsigned int *)t78) = (t109 & t105);
    goto LAB31;

LAB32:    *((unsigned int *)t41) = 1;
    goto LAB35;

LAB34:    t116 = (t41 + 4);
    *((unsigned int *)t41) = 1;
    *((unsigned int *)t116) = 1;
    goto LAB35;

LAB36:    t121 = (t0 + 1048U);
    t122 = *((char **)t121);
    t121 = ((char*)((ng1)));
    memset(t123, 0, 8);
    xsi_vlog_unsigned_add(t123, 32, t122, 32, t121, 32);
    t125 = ((char*)((ng2)));
    t127 = (t0 + 1208U);
    t128 = *((char **)t127);
    memset(t126, 0, 8);
    t127 = (t126 + 4);
    t129 = (t128 + 4);
    t130 = *((unsigned int *)t128);
    t131 = (t130 >> 0);
    *((unsigned int *)t126) = t131;
    t132 = *((unsigned int *)t129);
    t133 = (t132 >> 0);
    *((unsigned int *)t127) = t133;
    t134 = *((unsigned int *)t126);
    *((unsigned int *)t126) = (t134 & 65535U);
    t135 = *((unsigned int *)t127);
    *((unsigned int *)t127) = (t135 & 65535U);
    t137 = ((char*)((ng4)));
    t138 = (t0 + 1208U);
    t139 = *((char **)t138);
    memset(t140, 0, 8);
    t138 = (t140 + 4);
    t141 = (t139 + 4);
    t142 = *((unsigned int *)t139);
    t143 = (t142 >> 15);
    t144 = (t143 & 1);
    *((unsigned int *)t140) = t144;
    t145 = *((unsigned int *)t141);
    t146 = (t145 >> 15);
    t147 = (t146 & 1);
    *((unsigned int *)t138) = t147;
    xsi_vlog_mul_concat(t136, 14, 1, t137, 1U, t140, 1);
    xsi_vlogtype_concat(t124, 32, 32, 3U, t136, 14, t126, 16, t125, 2);
    memset(t148, 0, 8);
    xsi_vlog_unsigned_add(t148, 32, t123, 32, t124, 32);
    goto LAB37;

LAB38:    t155 = (t0 + 1688U);
    t156 = *((char **)t155);
    t155 = ((char*)((ng3)));
    memset(t157, 0, 8);
    t158 = (t156 + 4);
    t159 = (t155 + 4);
    t160 = *((unsigned int *)t156);
    t161 = *((unsigned int *)t155);
    t162 = (t160 ^ t161);
    t163 = *((unsigned int *)t158);
    t164 = *((unsigned int *)t159);
    t165 = (t163 ^ t164);
    t166 = (t162 | t165);
    t167 = *((unsigned int *)t158);
    t168 = *((unsigned int *)t159);
    t169 = (t167 | t168);
    t170 = (~(t169));
    t171 = (t166 & t170);
    if (t171 != 0)
        goto LAB48;

LAB45:    if (t169 != 0)
        goto LAB47;

LAB46:    *((unsigned int *)t157) = 1;

LAB48:    t173 = (t0 + 1528U);
    t174 = *((char **)t173);
    t173 = ((char*)((ng2)));
    memset(t175, 0, 8);
    t176 = (t174 + 4);
    t177 = (t173 + 4);
    t178 = *((unsigned int *)t174);
    t179 = *((unsigned int *)t173);
    t180 = (t178 ^ t179);
    t181 = *((unsigned int *)t176);
    t182 = *((unsigned int *)t177);
    t183 = (t181 ^ t182);
    t184 = (t180 | t183);
    t185 = *((unsigned int *)t176);
    t186 = *((unsigned int *)t177);
    t187 = (t185 | t186);
    t188 = (~(t187));
    t189 = (t184 & t188);
    if (t189 != 0)
        goto LAB52;

LAB49:    if (t187 != 0)
        goto LAB51;

LAB50:    *((unsigned int *)t175) = 1;

LAB52:    t192 = *((unsigned int *)t157);
    t193 = *((unsigned int *)t175);
    t194 = (t192 & t193);
    *((unsigned int *)t191) = t194;
    t195 = (t157 + 4);
    t196 = (t175 + 4);
    t197 = (t191 + 4);
    t198 = *((unsigned int *)t195);
    t199 = *((unsigned int *)t196);
    t200 = (t198 | t199);
    *((unsigned int *)t197) = t200;
    t201 = *((unsigned int *)t197);
    t202 = (t201 != 0);
    if (t202 == 1)
        goto LAB53;

LAB54:
LAB55:    memset(t154, 0, 8);
    t223 = (t191 + 4);
    t224 = *((unsigned int *)t223);
    t225 = (~(t224));
    t226 = *((unsigned int *)t191);
    t227 = (t226 & t225);
    t228 = (t227 & 1U);
    if (t228 != 0)
        goto LAB56;

LAB57:    if (*((unsigned int *)t223) != 0)
        goto LAB58;

LAB59:    t230 = (t154 + 4);
    t231 = *((unsigned int *)t154);
    t232 = *((unsigned int *)t230);
    t233 = (t231 || t232);
    if (t233 > 0)
        goto LAB60;

LAB61:    t237 = *((unsigned int *)t154);
    t238 = (~(t237));
    t239 = *((unsigned int *)t230);
    t240 = (t238 || t239);
    if (t240 > 0)
        goto LAB62;

LAB63:    if (*((unsigned int *)t230) > 0)
        goto LAB64;

LAB65:    if (*((unsigned int *)t154) > 0)
        goto LAB66;

LAB67:    memcpy(t153, t241, 8);

LAB68:    goto LAB39;

LAB40:    xsi_vlog_unsigned_bit_combine(t40, 32, t148, 32, t153, 32);
    goto LAB44;

LAB42:    memcpy(t40, t148, 8);
    goto LAB44;

LAB47:    t172 = (t157 + 4);
    *((unsigned int *)t157) = 1;
    *((unsigned int *)t172) = 1;
    goto LAB48;

LAB51:    t190 = (t175 + 4);
    *((unsigned int *)t175) = 1;
    *((unsigned int *)t190) = 1;
    goto LAB52;

LAB53:    t203 = *((unsigned int *)t191);
    t204 = *((unsigned int *)t197);
    *((unsigned int *)t191) = (t203 | t204);
    t205 = (t157 + 4);
    t206 = (t175 + 4);
    t207 = *((unsigned int *)t157);
    t208 = (~(t207));
    t209 = *((unsigned int *)t205);
    t210 = (~(t209));
    t211 = *((unsigned int *)t175);
    t212 = (~(t211));
    t213 = *((unsigned int *)t206);
    t214 = (~(t213));
    t215 = (t208 & t210);
    t216 = (t212 & t214);
    t217 = (~(t215));
    t218 = (~(t216));
    t219 = *((unsigned int *)t197);
    *((unsigned int *)t197) = (t219 & t217);
    t220 = *((unsigned int *)t197);
    *((unsigned int *)t197) = (t220 & t218);
    t221 = *((unsigned int *)t191);
    *((unsigned int *)t191) = (t221 & t217);
    t222 = *((unsigned int *)t191);
    *((unsigned int *)t191) = (t222 & t218);
    goto LAB55;

LAB56:    *((unsigned int *)t154) = 1;
    goto LAB59;

LAB58:    t229 = (t154 + 4);
    *((unsigned int *)t154) = 1;
    *((unsigned int *)t229) = 1;
    goto LAB59;

LAB60:    t234 = (t0 + 1048U);
    t235 = *((char **)t234);
    t234 = ((char*)((ng1)));
    memset(t236, 0, 8);
    xsi_vlog_unsigned_add(t236, 32, t235, 32, t234, 32);
    goto LAB61;

LAB62:    t243 = (t0 + 1688U);
    t244 = *((char **)t243);
    t243 = ((char*)((ng5)));
    memset(t245, 0, 8);
    t246 = (t244 + 4);
    t247 = (t243 + 4);
    t248 = *((unsigned int *)t244);
    t249 = *((unsigned int *)t243);
    t250 = (t248 ^ t249);
    t251 = *((unsigned int *)t246);
    t252 = *((unsigned int *)t247);
    t253 = (t251 ^ t252);
    t254 = (t250 | t253);
    t255 = *((unsigned int *)t246);
    t256 = *((unsigned int *)t247);
    t257 = (t255 | t256);
    t258 = (~(t257));
    t259 = (t254 & t258);
    if (t259 != 0)
        goto LAB72;

LAB69:    if (t257 != 0)
        goto LAB71;

LAB70:    *((unsigned int *)t245) = 1;

LAB72:    memset(t242, 0, 8);
    t261 = (t245 + 4);
    t262 = *((unsigned int *)t261);
    t263 = (~(t262));
    t264 = *((unsigned int *)t245);
    t265 = (t264 & t263);
    t266 = (t265 & 1U);
    if (t266 != 0)
        goto LAB73;

LAB74:    if (*((unsigned int *)t261) != 0)
        goto LAB75;

LAB76:    t268 = (t242 + 4);
    t269 = *((unsigned int *)t242);
    t270 = *((unsigned int *)t268);
    t271 = (t269 || t270);
    if (t271 > 0)
        goto LAB77;

LAB78:    t285 = *((unsigned int *)t242);
    t286 = (~(t285));
    t287 = *((unsigned int *)t268);
    t288 = (t286 || t287);
    if (t288 > 0)
        goto LAB79;

LAB80:    if (*((unsigned int *)t268) > 0)
        goto LAB81;

LAB82:    if (*((unsigned int *)t242) > 0)
        goto LAB83;

LAB84:    memcpy(t241, t289, 8);

LAB85:    goto LAB63;

LAB64:    xsi_vlog_unsigned_bit_combine(t153, 32, t236, 32, t241, 32);
    goto LAB68;

LAB66:    memcpy(t153, t236, 8);
    goto LAB68;

LAB71:    t260 = (t245 + 4);
    *((unsigned int *)t245) = 1;
    *((unsigned int *)t260) = 1;
    goto LAB72;

LAB73:    *((unsigned int *)t242) = 1;
    goto LAB76;

LAB75:    t267 = (t242 + 4);
    *((unsigned int *)t242) = 1;
    *((unsigned int *)t267) = 1;
    goto LAB76;

LAB77:    t273 = ((char*)((ng2)));
    t274 = (t0 + 1208U);
    t275 = *((char **)t274);
    t274 = (t0 + 1048U);
    t277 = *((char **)t274);
    memset(t276, 0, 8);
    t274 = (t276 + 4);
    t278 = (t277 + 4);
    t279 = *((unsigned int *)t277);
    t280 = (t279 >> 28);
    *((unsigned int *)t276) = t280;
    t281 = *((unsigned int *)t278);
    t282 = (t281 >> 28);
    *((unsigned int *)t274) = t282;
    t283 = *((unsigned int *)t276);
    *((unsigned int *)t276) = (t283 & 15U);
    t284 = *((unsigned int *)t274);
    *((unsigned int *)t274) = (t284 & 15U);
    xsi_vlogtype_concat(t272, 32, 32, 3U, t276, 4, t275, 26, t273, 2);
    goto LAB78;

LAB79:    t291 = (t0 + 1688U);
    t292 = *((char **)t291);
    t291 = ((char*)((ng6)));
    memset(t293, 0, 8);
    t294 = (t292 + 4);
    t295 = (t291 + 4);
    t296 = *((unsigned int *)t292);
    t297 = *((unsigned int *)t291);
    t298 = (t296 ^ t297);
    t299 = *((unsigned int *)t294);
    t300 = *((unsigned int *)t295);
    t301 = (t299 ^ t300);
    t302 = (t298 | t301);
    t303 = *((unsigned int *)t294);
    t304 = *((unsigned int *)t295);
    t305 = (t303 | t304);
    t306 = (~(t305));
    t307 = (t302 & t306);
    if (t307 != 0)
        goto LAB89;

LAB86:    if (t305 != 0)
        goto LAB88;

LAB87:    *((unsigned int *)t293) = 1;

LAB89:    memset(t290, 0, 8);
    t309 = (t293 + 4);
    t310 = *((unsigned int *)t309);
    t311 = (~(t310));
    t312 = *((unsigned int *)t293);
    t313 = (t312 & t311);
    t314 = (t313 & 1U);
    if (t314 != 0)
        goto LAB90;

LAB91:    if (*((unsigned int *)t309) != 0)
        goto LAB92;

LAB93:    t316 = (t290 + 4);
    t317 = *((unsigned int *)t290);
    t318 = *((unsigned int *)t316);
    t319 = (t317 || t318);
    if (t319 > 0)
        goto LAB94;

LAB95:    t322 = *((unsigned int *)t290);
    t323 = (~(t322));
    t324 = *((unsigned int *)t316);
    t325 = (t323 || t324);
    if (t325 > 0)
        goto LAB96;

LAB97:    if (*((unsigned int *)t316) > 0)
        goto LAB98;

LAB99:    if (*((unsigned int *)t290) > 0)
        goto LAB100;

LAB101:    memcpy(t289, t327, 8);

LAB102:    goto LAB80;

LAB81:    xsi_vlog_unsigned_bit_combine(t241, 32, t272, 32, t289, 32);
    goto LAB85;

LAB83:    memcpy(t241, t272, 8);
    goto LAB85;

LAB88:    t308 = (t293 + 4);
    *((unsigned int *)t293) = 1;
    *((unsigned int *)t308) = 1;
    goto LAB89;

LAB90:    *((unsigned int *)t290) = 1;
    goto LAB93;

LAB92:    t315 = (t290 + 4);
    *((unsigned int *)t290) = 1;
    *((unsigned int *)t315) = 1;
    goto LAB93;

LAB94:    t320 = (t0 + 1368U);
    t321 = *((char **)t320);
    goto LAB95;

LAB96:    t320 = (t0 + 1048U);
    t326 = *((char **)t320);
    t320 = ((char*)((ng1)));
    memset(t327, 0, 8);
    xsi_vlog_unsigned_add(t327, 32, t326, 32, t320, 32);
    goto LAB97;

LAB98:    xsi_vlog_unsigned_bit_combine(t289, 32, t321, 32, t327, 32);
    goto LAB102;

LAB100:    memcpy(t289, t321, 8);
    goto LAB102;

}


extern void work_m_09828512899032434031_0757879789_init()
{
	static char *pe[] = {(void *)Cont_31_0,(void *)Cont_32_1};
	xsi_register_didat("work_m_09828512899032434031_0757879789", "isim/tb_isim_beh.exe.sim/work/m_09828512899032434031_0757879789.didat");
	xsi_register_executes(pe);
}
