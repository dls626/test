%%�������Ե�Ƶ�źŵ�Ƶ��%%
clear all; clc; close all;
%%������������
B=40e6;fs=1.5*B;Tp=10e-6;         %--����HZ��������Ƶ�ʣ�HZ���������ȣ�s��
mu=B/Tp;Ts=1/fs;N=ceil(Tp/Ts);    %--��Ƶб�ʣ�HZ/s��������ʱ������s������������
t=([0:N-1]-ceil(N/2))*Ts;         %--ʱ�������s��
f=([0:N-1]-ceil(N/2))/N*fs;       %--Ƶ�ʱ�����HZ��
SNR=20;am_n=1;am_s=am_n.*10^(SNR/20);  %--SNR(dB)���������ȡ��źŷ���
noise=am_n/sqrt(2)*(randn(1,N)+j*randn(1,N));  %���������ź�
s_t=am_s*exp(j*pi*mu*t.^2)+0;      %--�����źż�����
S_f=fftshift(fft(s_t));

figure(1);plot(f,abs(S_f));grid on;
%%��������ѹ������
H_match=exp(j*pi*f.^2/mu);      %--��Ƶ������ƥ���˲�����
S_f_match=S_f.*H_match;         %--��Ƶ�����ƥ���˲�
%%s_t_match=ifftshift(ifft(S_f_match));  %--����ѹ���������Ŀ��+�ź�����
s_t_match=(ifft(S_f_match));

figure(2);plot(t,abs(s_t_match));grid on;
xlabel('time(s)');ylabel('amplitude');xlim([min(t) max(t)]);
disp(['�ò����µ�ʱ������Ϊ��',num2str(B*Tp)])

figure(3);plot(t,abs(s_t));grid on;
xlabel('time(s)');ylabel('amplitude');

S_f_match_1=S_f.*(conj(S_f));
figure(4);plot(t,abs(ifftshift(ifft(S_f_match_1))));grid on;
xlabel('time(s)');ylabel('amplitude');