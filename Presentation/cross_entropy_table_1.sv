module cross_entropy_table_1(input logic [11:0] in,
	 output logic [12:0] out);
	 	 always_comb
	 	 	 if (in >= 0 && in <= 2047) out = 1;
	 	 	 else if (in >= 2048 && in <= 2730) out = 2;
	 	 	 else if (in >= 2731 && in <= 3071) out = 3;
	 	 	 else if (in >= 3072 && in <= 3276) out = 4;
	 	 	 else if (in >= 3277 && in <= 3413) out = 5;
	 	 	 else if (in >= 3414 && in <= 3510) out = 6;
	 	 	 else if (in >= 3511 && in <= 3583) out = 7;
	 	 	 else if (in >= 3584 && in <= 3640) out = 8;
	 	 	 else if (in >= 3641 && in <= 3686) out = 9;
	 	 	 else if (in >= 3687 && in <= 3723) out = 10;
	 	 	 else if (in >= 3724 && in <= 3754) out = 11;
	 	 	 else if (in >= 3755 && in <= 3780) out = 12;
	 	 	 else if (in >= 3781 && in <= 3803) out = 13;
	 	 	 else if (in >= 3804 && in <= 3822) out = 14;
	 	 	 else if (in >= 3823 && in <= 3839) out = 15;
	 	 	 else if (in >= 3840 && in <= 3855) out = 16;
	 	 	 else if (in >= 3856 && in <= 3868) out = 17;
	 	 	 else if (in >= 3869 && in <= 3880) out = 18;
	 	 	 else if (in >= 3881 && in <= 3891) out = 19;
	 	 	 else if (in >= 3892 && in <= 3900) out = 20;
	 	 	 else if (in >= 3901 && in <= 3909) out = 21;
	 	 	 else if (in >= 3910 && in <= 3917) out = 22;
	 	 	 else if (in >= 3918 && in <= 3925) out = 23;
	 	 	 else if (in >= 3926 && in <= 3932) out = 24;
	 	 	 else if (in >= 3933 && in <= 3938) out = 25;
	 	 	 else if (in >= 3939 && in <= 3944) out = 26;
	 	 	 else if (in >= 3945 && in <= 3949) out = 27;
	 	 	 else if (in >= 3950 && in <= 3954) out = 28;
	 	 	 else if (in >= 3955 && in <= 3959) out = 29;
	 	 	 else if (in >= 3960 && in <= 3963) out = 30;
	 	 	 else if (in >= 3964 && in <= 3967) out = 31;
	 	 	 else if (in >= 3968 && in <= 3971) out = 32;
	 	 	 else if (in >= 3972 && in <= 3975) out = 33;
	 	 	 else if (in >= 3976 && in <= 3978) out = 34;
	 	 	 else if (in >= 3979 && in <= 3982) out = 35;
	 	 	 else if (in >= 3983 && in <= 3985) out = 36;
	 	 	 else if (in >= 3986 && in <= 3988) out = 37;
	 	 	 else if (in >= 3989 && in <= 3990) out = 38;
	 	 	 else if (in >= 3991 && in <= 3993) out = 39;
	 	 	 else if (in >= 3994 && in <= 3996) out = 40;
	 	 	 else if (in >= 3997 && in <= 3998) out = 41;
	 	 	 else if (in >= 3999 && in <= 4000) out = 42;
	 	 	 else if (in >= 4001 && in <= 4002) out = 43;
	 	 	 else if (in >= 4003 && in <= 4004) out = 44;
	 	 	 else if (in >= 4005 && in <= 4006) out = 45;
	 	 	 else if (in >= 4007 && in <= 4008) out = 46;
	 	 	 else if (in >= 4009 && in <= 4010) out = 47;
	 	 	 else if (in >= 4011 && in <= 4012) out = 48;
	 	 	 else if (in >= 4013 && in <= 4014) out = 49;
	 	 	 else if (in >= 4015 && in <= 4015) out = 50;
	 	 	 else if (in >= 4016 && in <= 4017) out = 51;
	 	 	 else if (in >= 4018 && in <= 4018) out = 52;
	 	 	 else if (in >= 4019 && in <= 4020) out = 53;
	 	 	 else if (in >= 4021 && in <= 4021) out = 54;
	 	 	 else if (in >= 4022 && in <= 4022) out = 55;
	 	 	 else if (in >= 4023 && in <= 4024) out = 56;
	 	 	 else if (in >= 4025 && in <= 4025) out = 57;
	 	 	 else if (in >= 4026 && in <= 4026) out = 58;
	 	 	 else if (in >= 4027 && in <= 4027) out = 59;
	 	 	 else if (in >= 4028 && in <= 4028) out = 60;
	 	 	 else if (in >= 4029 && in <= 4029) out = 61;
	 	 	 else if (in >= 4030 && in <= 4030) out = 62;
	 	 	 else if (in >= 4031 && in <= 4031) out = 63;
	 	 	 else if (in >= 4032 && in <= 4032) out = 64;
	 	 	 else if (in >= 4033 && in <= 4033) out = 65;
	 	 	 else if (in >= 4034 && in <= 4034) out = 66;
	 	 	 else if (in >= 4035 && in <= 4035) out = 67;
	 	 	 else if (in >= 4036 && in <= 4036) out = 68;
	 	 	 else if (in >= 4037 && in <= 4037) out = 69;
	 	 	 else if (in >= 4038 && in <= 4038) out = 70;
	 	 	 else if (in >= 4039 && in <= 4039) out = 71;
	 	 	 else if (in >= 4040 && in <= 4040) out = 73;
	 	 	 else if (in >= 4041 && in <= 4041) out = 74;
	 	 	 else if (in >= 4042 && in <= 4042) out = 75;
	 	 	 else if (in >= 4043 && in <= 4043) out = 77;
	 	 	 else if (in >= 4044 && in <= 4044) out = 78;
	 	 	 else if (in >= 4045 && in <= 4045) out = 80;
	 	 	 else if (in >= 4046 && in <= 4046) out = 81;
	 	 	 else if (in >= 4047 && in <= 4047) out = 83;
	 	 	 else if (in >= 4048 && in <= 4048) out = 85;
	 	 	 else if (in >= 4049 && in <= 4049) out = 87;
	 	 	 else if (in >= 4050 && in <= 4050) out = 89;
	 	 	 else if (in >= 4051 && in <= 4051) out = 91;
	 	 	 else if (in >= 4052 && in <= 4052) out = 93;
	 	 	 else if (in >= 4053 && in <= 4053) out = 95;
	 	 	 else if (in >= 4054 && in <= 4054) out = 97;
	 	 	 else if (in >= 4055 && in <= 4055) out = 99;
	 	 	 else if (in >= 4056 && in <= 4056) out = 102;
	 	 	 else if (in >= 4057 && in <= 4057) out = 105;
	 	 	 else if (in >= 4058 && in <= 4058) out = 107;
	 	 	 else if (in >= 4059 && in <= 4059) out = 110;
	 	 	 else if (in >= 4060 && in <= 4060) out = 113;
	 	 	 else if (in >= 4061 && in <= 4061) out = 117;
	 	 	 else if (in >= 4062 && in <= 4062) out = 120;
	 	 	 else if (in >= 4063 && in <= 4063) out = 124;
	 	 	 else if (in >= 4064 && in <= 4064) out = 128;
	 	 	 else if (in >= 4065 && in <= 4065) out = 132;
	 	 	 else if (in >= 4066 && in <= 4066) out = 136;
	 	 	 else if (in >= 4067 && in <= 4067) out = 141;
	 	 	 else if (in >= 4068 && in <= 4068) out = 146;
	 	 	 else if (in >= 4069 && in <= 4069) out = 151;
	 	 	 else if (in >= 4070 && in <= 4070) out = 157;
	 	 	 else if (in >= 4071 && in <= 4071) out = 163;
	 	 	 else if (in >= 4072 && in <= 4072) out = 170;
	 	 	 else if (in >= 4073 && in <= 4073) out = 178;
	 	 	 else if (in >= 4074 && in <= 4074) out = 186;
	 	 	 else if (in >= 4075 && in <= 4075) out = 195;
	 	 	 else if (in >= 4076 && in <= 4076) out = 204;
	 	 	 else if (in >= 4077 && in <= 4077) out = 215;
	 	 	 else if (in >= 4078 && in <= 4078) out = 227;
	 	 	 else if (in >= 4079 && in <= 4079) out = 240;
	 	 	 else if (in >= 4080 && in <= 4080) out = 256;
	 	 	 else if (in >= 4081 && in <= 4081) out = 273;
	 	 	 else if (in >= 4082 && in <= 4082) out = 292;
	 	 	 else if (in >= 4083 && in <= 4083) out = 315;
	 	 	 else if (in >= 4084 && in <= 4084) out = 341;
	 	 	 else if (in >= 4085 && in <= 4085) out = 372;
	 	 	 else if (in >= 4086 && in <= 4086) out = 409;
	 	 	 else if (in >= 4087 && in <= 4087) out = 455;
	 	 	 else if (in >= 4088 && in <= 4088) out = 512;
	 	 	 else if (in >= 4089 && in <= 4089) out = 585;
	 	 	 else if (in >= 4090 && in <= 4090) out = 682;
	 	 	 else if (in >= 4091 && in <= 4091) out = 819;
	 	 	 else if (in >= 4092 && in <= 4092) out = 1024;
	 	 	 else if (in >= 4093 && in <= 4093) out = 1365;
	 	 	 else if (in >= 4094 && in <= 4094) out = 2048;
	 	 	 else if (in >= 4095 && in <= 4095) out = 4096;
	 	 	else out=4096;
	 endmodule
