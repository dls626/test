%%测试线性调频信号的频谱%%
clear all; clc; close all;
%%基本参数设置
B=40e6;fs=1.5*B;Tp=10e-6;         %--带宽（HZ）、采样频率（HZ）、脉冲宽度（s）
mu=B/Tp;Ts=1/fs;N=ceil(Tp/Ts);    %--调频斜率（HZ/s）、采样时间间隔（s）、采样点数
t=([0:N-1]-ceil(N/2))*Ts;         %--时间变量（s）
f=([0:N-1]-ceil(N/2))/N*fs;       %--频率变量（HZ）
SNR=20;am_n=1;am_s=am_n.*10^(SNR/20);  %--SNR(dB)、噪声幅度、信号幅度
noise=am_n/sqrt(2)*(randn(1,N)+j*randn(1,N));  %产生噪声信号
s_t=am_s*exp(j*pi*mu*t.^2)+0;      %--产生信号加噪声
S_f=fftshift(fft(s_t));

figure(1);plot(f,abs(S_f));grid on;
%%距离脉冲压缩处理
H_match=exp(j*pi*f.^2/mu);      %--在频域设置匹配滤波函数
S_f_match=S_f.*H_match;         %--在频域进行匹配滤波
%%s_t_match=ifftshift(ifft(S_f_match));  %--脉冲压缩后产生的目标+信号噪声
s_t_match=(ifft(S_f_match));

figure(2);plot(t,abs(s_t_match));grid on;
xlabel('time(s)');ylabel('amplitude');xlim([min(t) max(t)]);
disp(['该参数下的时宽带宽积为：',num2str(B*Tp)])

figure(3);plot(t,abs(s_t));grid on;
xlabel('time(s)');ylabel('amplitude');

S_f_match_1=S_f.*(conj(S_f));
figure(4);plot(t,abs(ifftshift(ifft(S_f_match_1))));grid on;
xlabel('time(s)');ylabel('amplitude');