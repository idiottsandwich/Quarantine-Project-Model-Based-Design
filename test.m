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
damp_rear_vec = linspace(1000, 8000, 10);
damp_front_vec = linspace(1000,8000, 10);

% rear denominator polynomial coefficients 
% assumes chassis front corner is a 1-DOF spring mass system 
for nr=1:10
rear_den(nr,:) = [1 damp_rear_vec(nr)/mc sr/mc];
end

% front denominator polynomial coefficients
for nf=1:10
den(nf,:) = [1 damp_front_vec(nf)/mc sf/mc];
end

%plot rear
figure(1)
for nsr = 1:length(damp_rear_vec)
system(nsr,:) = [tf(num,rear_den(nsr,:))];
step(0.025 * system(nsr,:));
hold on
end
title('Rear Suspension Step Response, OHLINS TTX25 C12 Valve, k = 43N/mm')
grid on

%plot front
figure(2)
for nsf = 1:length(damp_front_vec)
system_f(nsf,:) = [tf(num,den(nsf,:))];
step(0.0254 * system_f(nsf,:))
hold on
end
grid on
title('Front Suspension Step Response, OHLINS TTX25 C12 Valve, k = 26 N/mm')