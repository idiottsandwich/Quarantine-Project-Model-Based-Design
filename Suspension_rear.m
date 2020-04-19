% Suspension_rear.m
% v0.1
% April 18,2020
% Just learning how to use MATLAB for controls 
%--------------------------------------------------------------------------
% This code is intended to be a open source demo 
% and is to be used for educational purposes only. 
% Suggestions/constructive criticisms are welcome. 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
% CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
% IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
% WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL COPYRIGHT HOLDER
% OR CONTRIBUTORS BE LIABLE FOR ANY
% DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
% OR CONSEQUENTIAL DAMAGES(INCLUDING, BUT NOT LIMITED TO,
% PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
% LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
% HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
% WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
% (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
% ANY WAY OUT OF THE USE OF THIS
% SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%-------------------------------------------------------------------------

% this code uses tf (transfer function) from the control system toolbox to
% model the step response of a FSAE car front and rear suspension
num = 1;
bump_t = 0.0254;
mc = 87; % car corner mass in kg
sr = 43781; % spring rate in N/mm, rear
sf = 26269; % spring rate in N/mm, front

% suspension dampers have adjustable damping rates -- demo runs through 5
% different step responses 
damp_rear_vec = linspace(2168, 6024, 5);
damp_front_vec = linspace(2168,6024, 5);

% rear denominator polynomial coefficients 
% assumes chassis front corner is a 1-DOF spring mass system 
rear_den_1 = [1 damp_rear_vec(1)/mc sr/mc];
rear_den_2 = [1 damp_rear_vec(2)/mc sr/mc];
rear_den_3 = [1 damp_rear_vec(3)/mc sr/mc];
rear_den_4 = [1 damp_rear_vec(4)/mc sr/mc];
rear_den_5 = [1 damp_rear_vec(5)/mc sr/mc];

% front denominator polynomial coefficients
den_1 = [1 damp_front_vec(1)/mc sf/mc];
den_5 = [1 damp_front_vec(5)/mc sf/mc];

%plot rear
figure(1)
system_1 = tf(num,rear_den_1);
system_2 = tf(num, rear_den_2);
system_3 = tf(num, rear_den_3);
system_4 = tf(num, rear_den_4);
system_5 = tf(num, rear_den_5);
subplot(5,1,1)
step(0.0254 * system_1)
grid on
title('Rear Suspension Step Response, OHLINS TTX25 C12 Valve, varying damping, low to high, k = 43N/mm')
subplot(5,1,2)
step(0.025 * system_2)
title('2')
grid on
subplot(5,1,3)
step(0.025 * system_3)
title('3')
grid on
subplot(5,1,4)
step(0.025 * system_4)
title('4')
grid on
subplot(5,1,5)
step(0.025 * system_5)
title('High')
grid on

%plot front
figure(2)
system_6 = tf(num,den_1);
system_7 = tf(num, den_5);
subplot(2,1,1)
step(0.0254 * system_6)
grid on
title('Front Suspension Step Response, OHLINS TTX25 C12 Valve, Low damping, k = 26 N/mm')
subplot(2,1,2)
step(0.0254 * system_7)
grid on
title('Front Suspension Step Response, OHLINS TTX25 C12 Damping, C12 Valve, High damping, k = 26 N/mm')
